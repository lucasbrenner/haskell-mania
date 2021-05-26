
% Updates the game given the Key pressed
update_game([NotesHead | NotesTail], Combo, Score, Key, NextNotes, NextCombo, NextScore) :-
    nth0(1, NotesHead, NextColumn),
    (
        Key = 'd' -> PressedColumn = 0;
        Key = 'f' -> PressedColumn = 1;
        Key = 'j' -> PressedColumn = 2;
        Key = 'k' -> PressedColumn = 3;
        PressedColumn = -1
    ),
    (
        PressedColumn = NextColumn -> NextCombo is Combo + 1, ScoreMultiplier is (Combo + 10) // 10, NextScore is Score + ScoreMultiplier * 100;
        NextCombo = 0, NextScore = Score
    ),
    NextNotes = NotesTail.

% Updates the notes position for the note drop animation
drop_notes_update([], []).

drop_notes_update([[TimmingIn , ColIn] | TailIn], [[TimmingOut, ColOut] | TailOut]) :-
    TimmingOut is TimmingIn - 1,
    ColOut = ColIn,
    drop_notes_update(TailIn, TailOut).
