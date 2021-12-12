% 1
seg(1, point(1, 11), point(14, 11)).
seg(2, point(2, 4), point(13, 4)).
seg(3, point(2, 2), point(9, 2)).
seg(4, point(3, 1), point(3, 10)).
seg(5, point(7, 10), point(13, 10)).
seg(6, point(8, 0), point(8, 13)).
seg(7, point(10, 3), point(10, 12)).
seg(8, point(11, 3), point(11, 13)).
seg(9, point(12, 2), point(12, 12)).

horiz(N):- seg(N, point(_, Y), point(_, Y)).
% horiz(N)

vertical(N):- seg(N, point(X, _), point(X, _)).
% vertical(N)


% 2
crossHelper(N, M, point(PX, PY), NL, ML):-
    horiz(N),
    vertical(M),
    seg(N, point(X1, PY), point(X2, PY)),
	seg(M, point(PX, Y1), point(PX, Y2)),
	X1 =< PX, PX =< X2,
	Y1 =< PY, PY =< Y2,
	NL is abs(X2 - X1),
	ML is abs(Y2 - Y1).

cross(N, M, point(PX, PY), NL, ML):-
	crossHelper(N, M, point(PX, PY), NL, ML);
	crossHelper(M, N, point(PX, PY), ML, NL).
% cross(N,M,point(X,Y),NL,ML)


% 3
perimetr(A, B, C, D, P, S) :- 
    cross(A, B, point(X1, Y1), _, _), 
    cross(A, D, point(_, _), _, _),
    cross(C, B, point(_, _), _, _), 
    cross(C, D, point(X2, Y2), _, _), 
    W is abs(X1 - X2), 
    H is abs(Y1 - Y2),
    P is 2 * (W + H), 
    S is W * H,
    S \= 0
    .
% perimetr(A, B, C, D, P, S).













