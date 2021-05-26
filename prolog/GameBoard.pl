:- include('Render.pl').
:- include('InputHandler.pl').
:- include('Update.pl').

menu() :-
    print_menu(),
    get_key(['p', 'm'], Key),
    (
        Key = 'p' -> game();
        menu()
    ).

notes([[10, 0], [20, 1], [30, 2], [40, 3], [50, 1], [100, 1]]).

game() :-
    notes(Notes), % map_loader...

    game_loop(Notes, 0, 0).

game_loop([], _).

game_loop(Notes, Combo, Score) :-
    print_game(Notes, Combo, Score),

    get_key(['d', 'f', 'j', 'k'], Key),

    nth0(0, Notes, NextNote),
    %nth0(1, Notes, NextColumn),
    nth0(0, NextNote, NextTimming),
    drop_notes_animation(Notes, Combo, Score, NextTimming),

    update_game(Notes, Combo, Score, Key, NextNotes, NextCombo, NextScore),
    
    game_loop(NextNotes, NextCombo, NextScore).
