:- include('Util.pl').

print_menu() :-
    cols(Cols), HalfCols is Cols // 2,
    L1 = "------------------ prolog!mania ------------------",
    L2 = "Commands: D F J K",
    L3 = "Press P to enter the game",
    L4 = "TURN CAPS LOCK OFF!",

    string_length(L1, L1L),
    string_length(L2, L2L),
    string_length(L3, L3L),
    string_length(L4, L4L),

    new_matrix(A),

    insert_on_matrix(A, L1, 4, HalfCols - L1L // 2, B),
    insert_on_matrix(B, L2, 7, HalfCols - L2L // 2, C),
    insert_on_matrix(C, L3, 8, HalfCols - L3L // 2, D),
    insert_on_matrix(D, L4, 11, HalfCols - L4L // 2, E),

    print_matrix(E).

game() :-
    cols(Cols), HalfCols is Cols // 2,
    L1 = "------------------ prolog!mania ------------------",
    L2 = "Commands: D F J K",
    L3 = "Press P to enter the game",
    L4 = "TURN CAPS LOCK OFF!",

    string_length(L1, L1L),
    string_length(L2, L2L),
    string_length(L3, L3L),
    string_length(L4, L4L),

    new_matrix(A),

    insert_on_matrix(A, L1, 4, HalfCols - L1L // 2, B),
    insert_on_matrix(B, L2, 7, HalfCols - L2L // 2, C),
    insert_on_matrix(C, L3, 8, HalfCols - L3L // 2, D),
    insert_on_matrix(D, L4, 11, HalfCols - L4L // 2, E),

    print_matrix(E).