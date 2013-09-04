:- use_module(library(clpfd)).

% :- initialization(go).

% go :-
%     write('Factorielle naïve de 5 : '),
%     factorial_naive(5, F),
%     writeln(F),
%     write('Factorielle TCO de 5   : '),
%     factorial_tco(5, F),
%     writeln(F),
%     write('Factorielle de 5       : '),
%     factorial(5, F),
%     writeln(F),
%     write('Nombre dont la factorielle est 120 - naïve    : '),
%     catch((factorial_naive(N, 120),
% 	   writeln(N)),
% 	  E,
% 	  print_message(error, E)),
%     write('Nombre dont la factorielle est 120 - TCO      : '),
%     catch((factorial_tco(N, 120),
% 	   writeln(N)),
% 	  E2,
% 	  print_message(error, E2)),
%     write('Nombre dont la factorielle est 120 - correcte : '),
%     factorial(N, 120),
%     writeln(N).

% On my setup, won't crash for N = 10 000 but
% will stack overflow for N = 100 000.
factorial_naive(0, 1) :- !.
factorial_naive(N, F) :-
	PreviousN is N - 1,
	factorial_naive(PreviousN, PreviousF),
	F is PreviousF * N.



% TCO fixes that.
factorial_tco(N, F) :-
	factorial_tco(N, 1, F).

factorial_tco(0, Acc, Acc) :- !.
factorial_tco(N, Acc, F  ) :-
	NewN is N - 1,
	NewAcc is Acc * N,
	factorial_tco(NewN, NewAcc, F).



% But TCO won't give us a general program.
% CLPFD will.
factorial(N, Result) :-
	factorial(N, 1, Result).

factorial(0, Acc, Acc   ) .
factorial(N, Acc, Result) :-
	Acc #=< Result,
	N #> 0,
	NewAcc #= Acc * N,
	NewN #= N - 1,
	factorial(NewN, NewAcc, Result).
