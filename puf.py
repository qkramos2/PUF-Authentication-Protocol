"""
========================================================================================
File Name:
    puf.py

File Description:
    Executes authentication module using the constructed FPGA arbiter PUF. The program
    generates challenges and records the response. It then looks up all the challeneges
    and responses and identifies the authenticated user.

Author:
    Quentin Ramos II
========================================================================================
"""

# --- Import statements ---
import utility
import qrhash
import serial
import time
from pathlib import Path

# --------------------------- Global Variables -----------------------------
com_port  = 'COM'
baud_rate = 115200
file_name = "crmap.txt"
file_path = Path(__file__).resolve().parent / file_name
isDebug   = True
# --------------------------------------------------------------------------

"""
Generates a n-bit challenge to send to the FPGA PUF

inputs:
    void

outputs:
    n-bit challenge response
"""
def challenge_generator(lower_limit=0, upper_limit=255, seed=None):
    state = seed if seed is not None else int(time.time() * 1000)

    while True:
        state = (state * 1103515245 + 12345) % (2**31)
        random_number = state % upper_limit
        if lower_limit <= random_number < upper_limit:
            yield random_number

"""
isDebug: 
   if debugging and not using the board do the 2nd set of functions
   else when doing the real thing make sure to overwrite crmap.txt
"""
if not isDebug:
    """
    Generates a txt file containing the challenge and 
    corresponding hashed responses to authenticate users
    """
    def create_CRmap():
        ser = serial.Serial(com_port, baud_rate, timeout=1)

        # go through all inputs and record the PUF output (only if it does not exist
        # or has the debug line at the beginning, else skip it):
        if ser.is_open:
            with open(file_name, 'r+') as file:
                if file.readline().strip() == "DEBUG":
                    file.seek(0)
                    for i in range(2**8):
                        ser.write(bytes.fromhex(hex(i)[2:].zfill(2)))
                        hex_string = '0x'.join(f'{byte:02X}' for byte in ser.read(1))
                        result = qrhash.qrhash(int(hex_string,16))
                        file.write(str(f"{i:03d}") + " | " + str(result) + "\n")
        ser.close()

    """
    Authentication to verify user
    """
    def authenticate_user():
        challenge = 0; result = 0
        while challenge == 0 : challenge = next(challenge_generator())
        ser = serial.Serial(com_port, baud_rate, timeout=1)

        # send the challenge to the PUF:
        if ser.is_open:
            ser.write(bytes.fromhex(hex(challenge)[2:].zfill(2)))
            hex_string = '0x'.join(f'{byte:02X}' for byte in ser.read(1))
            result = qrhash.qrhash(int(hex_string, 16))
        ser.close()

        # check for the result in the crmap
        with open(file_name, 'r') as file:
            for line_number, line in enumerate(file, 1):
                if str(result) in line:
                    if int(line.strip().split("|")[0]) == challenge: return True
                    else : return False
        return False

else:
    """
    Generates a txt file containing the challenge and 
    corresponding hashed responses to authenticate users
    """
    def create_CRmap():
        # go through all inputs and record the PUF output:
        with open(file_name, 'w') as file:
                file.write("DEBUG\n") # Ensure to overwrite if running real thing
                for i in range(2 ** 8):
                    result = qrhash.qrhash(i)
                    file.write(str(f"{i:03d}") + " | " + str(result) + "\n")

    """
    Authentication to verify user
    """
    def authenticate_user():
        challenge = 0
        while challenge == 0 : challenge = next(challenge_generator())
        result = qrhash.qrhash(challenge)

        # check for the result in the crmap
        with open(file_name, 'r') as file:
            for line_number, line in enumerate(file, 1):
                if str(result) in line :
                    if int(line.strip().split("|")[0]) == challenge : return True
                    else : return False
        return False

"""
Main program that attempts to check if a board is the authentic board
if so a tictactoe game appears.

inputs:
    void

outputs:
    void
"""
def main():
    utility.authenticationFail()
    #create_CRmap()
    #if authenticate_user():
    #    utility.startGame()
    #else:
    #    utility.authenticationFail()

if __name__ == '__main__':
    main()