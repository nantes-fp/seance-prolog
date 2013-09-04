:- module(io, [ show/1
	      , initializeFromFile/2 ]).

show(Grid) :- show(Grid, 1).
show([], _Counter).
show([Cell|Grid], Counter) :-
	( var(Cell)
	-> write('_')
	; write(Cell)),
	showBlanks(Counter),
	NewCounter is Counter + 1,
	show(Grid, NewCounter).
showBlanks(Counter) :- Counter mod 27 =:= 0, nl, nl, !.
showBlanks(Counter) :- Counter mod 9 =:= 0, nl, !.
showBlanks(Counter) :- Counter mod 3 =:= 0, tab(2), !.
showBlanks(_) :- tab(1).

% initializeFromFile/2
% initializeFromFile(+Grid, +Sudoku)
% Reads the sudoku file and puts the 81 first characters met that are 1-9 or _
% in the grid.
initializeFromFile(Grid, Sudoku) :-
    atom_concat('grids/', Sudoku, Filename),
    open(Filename, read, File),
    readFromFile(Grid, File).
readFromFile([], File) :- close(File).
readFromFile([Cell|Grid], File) :-
    is_stream(File),
    get_code(File, Code),
    consumeChar(Code, File, [Cell|Grid]).
consumeChar(95, File, [_Cell|Grid]) :- readFromFile(Grid, File).
consumeChar(-1, File, _Cell) :-
    write('Le fichier ne contient pas un sudoku entier (81 caractères parmi '),
    writeln('1-9 et _.)'),
    close(File),
    !,
    fail.
consumeChar(Code, File, Grid) :-
    (Code > 57; Code < 49),
    !,
    readFromFile(Grid, File).
consumeChar(Code, File, [Cell|Grid]) :-
    number_codes(Number, [Code]),
    Cell = Number,
    readFromFile(Grid, File).