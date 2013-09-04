%%% Library imports
:- use_module(library(clpfd)).
:- use_module(library(lists)).

%%% External library imports
:- use_module(lambda).

%%% Our own modules imports
:- use_module(grid).
:- use_module(io).

test :-
	grid(Grid, Rows, Columns, Blocks),
	initializeFromFile(Grid,
			   % sudoku_blank),
			   % sudoku_easy),
			   % sudoku_medium),
			   % sudoku_hard),
			   % sudoku_very_hard),
			   sudoku_17_anti_brute_force),
			   % sudoku_16_clues),
			   % sudoku_no_solution),
			   % sudoku_bad_grid),
	% solveClpfd(Grid, Rows, Columns, Blocks),
	solve(Grid, Rows, Columns, Blocks),
	show(Grid).

solve(Grid,  Rows,  Columns,  Blocks) :-
	append([Rows, Columns, Blocks], Groups),
	solve(Grid, Groups).

solve([]         , _Groups) .
solve([Cell|Rest],  Groups) :-
	member(Cell, [1, 2, 3, 4, 5, 6, 7, 8, 9]),
	maplist(is_set, Groups),
	solve(Rest, Groups).

solveClpfd(Grid, Rows, Columns, Blocks) :-
	Grid ins 1..9,
	maplist(maplist(all_distinct), [Rows, Columns, Blocks]),
	label(Grid).
