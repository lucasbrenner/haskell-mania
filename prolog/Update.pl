
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
    nth0(0, NotesHead, DropFactor),
    drop_notes_update(NotesTail, NextNotes, DropFactor).

% Updates the notes position for the note drop animation
drop_notes_update([], [], _).

drop_notes_update([[TimmingIn , ColIn] | TailIn], [[TimmingOut, ColOut] | TailOut], DropFactor) :-
    TimmingOut is TimmingIn - DropFactor,
    ColOut = ColIn,
    drop_notes_update(TailIn, TailOut, DropFactor).