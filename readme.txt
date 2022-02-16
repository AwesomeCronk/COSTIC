The very first thing you should do is download the 02, 04, and 0A key files
from http://brandonw.net and place them in the root of this folder.

Run BuildOS.exe to build your OS.  Each directory represents a single page.
Each directory name should be the hexadecimal representation of its page
number.  The special page "privledged" will be mapped to the appropriate
page for each model:
* TI-73: $1C
* TI-83+: $1C
* TI-83+ SE: $7C
* TI-84+: $3C
* TI-84+ SE: $7C
From the privledged page, you can access protected ports, such as Flash Control.
In each of these directories, you should add a file called "base.asm", which will
be assembled by SPASM when the OS is built.  All of these files are put into
8XU, ROM, and 73U files when assembled, and signed appropraitely.

Special Defines:
The build program will #define various special properties while building your OS,
based on model.  For the following models, this information will be defined:
* TI-73: TI73, TOTALFLASH=32, PRIVLEDGEDPAGE=$1C
* TI-83+: TI83Plus, TOTALFLASH=32, PRIVLEDGEDPAGE=$1C
* TI-83+ SE: TI83PlusSE, CPU15, TOTALFLASH=128, PRIVLEDGEDPAGE=$7C
* TI-84+: TI84Plus, CPU15, USB, TOTALFLASH=64, PRIVLEDGEDPAGE=$3C
* TI-84+ SE: TI84PlusSE, CPU15, USB, TOTALFLASH=128, PRIVLEDGEDPAGE=$7C

In addition, for your convinence (and less headaches for me), it also builds each
file twice with each set of defines, and adds DEBUG or RELEASE.

Command Line Arguments:
-v: Be verbose

NOTE: This tool does not add a boot page to the generated ROM files.  WabbitEmu
recently changed to support boot page start up, and this doesn't work with the
generated ROMs.  An older version of WabbitEmu is provided for debugging.

See documentation.txt for information.