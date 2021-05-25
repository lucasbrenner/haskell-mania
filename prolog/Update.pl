
% Updates the game given the Key pressed
update_game([NotesHead | NotesTail], Combo, Key, NextNotes, NextCombo) :-
    nth0(1, NotesHead, NextColumn),
    (
        Key = 'd' -> PressedColumn = 0;
        Key = 'f' -> PressedColumn = 1;
        Key = 'j' -> PressedColumn = 2;
        Key = 'k' -> PressedColumn = 3;
        PressedColumn = -1
    ),
    (
        PressedColumn = NextColumn -> NextCombo is Combo + 1;
        NextCombo = 0
    ),
    NextNotes = NotesTail.

% Updates the notes position for the note drop animation
drop_notes_update([], []).

drop_notes_update([[TimmingIn , ColIn] | TailIn], [[TimmingOut, ColOut] | TailOut]) :-
    TimmingOut is TimmingIn - 1,
    ColOut = ColIn,
    drop_notes_update(TailIn, TailOut).
