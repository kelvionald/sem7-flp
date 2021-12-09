% 1
trim([], []).
trim([_], []). 
trim([_|L1Tail], L2):- append(L2, [_], L1Tail).

% 2
first_last([], []).
first_last([H], [H]).
first_last([H1|T1], [H2|T2]):-
    append(C, [L1], T1), % получаем последний эл первого списка
    append(C, [L2], T2), % получаем последний эл второго списка
    H1 = L2,
    H2 = L1.

% 3
total([], 0).
total([Val], Val).
total([H|T], Sum):-
    length(T, Temp),
    Temp > 0,
    total(T, SumRec),
    Sum is H * SumRec.

% 4

place(El, [], [El]).
% place(El, InL, OutL).