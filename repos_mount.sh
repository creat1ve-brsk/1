#!/bin/bash

mount -o loop /opt/iso/devel-smolensk-1.6-09.07.2019_14.19.iso /mnt/iso
rsync -a --progress /mnt/iso/ /opt/repo/smolensk-dev/
umount /mnt/iso

mount -o loop /opt/iso/20210730SE16.iso /mnt/iso
rsync -a --progress /mnt/iso/ /opt/repo/smolensk-upd/
umount /mnt/iso

mount -o loop /opt/iso/repository-update-dev.iso /mnt/iso
rsync -a --progress /mnt/iso/ /opt/repo/smolensk-dev-upd/
umount /mnt/iso
