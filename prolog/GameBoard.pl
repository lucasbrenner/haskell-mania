:- include('Render.pl').
:- include('EventHandler.pl').

menu() :-
    print_menu(),
    get_key(['p', 'P', 'm', 'M'], Key),
    (
        Key = 'p' -> game();
        menu()
    ).
