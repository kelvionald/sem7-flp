% 1 Определите отношение trim(L1,L2), которое удаляет в списке L1 первый и 
% последний элемент.
trim([], []).
trim([_], []). 
trim([_|L1Tail], L2):- append(L2, [_], L1Tail).

% 2 Определите отношение first_last(L1,L2), которое выполнено, если список L1 
% совпадает со списком L2, но в L2 первый и последний элемент поменялись местами.
first_last([], []).
first_last([H], [H]).
first_last([H1|T1], [H2|T2]):-
    append(C, [L1], T1), % получаем последний эл первого списка
    append(C, [L2], T2), % получаем последний эл второго списка
    H1 = L2,
    H2 = L1.

% 3 Определите процедуру total/2, которая подсчитывает произведение элементов 
% списка целых чисел.
total([], 0).
total([Val], Val).
total([H|T], Sum):-
    length(T, Tlen), Tlen > 0,
    total(T, SumRec),
    Sum is H * SumRec.

% 4 Определите процедуру place/3, которая первый свой аргумент помещает во 
% второй аргумент, являющийся списком, таким образом, что первый аргумент 
% последовательно занимает место между элементами второго  аргумента.
place(El, In, Out):-
    append(Head, Tail, In),
    append(Head, [El], Tmp), append(Tmp, Tail, Out)
    .

% 5 Напишите процедуру double(L,LL), в которой   каждый элемент списка L 
% удваивается в списке LL.
double([], []).
double(In, Out):-
    [H1|T1] = In,
    double(T1, T),
    append([H1, H1], T, Out)
    .

% 6 Определите процедуру split(L1,L2,L3), которая разбивает список   целых чисел
% L1 на два списка: четных чисел L2 и нечетных - L3. Порядок элементов в двух 
% новых списках должен быть обратный,  как показано в примере.
chet(X) :- N is X mod 2, N = 0.
nechet(X) :- not(chet(X)).

split([], [], []).
split(In, Chet, Nechet):-
    [Head|Tail] = In,
    (
        chet(Head), split(Tail, TmpChet, Nechet), append(TmpChet, [Head], Chet);
        nechet(Head), split(Tail, Chet, TmpNechet), append(TmpNechet, [Head], Nechet)
    ).

% 7 Определите отношение repeat3(L1,L2) c аргументами - списками. 
% В списке L2 первый и последний элемент списка L1 меняются местами и 
% повторяются три раза.
repeat3([], []).
repeat3([H], [H,H,H]).
repeat3([H|T], LCH):-
    append(C, [L], T),
    append([L, L, L], C, LC),
    append(LC, [H, H, H], LCH)
    .

% 8 Определите процедуру combi(L1,L2,L3), которая помещает элементы   
% второго списка между элементами первого.
combi([], [], []).
combi(L1, [], L1).
combi([], L2, L2).
combi([H1|T1], [H2|T2], L3):- 
    append([H1, H2], Tmp, L3), 
    combi(T1, T2, Tmp)
    .




























