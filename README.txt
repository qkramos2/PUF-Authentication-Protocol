------ PUF Implementation on an FPGA ------

-------------------------------------------
RTL & Design (Hardware):
-------------------------------------------

<Robbie Documentation on how the hybrid PUF cell works>

-------------------------------------------
Authentication & Hashing (Sofwtare):
-------------------------------------------

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
   - If they match the device is authorized (plays a game of tictactoe) <- got bored
   - If they do not match, a prompt appears indicating impersonation