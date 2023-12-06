"""
========================================================================================
File Name:
    qrhash.py

File Description:
    Hash brainstorming // hash functionality

Author:
    Quentin Ramos II
========================================================================================
"""

"""
Hash brainstorming ideas

--------------------------------------------------------------------------
00000001 -> 1   * int(00000001)
00000010 -> 2   * int(00000010)
00000011 -> 2^1 * int(00000011)
10000001 -> 8^1 * int(10000001)

00011101
5431
5^4+31 = 656
656 * int(00011101)

01101010
7642
7^6+42 = 117691

11111111
8^7+65^4+32^1 = 19947809
--------------------------------------------------------------------------

  input: 00011101
step #1: 00054301 -> 5431
step #2: 5^4+31 = 656 * int(00011101)
"""

# --------------------------- Global Variables -----------------------------
in_length = 8
# --------------------------------------------------------------------------

"""
The custom hash function

inputs:
    puf_in: response from the arbiter puf
outputs:
    the hashed response value
"""
def qrhash(puf_in):
    if puf_in == 0 : return 0
    binary_string = bin(puf_in)[2:].zfill(in_length)

    # Step 1:
    counter = in_length
    mixedNum = ""
    for bit in binary_string:
        if bit == "1":
            mixedNum += str(counter)
        counter -= 1

    # Step 2:
    evald_eqn = int(mixedNum); op_count = 1
    if len(mixedNum) > 1:
        equation = mixedNum[0]
        for ind in range(1, len(mixedNum)):
            if op_count == 1:
                equation += "**" + mixedNum[ind]; op_count += 1
            elif op_count == 2:
                equation += "+" + mixedNum[ind]; op_count += 1
            else:
                equation += mixedNum[ind]; op_count = 1
        evald_eqn = eval(equation)
    return evald_eqn * puf_in

"""
Hash function checker that checks if the hash is a
unique 1 to 1 hash function

inputs:
    isDisplay: boolean to display the individual hashed 
    values
    
outputs:
    void
"""
def checkHash(isDisplay):
    seen = {}
    hashes = []
    duplicates = []
    for i in range(1,2**in_length):
        binary_string = bin(i)[2:].zfill(in_length)

        # Step 1:
        counter = in_length
        mixedNum = ""
        for bit in binary_string:
            if bit == "1":
                mixedNum += str(counter)
            counter -= 1

        # Step 2:
        equation = mixedNum; evald_eqn = int(mixedNum); op_count = 1
        if len(mixedNum)>1:
            equation = mixedNum[0]
            for ind in range(1,len(mixedNum)):
                if op_count == 1:
                    equation += "**" + mixedNum[ind]; op_count += 1
                elif op_count == 2:
                    equation += "+" + mixedNum[ind]; op_count += 1
                else:
                    equation += mixedNum[ind]; op_count = 1
            evald_eqn = eval(equation)
        result = evald_eqn * i
        hashes.append(result)

        # Display the results:
        if isDisplay:
            displayHash(binary_string,mixedNum,equation,evald_eqn,result)

    # Check if there are duplicates:

    for item in hashes:
        if item in seen:
            duplicates.append(item)
        else:
            seen[item] = 1

    if duplicates:
        print("Duplicate entries:", duplicates)
        for dup in duplicates:
            indices = [index for index, element in enumerate(hashes) if element == dup]
            print("  Indicies:", indices)
    else:
        print("Unique Hashes LFG >:D")

"""
Basic display function to show the intermediate steps of
the hash function
"""
def displayHash(binary_string, mixedNum, equation, evald_eqn, result):
    print("   bin input: " + str(binary_string))
    print("    mixedNum: " + str(mixedNum))
    print("    equation: " + str(equation))
    print("  Solved eqn: " + str(evald_eqn))
    print("Final Result: " + str(result) + "\n")

if __name__ == '__main__':
    checkHash(True)