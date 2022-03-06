#!/bin/bash

echo "### Building OS-84+ v$1"
[ -z "$1" ] && exit 1

echo "### Pre-build Cleanup"
rm -rf build
mkdir build

echo "### SPASM-NG"
spasm 00/base.asm build/Page-00.hex -DTI84Plus -DCPU15 -DUSB -DTOTALFLASH=64 '-DPRIVLEDGEDPAGE=$3C' -I 00
spasm privledged/base.asm build/Page-privledged.hex -DTI84Plus -DCPU15 -DUSB -DTOTALFLASH=64 '-DPRIVLEDGEDPAGE=$3C' -I 3C

echo "### MultiHex"
multihex 00 build/Page-00.hex 3C build/Page-privledged.hex > build/OS.hex

echo "### PyPackXXU"
pypackxxu build/OS.hex -o build/OS.8xu -t 84p -q 0A -v 0.01 -h 255

echo "### RabbitSign"
rabbitsign -t 8xu -k ~/Documents/TIKeys/010A.key -K 0A -g -p -r build/OS.8xu
mv build/OS-signed.8xu dist/COSTIC.$1.8xu

echo "### Build complete"
