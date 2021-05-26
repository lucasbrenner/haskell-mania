:- include('Util.pl').
:- include('Update.pl').

print_menu() :-
    cols(Cols), HalfCols is Cols // 2,
    L1 = "------------------ prolog!mania ------------------",
    L2 = "Commands: D F J K",
    L3 = "Press P to enter the game",
    L4 = "TURN CAPS LOCK OFF!",
    L5 = "########",
    L6 = "########",

    string_length(L1, L1L),
    string_length(L2, L2L),
    string_length(L3, L3L),
    string_length(L4, L4L),
    string_length(L5, L5L),
    string_length(L6, L6L),

    new_matrix(A),

    insert_on_matrix(A, L1, 4, HalfCols - L1L // 2, B),
    insert_on_matrix(B, L2, 7, HalfCols - L2L // 2, C),
    insert_on_matrix(C, L3, 8, HalfCols - L3L // 2, D),
    insert_on_matrix(D, L4, 11, HalfCols - L4L // 2, E),
    insert_on_matrix(E, L5, 15, HalfCols - L5L // 2, F),
    insert_on_matrix(F, L6, 16, HalfCols - L6L // 2, G),

    print_matrix(G).

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
    drop_notes_update(Notes, NextNotes),
    drop_notes_animation(NextNotes, Combo, Score, NextTimming).
