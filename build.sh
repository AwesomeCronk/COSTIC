#!/bin/bash

echo "### Pre-build Cleanup"
rm -f Page-*.hex
rm -f OS.hex
rm -f OS.8xu
rm -f OS-signed.8xu

echo "### SPASM-NG"
spasm 00/base.asm Page-00.hex -DTI84Plus -DCPU15 -DUSB -DTOTALFLASH=64 '-DPRIVLEDGEDPAGE=$3C' -I 00
spasm privledged/base.asm Page-privledged.hex -DTI84Plus -DCPU15 -DUSB -DTOTALFLASH=64 '-DPRIVLEDGEDPAGE=$3C' -I 3C

echo "### MultiHex"
multihex 00 Page-00.hex 3C Page-privledged.hex > OS.hex

echo "### PyPackXXU"
pypackxxu OS.hex -o OS.8xu -t 84p -q 0A -v 0.01 -h 255

echo "### RabbitSign"
rabbitsign -t 8xu -k ~/Documents/TIKeys/010A.key -K 0A -g -p -r OS.8xu

echo "### Build complete"
