"""
========================================================================================
File Name:
    auto_puf_testing.py

File Description:
    Executes authentication module using the constructed FPGA arbiter PUF. The program
    generates challenges and records the response. It then looks up all the challeneges
    and responses and identifies the authenticated user.

Author:
    Quentin Ramos II
========================================================================================
"""

# --- Import statements ---
import qrhash
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
Generates a challenge to look up
"""
def challenge_generator(lower_limit=0, upper_limit=19, seed=None):
    state = seed if seed is not None else int(time.time() * 1000)
    while True:
        state = (state * 1103515245 + 12345) % (2**31)
        random_number = state % upper_limit
        if lower_limit <= random_number < upper_limit:
            yield random_number


"""
Given a response, hash the response
"""
def obtain_hash(response) : return qrhash.qrhash(response)


"""
Given a challenge, find the corresponding response
"""
def obtain_response(challenge,puf_file):
    with open(puf_file,'r') as file:
        for line in file:
            if challenge in line:
                return int(line.strip().split("|")[1])


"""
Tests for uniqueness
"""
def unique_test(challenge, puf_file, isCompare, puf_num):
    puf_hash = obtain_hash(obtain_response(str(challenge),puf_file))
    print(f"PUF#{puf_num}: Challenge = {challenge} | Response = {puf_hash}")

    # If Auth_PUF.txt exists check if file exists:
    fpath = Path(__file__).resolve().parent / "Auth_PUF.txt"
    if isCompare:
        with open(fpath, 'r') as file:
            line = file.readline().strip
            if str(puf_hash) != line:
                print("\nPUF Results are different, PUF = Unique!")
            else:
                print("\nRuh-Roh, these PUFs produced the same result!")
    else:
        with open(fpath, 'w') as file:
            file.write(str(puf_hash))


"""
Run the reproducibility test and uniqueness test
"""
def main():
    challenge_list = challenge_generator()
    challenge = next(challenge_list)
    for i in range(1,11):
        print("-" * 50)
        print(f"Unique challenge #{i}:")
        unique_test(challenge, Path(__file__).resolve().parent / "PUF1.txt",False,1)
        unique_test(challenge, Path(__file__).resolve().parent / "PUF2.txt",True,2)
        print("-" * 50); print()
        challenge = next(challenge_list)


if __name__ == '__main__':
    main()