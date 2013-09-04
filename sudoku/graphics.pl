:- use_module(library(pce)).

test :-
	new(P, point(10,20)),
	send(P, x(15)),
	new(@demo, dialog('Demo Window')),
	send(@demo, append(text_item(name))),
	send(@demo, open).