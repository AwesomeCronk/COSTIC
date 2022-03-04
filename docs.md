## Original AsmOS `documentation.txt`
=== Boot Up ===
After booting up, the calculator state is this:
Interrupts: Disabled IM 1, with Timer 1, ON, and low-power mode enabled
USB: All USB interrupts are enabled and handled by interrupt.asm on appropriate models.
Memory: Memory mode 0:
	$0000-$3FFF: Flash 00
	$4000-$7FFF: Flash Undefined (not set during boot-up)
	$8000-$BFFF: RAM 01
	$C000-$FFFF: RAM 00
All memory is unlocked to allow execution from anywhere, including beyond $C000
SP is set to $0000
The clock speed is set to 15 MHz on appropriate models
Flash is locked (unlock with UnlockFlash in util.asm)
RAM is cleared (you may want to disable this on line 108 of boot.asm)
The LCD is initialized like so:
	X-Increment mode
	8-bit mode
	Turned ON (after calling Sleep at line 30 of boot.asm)
	Power settings are applied (see datasheet)
	Contrast is set to $EF, which is generally a good value for all models
After this, a JR $ loop is entered at line 140 of boot.asm.
	
=== Assembling ===
See the readme for some more information about how this is assembled.  You should modify
base.asm on page 00 to add files.

=== Getting Started ===
Before you do anything important, go to base.asm on page 00 and change the safe RAM values
used by several routines.  You can also add any RST routines you'd like to header.asm.  In
addition, you may add any interrupts you need to interrupt.asm, which already handles interrupt
acknowledgement.

=== Routines ===
Most routines are documented in the comments next to them in their respective files.
Several routines have been taken from various sources, including WikiTI, and may be
largely unattributed.  Attribution will be addressed in full when KnightOS is released.
No USB routines are provided because they are too intricate for a minimalistic OS.  If
you support USB, you need to handle these appropriately for your OS.
All routines:
== display.asm ==
All display routines accept IY as the buffer address.
- ClearBuffer
- FastCopy (this is a SafeCopy routine, which works on all hardware versions)
- getPixel
- setPixel
- resetPixel
- invertPixel
- DrawLine
- PutSpriteOR
- PutSpriteAND
- PutSpriteXOR
- RectOR
- RectAND
- RectXOR
== flash.asm ==
These routines allow you to modify Flash, using SwapSector and FlashTempRAM, defined in 00/base.asm
- WriteFlashByte
- WriteFlashBuffer
- EraseFlashSector
- EraseFlashPage
- CopySectorToSwap
- CopyFlashPage
== keyboard.asm ==
All of these routines are based on code from the grayscale package on ticalc.org.  Key codes are included
in keys.inc.
- waitKey
- flushKeys
- getKey
== util.asm ==
This contains a bunch of miscellaneous routines that don't fit anywhere else.
- GetBatteryLevel
- Sleep
- DEMulA
- UnlockFlash
- LockFlash
- CpHLDE
- CpHLBC
- CpDEBC
- CpBCDE
- CompareStrings
- Quicksort
== boot.asm ==
These are not really considered routines, and will never return.  You should always use them with JP.
- ShutDown
- Reboot

=== Notes ===
Have fun!  Hopefully this will help get your 3rd party OS rolling.  Be sure to let me know what kind of cool
projects you are working on.  You can ask questions and get support at http://www.cemetech.net/, or find me
on IRC as SirCmpwn on EFNet.  You can even email me at sircmpwn@gmail.com.  You can pretty much find me
anywhere as SirCmpwn or Drew DeVault.  I've got a blog on http://sircmpwn.com (or http://drewdevault.com
if you prefer).  There are a plethora of ways to ask me questions about this.  If you want, I'll even give
you my phone number, and you can wake me up in the middle of the night with your OS questions (that would
be strange, but hey).
If you like this, you should be looking forward to KnightOS and Knight Kernel, which is way cooler.  They're
both based off of something like this.  KnightOS will be a fully fledged Operating System which does a bunch
of awesome stuff.  Knight Kernel is what KnightOS is based on, which will offer a ton of stuff that AsmOS
does not - file system, multithreading, libraries, and toooons more really useful stuff (everything you'd
expect from a kernel).  Both of those are in progress, and you can look at their source code right now if you
want, at http://sf.net/projects/knightos.  They are and forever will be open source, and you can install KnightOS
on your calculator right now (it's rapidly approaching completion, after quite a long time).
I also want to drop a quick plug for AHelper's GlassOS and COS, which are 3rd party OSes written in C.  You
might find them a little easier to work with if you aren't as familiar with assembly.
GlassOS: http://glassos.sf.net
COS: http://www.cemete.ch/p164021
On that note, go make some awesome 3rd party OSes!

=== Thanks ===
Attribution for routines will come with KnightOS, never fear.  But for making this possible at all:
- Benjamin Moody
- Brandon Wilson
- Brenden Fletcher
- Brain Coventry
Lots more people, most of whom probably have names that start with 'B' 