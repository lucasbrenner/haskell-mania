:- include('Util.pl').
:- include('Update.pl').

print_menu() :-
    L1 = "   ________  ________  ________  ___       ________  ________  ___  _____ ______   ________  ________   ___  ________       ",
    L2 = "  |\\   __  \\|\\   __  \\|\\   __  \\|\\  \\     |\\   __  \\|\\   ____\\|\\  \\|\\   _ \\  _   \\|\\   __  \\|\\   ___  \\|\\  \\|\\   __  \\      ",
    L3 = "  \\ \\  \\|\\  \\ \\  \\|\\  \\ \\  \\|\\  \\ \\  \\    \\ \\  \\|\\  \\ \\  \\___|\\ \\  \\ \\  \\\\\\__\\ \\  \\ \\  \\|\\  \\ \\  \\\\ \\  \\ \\  \\ \\  \\|\\  \\     ",
    L4 = "   \\ \\   ____\\ \\   _  _\\ \\  \\\\\\  \\ \\  \\    \\ \\  \\\\\\  \\ \\  \\  __\\ \\  \\ \\  \\\\|__| \\  \\ \\   __  \\ \\  \\\\ \\  \\ \\  \\ \\   __  \\    ",
    L5 = "    \\ \\  \\___|\\ \\  \\\\  \\\\ \\  \\\\\\  \\ \\  \\____\\ \\  \\\\\\  \\ \\  \\|\\  \\ \\__\\ \\  \\    \\ \\  \\ \\  \\ \\  \\ \\  \\\\ \\  \\ \\  \\ \\  \\ \\  \\   ",
    L6 = "     \\ \\__\\    \\ \\__\\\\ _\\\\ \\_______\\ \\_______\\ \\_______\\ \\_______\\|__|\\ \\__\\    \\ \\__\\ \\__\\ \\__\\ \\__\\\\ \\__\\ \\__\\ \\__\\ \\__\\  ",
    L7 = "      \\|__|     \\|__|\\|__|\\|_______|\\|_______|\\|_______|\\|_______|   __\\|__|     \\|__|\\|__|\\|__|\\|__| \\|__|\\|__|\\|__|\\|__|  ",
    L8 = "                                                                    |\\__\\                                                   ",
    L9 = "                                                                    \\|__|                                                   ",
                                                                                                                        
    L10 = "Commands: D F J K",
    L11 = "Press P to enter the game",
    L12 = "TURN CAPS LOCK OFF!",
    L13 = "########",
    L14 = "########",

    new_matrix(A),
    List = [
    [L1, 2],
    [L2, 3],
    [L3, 4],
    [L4, 5],
    [L5, 6],
    [L6, 7],
    [L7, 8],
    [L8, 9],
    [L9, 10],
    [L10, 13],
    [L11, 16],
    [L12, 20],
    [L13, 22],
    [L14, 23]
    ],
    insert_list_on_center(A, List, B),

    print_matrix(B).

print_game(Notes, Combo, Score) :-
    new_matrix(A),

    insert_notes(A, Notes, B),

    number_string(Combo, ComboStr),
    atom_concat(ComboStr, "x", ComboFormated),
    insert_on_matrix(B, ComboFormated, 5, 40, C),

    number_string(Score, ScoreStr),
    insert_on_matrix(C, ScoreStr, 6, 40, D),

    print_matrix(D).

drop_notes_animation(_, _, _, 0).

drop_notes_animation(Notes, Combo, Score, Timming) :-
    NextTimming is Timming - 1,
    print_game(Notes, Combo, Score),
    drop_notes_update(Notes, NextNotes, 1),
    drop_notes_animation(NextNotes, Combo, Score, NextTimming).
