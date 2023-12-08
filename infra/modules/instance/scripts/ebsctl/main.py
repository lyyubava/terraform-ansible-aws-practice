#!/usr/bin/python3

import argparse
import json
import pathlib
import re
import subprocess
import time

params_type = {"--volume_id": str, "--mountpoint": str,
               "--mkfs": str,
               "--label": str, "--dry_run": bool}


def parse_args():
    parser = argparse.ArgumentParser()
    for param, type_ in params_type.items():
        if param != "--dry_run":
            parser.add_argument(param, type=type_, required=True)
        else:
            parser.add_argument(param, type=type_, default=False)
    args = parser.parse_args()
    return args


def volume_id_to_devpath(vol_id):
    """Resolving volume id to devpath."""
    while True:
        try:
            nvme_list = subprocess.check_output(
                ["nvme", "list", "--output-format=json"])
        except subprocess.CalledProcessError:
            raise subprocess.CalledProcessError(
                "Command 'nvme list --output-format=json' returned non-zero status")

        nvme_json = json.loads(nvme_list.decode("utf-8"))

        for device in nvme_json["Devices"]:
            if device["SerialNumber"] == vol_id.replace("-", ""):
                return device["DevicePath"]
        time.sleep(1)


def get_volume_info(vol_id):
    devpath = volume_id_to_devpath(vol_id)
    vol_info = dict()
    while True:
        try:
            info = subprocess.check_output(
                ["blkid", "--probe", "--output", "export", devpath])

        # If output is empty.
        except subprocess.CalledProcessError:
            return vol_info

        for i in info.decode().splitlines():
            key, val = i.split("=", 2)
            vol_info[key] = val
        return vol_info


def create_fs(vol_id, mkfs, label, dry_run):
    """Creation of filesystem with given label and type. Type and label are mandatory arguments."""
    devpath = volume_id_to_devpath(vol_id)
    vol_info = get_volume_info(vol_id)
    info_label = vol_info.get("LABEL", None)
    info_type = vol_info.get("TYPE", None)
    if info_label and info_type:
        if mkfs == vol_info["TYPE"] and label == vol_info["LABEL"]:
            return
    if dry_run:
        print(f"running command 'mkfs -t {mkfs} -L {label} {devpath}'")
        return
    subprocess.check_output(["mkfs", "-t", mkfs, "-L", label, devpath])


def write_fstab(new_entry, dry_run):
    new_fstab = []
    already_exists = False

    fstab_entries = pathlib.Path("/etc/fstab").read_text().splitlines()
    curr = pathlib.Path("/etc/fstab")

    for entry in fstab_entries:
        # If not a comment, newline and in fact matches our new entry, flip flag.
        if not re.match(r"^(#|\s|$)", entry) and re.split(r"\s+", entry) == new_entry:
            already_exists = True

        # Append keeping the order.
        new_fstab.append(entry)

    if not already_exists:
        new_fstab.append(" ".join(new_entry))

    if dry_run:
        if not already_exists:
            print(f"writing {new_fstab[-1]}")
        return

    curr.write_text("\n".join(new_fstab))


def mount(mountpoint, vol_id, dry_run):
    devpath = volume_id_to_devpath(vol_id)
    if dry_run:
        print(f"running command 'mount {devpath} {mountpoint}'")
        return

    pathlib.Path(mountpoint).mkdir(exist_ok=True)
    subprocess.run(["mount", devpath, mountpoint],
                   stdout=subprocess.PIPE)


def main():
    args = parse_args()
    if not re.match("vol-[a-z0-9]+", args.volume_id):
        raise argparse.ArgumentTypeError(
            f"{args.volume_id} doesn't match patterns vol-[a-z0-9]+")
    elif args.mkfs not in ["ext4", "xfs"]:
        raise argparse.ArgumentTypeError(
            f"{args.mkfs} doesn't match patterns ['ext4', 'xfs']")

    create_fs(args.volume_id, args.mkfs, args.label, args.dry_run)
    mount(args.mountpoint, args.volume_id, args.dry_run)
    write_fstab([f"LABEL={args.label}", args.mountpoint,
                 args.mkfs, "defaults", "0", "0"], args.dry_run)


if __name__ == "__main__":
    main()
