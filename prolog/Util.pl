% Number of rows in the console
rows(Rows) :- tty_size(Rows, _).

% Number of columns in the console
cols(Cols) :- tty_size(_, Cols).

% Generates a new printable matrix
new_matrix(Matrix) :-
    new_matrix_aux(Matrix, 0).

new_matrix_aux([], Rows) :- rows(Rows).

new_matrix_aux([Head | []], I) :-
    II is I + 1,
    new_row(Head, 0, false),
    new_matrix_aux([], II).

new_matrix_aux([Head | Tail], I) :-
    II is I + 1,
    new_row(Head, 0, true),
    new_matrix_aux(Tail, II).

new_row(Str, J, EndLine) :-
    cols(Cols), JJ is J + 1,
    (
        J < Cols -> new_row(NextStr, JJ, EndLine), string_concat(" ", NextStr, Str);
        J >= Cols, J < 500 -> new_row(NextStr, JJ, EndLine), string_concat("\0", NextStr, Str);
        (EndLine -> Str = "\n"; Str = "")
    ).

% Prints 'Matrix' in the console
print_matrix(Matrix) :-
    matrix_to_str(Matrix, Str),
    write(Str).

matrix_to_str([], "").

matrix_to_str([Head | Tail], Str) :-
    matrix_to_str(Tail, NextStr),
    string_concat(Head, NextStr, Str).

% Inserts Str in MatrixIn at the Ith row and Jth column
% insert_on_matrix(MatrixIn, Str, I, J, MatrixOut)
insert_on_matrix([HeadIn | TailIn], Str, I, J, [HeadOut | TailOut]) :-
    (
        I > 0 -> II is I - 1, HeadOut = HeadIn, insert_on_matrix(TailIn, Str, II, J, TailOut);
        insert_on_str(Str, HeadIn, J, HeadOut), TailOut = TailIn
    ).

% Inserts Str in StrIn at the Ith index
insert_on_str(StrIn, Str, I, StrOut) :-
    string_to_list(StrIn, ListIn),
    string_to_list(Str, ListStr),
    insert_on_str_aux(ListIn, ListStr, I, ListOut),
    string_to_list(StrOut, ListOut).

insert_on_str_aux([], List, _, List).

insert_on_str_aux([Head | Tail], [HeadIn | TailIn], I, [HeadOut | TailOut]) :-
    (
        I > 0 -> II is I - 1, HeadOut = HeadIn, insert_on_str_aux([Head | Tail], TailIn, II, TailOut);
        HeadOut = Head, insert_on_str_aux(Tail, TailIn, 0, TailOut)
    ).

% NotesOut are the notes which are in the screen
% on_screen_notes(NotesIn, NotesOut)
on_screen_notes([], []).

on_screen_notes([[TimmingIn, _] | _], []) :-
    rows(Rows),
    TimmingIn > Rows.

on_screen_notes([HeadIn | TailIn], [HeadOut | TailOut]) :-
    HeadOut = HeadIn,
    on_screen_notes(TailIn, TailOut).


% Inserts notes in a printable matrix
insert_notes(In, RawNotes, Out) :-
    on_screen_notes(RawNotes, Notes),
    insert_notes_aux(In, Notes, Out).

insert_notes_aux(In, [], In).

insert_notes_aux(In, [HeadNotes | TailNotes], Out) :-
    nth0(0, HeadNotes, I),
    nth0(1, HeadNotes, Col),
    rows(Rows),
    J is Col * 8,

    insert_on_matrix(In  , "########", Rows - I, J, Out1),
    insert_on_matrix(Out1, "########", Rows - I - 1, J, Out2),
    insert_notes_aux(Out2, TailNotes, Out).

