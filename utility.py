"""
========================================================================================
File Name:
    utility.py

File Description:
    - has tictactoe game in here
    - has an ascii art if authentication fails

Author:
    Quentin Ramos II
========================================================================================
"""

# --- Import statements ---
import tkinter as tk

# noinspection PyTypeChecker, PyUnresolvedReferences
class TicTacToeGUI:

    def __init__(self, rt):
        self.root = rt
        self.root.title("Tic-Tac-Toe")

        self.current_player = 'X'
        self.board = [[' ' for _ in range(3)] for _ in range(3)]

        self.buttons = [[None for _ in range(3)] for _ in range(3)]

        for i in range(3):
            for j in range(3):
                self.buttons[i][j] = tk.Button(rt, text='', font=('normal', 20), width=5, height=2,
                                               command=lambda row=i, col=j: self.on_button_click(row, col))
                self.buttons[i][j].grid(row=i, column=j)

    def on_button_click(self, row, col):
        if self.board[row][col] == ' ':
            self.board[row][col] = self.current_player
            self.buttons[row][col].config(text=self.current_player, state=tk.DISABLED)

            if self.check_winner():
                self.root.title(f"Player {self.current_player} wins!")
                [self.buttons[i][j].config(state=tk.DISABLED) for i in range(3) for j in range(3)]
            elif self.is_board_full():
                self.root.title(f"Game ended in Tie")
            else:
                self.current_player = 'O' if self.current_player == 'X' else 'X'

    def check_winner(self):
        for i in range(3):
            if all(self.board[i][j] == self.current_player for j in range(3)) or all(
                    self.board[j][i] == self.current_player for j in range(3)):
                return True
        if all(self.board[i][i] == self.current_player for i in range(3)) or all(
                self.board[i][2 - i] == self.current_player for i in range(3)):
            return True
        return False

    def is_board_full(self):
        return all(self.board[i][j] != ' ' for i in range(3) for j in range(3))

    def reset_board(self):
        for i in range(3):
            for j in range(3):
                self.buttons[i][j].config(text='', state=tk.NORMAL)
                self.board[i][j] = ' '
        self.current_player = 'X'

def startGame():
    root = tk.Tk()
    TicTacToeGUI(root)
    root.mainloop()

def authenticationFail():
    print("\n------------------- AUTHENTICATION FAILED! ATTACKER DETECTED! -------------------")
    print("\n\
                    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣴⣶⣶⣶⣶⣶⣶⣶⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n\
                    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⣿⡿⠛⠉⠙⠛⠛⠛⠛⠻⢿⣿⣷⣄⠀⠀⠀⠀⠀⠀⠀\n\
                    ⠀⠀⠀⠀⠀⠀⠀⠀⣼⣿⠋⠀⠀⠀⠀⠀⠀⠀⢀⣀⣀⠈⢻⣿⣿⡄⠀⠀⠀⠀⠀\n\
                    ⠀⠀⠀⠀⠀⠀⠀⣸⣿⡏⠀⠀⠀⢀⣴⣾⣿⣿⣿⠿⠿⠿⢿⣿⣿⣷⡄⠀⠀⠀⠀\n\
                    ⠀⠀⠀⠀⠀⠀⠀⣿⣿⠁⠀⠀⠀⣿⣿⣯⠁⠀⠀⠀⠀⠀⠀⠀⠈⠙⢿⣷⡄⠀⠀\n\
                    ⠀⠀⣀⣤⣴⣶⣶⣿⡇⠀⠀⠀⢸⣿⣿⣿⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣷⡄⠀\n\
                    ⠀⢰⣿⡟⠋⠉⣿⣿⠀⠀⠀⠀⠘⣿⣿⣿⣿⣷⣦⣤⣤⣤⣶⣶⣶⣶⣿⣿⡇⠀⠀\n\
                    ⠀⢸⣿⡇⠀⠀⣿⣿⡇⠀⠀⠀⠀⠹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠃⠀⠀\n\
                    ⠀⣸⣿⡇⠀⠀⣿⣿⡇⠀⠀⠀⠀⠀⠉⠻⠿⣿⣿⣿⣿⡿⠿⠿⢛⣻⡿⠁⠀⠀⠀\n\
                    ⠀⣿⣿⠁⠀⠀⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⠀⠀⠀\n\
                    ⠀⣿⣿⠀⠀⠀⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⠀⠀⠀\n\
                    ⠀⣿⣿⠀⠀⠀⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⠀⠀⠀\n\
                    ⠀⢿⣿⡆⠀⠀⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⠀⠀⠀\n\
                    ⠀⠸⣿⣧⡀⠀⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⡇⠀⠀⠀\n\
                    ⠀⠀⠛⢿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⣰⣿⣿⣷⣶⣶⣶⣶⠶⢘⣿⣿⠀⠀⠀⠀⠀\n\
                    ⠀⠀⠀⠀⠀⠀⠀⣿⣿⠀⠀⠀⠀⠀⣿⣿⡇⠀⣽⣿⡏⠁⠀⠀⢸⣿⡇⠀⠀⠀⠀\n\
                    ⠀⠀⠀⠀⠀⠀⠀⣿⣿⠀⠀⠀⠀⠀⣿⣿⡇⠀⢹⣿⡆⠀⠀⠀⣸⣿⠇⠀⠀⠀⠀\n\
                    ⠀⠀⠀⠀⠀⠀⠀⢿⣿⣦⣄⣀⣠⣴⣿⣿⠀⠀⠈⠻⣿⣿⣿⣿⡿⠁⠀⠀⠀⠀⠀\n\
                    ⠀⠀⠀⠀⠀⠀⠀⠈⠛⠻⠿⠿⠿⠿⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n\
    ")
    for i in range(1,161):
        print("SUS! ", end='', flush=True)
        if i > 0 and i % 16 == 0:
            print()
