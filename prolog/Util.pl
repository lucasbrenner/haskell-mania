cols(Cols) :- tty_size(_, Cols).
rows(Rows) :- tty_size(Rows, _).

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

insert_on_matrix([HeadIn | TailIn], Str, I, J, [HeadOut | TailOut]) :-
    (
        I > 0 -> II is I - 1, HeadOut = HeadIn, insert_on_matrix(TailIn, Str, II, J, TailOut);
        insert_on_str(Str, HeadIn, J, HeadOut), TailOut = TailIn
    ).

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
