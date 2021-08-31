#!/bin/bash

curl https://people.freedesktop.org/~agd5f/radeon_ucode/gs/green_sardine_asd.bin -o green_sardine_asd.bin
curl https://people.freedesktop.org/~agd5f/radeon_ucode/gs/green_sardine_ce.bin -o green_sardine_ce.bin
curl https://people.freedesktop.org/~agd5f/radeon_ucode/gs/green_sardine_dmcub.bin -o green_sardine_dmcub.bin
curl https://people.freedesktop.org/~agd5f/radeon_ucode/gs/green_sardine_me.bin -o green_sardine_me.bin
curl https://people.freedesktop.org/~agd5f/radeon_ucode/gs/green_sardine_mec.bin -o green_sardine_mec.bin
curl https://people.freedesktop.org/~agd5f/radeon_ucode/gs/green_sardine_mec2.bin -o green_sardine_mec2.bin
curl https://people.freedesktop.org/~agd5f/radeon_ucode/gs/green_sardine_pfp.bin -o green_sardine_pfp.bin
curl https://people.freedesktop.org/~agd5f/radeon_ucode/gs/green_sardine_rlc.bin -o green_sardine_rlc.bin
curl https://people.freedesktop.org/~agd5f/radeon_ucode/gs/green_sardine_sdma.bin -o green_sardine_sdma.bin
curl https://people.freedesktop.org/~agd5f/radeon_ucode/gs/green_sardine_ta.bin -o green_sardine_ta.bin
curl https://people.freedesktop.org/~agd5f/radeon_ucode/gs/green_sardine_vcn.bin -o green_sardine_vcn.bin
sudo cp ./*.bin /lib/firmware/amdgpu

# Assumes kernel is 5.11.0-31
ASSUMED_KERNEL_VERSION="5.11.0-31"
sudo wget https://raw.githubusercontent.com/torvalds/linux/master/scripts/module.lds.S -O /usr/src/linux-headers-$ASSUMED_KERNEL_VERSION-generic/scripts/module.lds
sudo sed -i '$ d' /usr/src/linux-headers-$ASSUMED_KERNEL_VERSION-generic/scripts/module.lds
sudo update-initramfs -u

rm green_sardine_asd.bin
rm green_sardine_ce.bin
rm green_sardine_dmcub.bin
rm green_sardine_me.bin
rm green_sardine_mec.bin
rm green_sardine_mec2.bin
rm green_sardine_pfp.bin
rm green_sardine_rlc.bin
rm green_sardine_sdma.bin
rm green_sardine_ta.bin
rm green_sardine_vcn.bin
