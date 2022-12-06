# NAS Ansible
NAS deployment playbook built for Debian 11.

Port 80 must be forwarded before running `make install` to allow container services to obtain Let's Encrypt certificates.

**IMPORTANT!!**

DO NOT forward port 443 until container services have been fully configured. Otherwise an attacker could configure the initial admin account.

1. `make deps` to install playbook dependencies
2. `make encrypt_string` to encrypt Samba passwords for `hosts.yml`
3. Update variables in `hosts.yml`
4. Update variables in `vault.yml`
5. `make vault` to encrypt `vault.yml`
6. `make zfs` to install ZFS
7. Create/import ZFS pool ensure `zpool`, `zfs_dataset`, and `zfs_mountpoint` values in `hosts.yml` are correct
8. `make install` to run playbook

# ZFS
## Create Pool 
```
zpool create pool0 raidz2 /dev/sdb /dev/sdc /dev/sdd /dev/sde
```

## Create Encrypted Dataset
```
zfs create -o encryption=on -o keylocation=prompt -o keyformat=passphrase -o compression=lz4 -o mountpoint=/pool0/encrypted pool0/encrypted
```

## Verify Dataset Settings
```
zfs list -o encryption,compression,mountpoint
```

## Remount Encrypted Dataset after Reboot
```
zfs mount -l pool0/encrypted
```
