% swapPairs/2
% swapPairs(?List, ?List)
swapPairs([]      , []      ) .
swapPairs([X]     , [X]     ) .
swapPairs([X, Y|T], [Y, X|R]) :- swapPairs(T, R).

% Non monotonic logic is evil
% Here everything is fine.
testNot1(A) :- A = b, dif(A , a).
testNot2(A) :- A = b, \+  A = a .

% Here not so much.
testNot3(A) :- dif(A , a), A = b.
testNot4(A) :- \+  A = a , A = b.
