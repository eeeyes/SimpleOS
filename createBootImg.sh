#!/bin/bash
source constants.sh
dd if=boot.bin of=a.img bs=512 count=1 conv=notrunc;
dd if=system.bin of=a.img bs=512 seek=1 count=$(((SYS_LEN_BYTES)/512)) conv=notrunc;
