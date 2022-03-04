clean:
	rm -f OS.hex
	rm -f OS*.8xu

spasm: OS.hex

OS.hex: 00/base.asm
	spasm 00/base.asm OS.hex -DTI84Plus -DCPU15 -DUSB -DTOTALFLASH=64 '-DPRIVLEDGEDPAGE=$$3C' -I 00 -I priveleged -T

packxxu: OS.8xu
OS.8xu: OS.hex
	pypackxxu OS.hex -o OS.8xu -t 83p -q 0A -v 0.01 -h 255

rabbitsign: OS.8xu ~/Documents/TIKeys/010A.key
	rabbitsign -t 8xu -k ~/Documents/TIKeys/010A.key -K 0A -g -p -r OS.8xu

OS: spasm packxxu rabbitsign
all: clean OS