traefik_instance =  {
    name = "traefik"
    create_ec2_security_group = true
    ssh_keys = ["ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDLo0ycyXJD0D1z55zP4ZPr2iuQWUqKT6D6goTS3g/238wR81A5TpxLDmCUsfK7WjbGVKUXv/CorUIJyNFomqqdx9ds8EQ1m1MzvV51DtmHY6jZOdJbooDRLMs+SbTYj8cK0FKCM5Kq0/tG2NKHKoTUieHRnMetg+Ju1JiARMEEI8HwRZzfCdgubBa8QbeQscIOX764I4oGV3SsPEt3b/4kf7qfjY22GEIJ5qBInpq1GUWKgm5eUX9tERaCUaMPiTycduNMY6fxeMvFV/lHeH/Xg1dPg0owx3+KX1qOJLE5eYP1KmhR0wa6nkFtGtm4C+hpNrrMMq0f2mKI2QU6+axxVbPZyneVYYvVqiOay0e5gEKbWL5iqg7AK3buct5gDg0DiYdmLY14zHOdus9SfWdZj09UTh6rZfVnvDI+Rzx4+yJ+oLItZv3MY7mLRzWZzPPLZy4aEmMcGkTYMvoihDD4L9iwSZ75bxlkOkZrAJaBqdr6fGWe77YNMXwZAPPUqwk= liubov.smahliuk"]
    instance_type = "t3.small"
    stateful = false
    attach_public_ip = true
}

wordpress_instance = {
    name = "wordpress"
    create_ec2_security_group = true
    ssh_keys = ["ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDLo0ycyXJD0D1z55zP4ZPr2iuQWUqKT6D6goTS3g/238wR81A5TpxLDmCUsfK7WjbGVKUXv/CorUIJyNFomqqdx9ds8EQ1m1MzvV51DtmHY6jZOdJbooDRLMs+SbTYj8cK0FKCM5Kq0/tG2NKHKoTUieHRnMetg+Ju1JiARMEEI8HwRZzfCdgubBa8QbeQscIOX764I4oGV3SsPEt3b/4kf7qfjY22GEIJ5qBInpq1GUWKgm5eUX9tERaCUaMPiTycduNMY6fxeMvFV/lHeH/Xg1dPg0owx3+KX1qOJLE5eYP1KmhR0wa6nkFtGtm4C+hpNrrMMq0f2mKI2QU6+axxVbPZyneVYYvVqiOay0e5gEKbWL5iqg7AK3buct5gDg0DiYdmLY14zHOdus9SfWdZj09UTh6rZfVnvDI+Rzx4+yJ+oLItZv3MY7mLRzWZzPPLZy4aEmMcGkTYMvoihDD4L9iwSZ75bxlkOkZrAJaBqdr6fGWe77YNMXwZAPPUqwk= liubov.smahliuk"]
    instance_type = "t3.small"
    stateful = true
    mountpoint = "/mnt/data"
}

ci_instance = {
    name = "ci"
    create_ec2_security_group = true
    ssh_keys = ["ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDLo0ycyXJD0D1z55zP4ZPr2iuQWUqKT6D6goTS3g/238wR81A5TpxLDmCUsfK7WjbGVKUXv/CorUIJyNFomqqdx9ds8EQ1m1MzvV51DtmHY6jZOdJbooDRLMs+SbTYj8cK0FKCM5Kq0/tG2NKHKoTUieHRnMetg+Ju1JiARMEEI8HwRZzfCdgubBa8QbeQscIOX764I4oGV3SsPEt3b/4kf7qfjY22GEIJ5qBInpq1GUWKgm5eUX9tERaCUaMPiTycduNMY6fxeMvFV/lHeH/Xg1dPg0owx3+KX1qOJLE5eYP1KmhR0wa6nkFtGtm4C+hpNrrMMq0f2mKI2QU6+axxVbPZyneVYYvVqiOay0e5gEKbWL5iqg7AK3buct5gDg0DiYdmLY14zHOdus9SfWdZj09UTh6rZfVnvDI+Rzx4+yJ+oLItZv3MY7mLRzWZzPPLZy4aEmMcGkTYMvoihDD4L9iwSZ75bxlkOkZrAJaBqdr6fGWe77YNMXwZAPPUqwk= liubov.smahliuk"]
    instance_type = "t3.small"
    stateful = true
    attach_public_ip = true
}

db_instance = {
    name = "database"
    create_ec2_security_group = true
    ssh_keys = ["ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDLo0ycyXJD0D1z55zP4ZPr2iuQWUqKT6D6goTS3g/238wR81A5TpxLDmCUsfK7WjbGVKUXv/CorUIJyNFomqqdx9ds8EQ1m1MzvV51DtmHY6jZOdJbooDRLMs+SbTYj8cK0FKCM5Kq0/tG2NKHKoTUieHRnMetg+Ju1JiARMEEI8HwRZzfCdgubBa8QbeQscIOX764I4oGV3SsPEt3b/4kf7qfjY22GEIJ5qBInpq1GUWKgm5eUX9tERaCUaMPiTycduNMY6fxeMvFV/lHeH/Xg1dPg0owx3+KX1qOJLE5eYP1KmhR0wa6nkFtGtm4C+hpNrrMMq0f2mKI2QU6+axxVbPZyneVYYvVqiOay0e5gEKbWL5iqg7AK3buct5gDg0DiYdmLY14zHOdus9SfWdZj09UTh6rZfVnvDI+Rzx4+yJ+oLItZv3MY7mLRzWZzPPLZy4aEmMcGkTYMvoihDD4L9iwSZ75bxlkOkZrAJaBqdr6fGWe77YNMXwZAPPUqwk= liubov.smahliuk"]
    instance_type = "t3.small"
    stateful = true
    mountpoint = "/mnt/data"
}
