------ PUF Implementation on an FPGA ------

----------------------------------------------------------------------
RTL & Design (Hardware):
----------------------------------------------------------------------

Given an N-bit challenge, the arbiter-butterfly hybrid PUF would
have an N number of hybrid PUF cells chained to produce a single
bit of output. N number of chains would then needed to be created
to achieve an N-bit output.

----------------------------------------------------------------------
Authentication & Hashing (Sofwtare):
----------------------------------------------------------------------

Before authentication, a 'crmap.txt' file is created which
has all possible challenges that can be given to the FPGA.
All challenges are sent to the PUF and hashed with the custom
hash function and stored in the crmap.txt file which is then
used to authenticate a device.

Hash function:
   - Given a 8-bit binary input do the following:
   Ex:
      10010101
	  bits 8,5,3,1 are set (first bit being bit 1 and not 0)
	  8,5,3,1 -> 8531
	  
	  8531 -> (8^5+31) * base10(10010101) = hashed output

   - The hash function is 1 to 1 and unique and irreversible

Authentication protocol:
   - A random challenge is generated
   - Challenge gets sent to the PUF and the response is hashed
   - The response is compared to the 'crmap.txt' file output
   - If they match the device is authorized (plays a game of tictactoe) [ELIMINATED]
   - If they do not match, a prompt appears indicating impersonation    [ELIMINATED]

MILESTONE 2.1 UPDATE:

Since the PUF was not designed to interface with the UART module given
the time constraints of the project. The outputs of the PUF and their
responses were recorded in a txt file. The FPGA would display the output
via the builtin LED module on the Basys3 board. The hash function would
then run on the responses based on the .txt files and the hashes of the
2 PUF responses were compared. If the hashes were different than the
designed PUF has a unique characteristic in which it's device specific.

The one-way characteristic was not tested for, however the hash function
allows the PUF responses to be irreversible after they are hashed. This
functionality indirectly proves the one-way characteristic since the PUF
input cannot be determined by the PUF output.