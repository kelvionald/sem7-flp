% 4.1. #1 Красным или зеленым отсечение? Приведите пример цели, которая дает разные 
% решения при наличии отсечения в процедуре и его изъятии.
member(X,[X|_]):-!.
member(X,[_|L]):- member(X,L).

% member(a, [a,b,c]).  % выведет true

% Отсечение является красным, потому что при изъятии отсечения меняется 
% декларативный смысл процедуры, будет возвращаться несколько ответов, хотя 
% ожидался один до удаления отсечения.

% Процедура с изъятым отсечением
member2(X,[X|_]).
member2(X,[_|L]):- member2(X,L).

% member2(a, [a,b,c]).  % выведет true, false


% 4.2. #1 Написать отношение fib(N,F), которое находит по аргументу N
% (номер числа в последовательности) число Фибоначчи F. 
% Числа Фибоначчи: 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377
% Формула для нахождения числа Фибоначчи:
% F(1)=1; F(2)=1; F(3)=2; F(n+1)=F(n)+F(n-1).
% Отношение должно корректно обрабатывать свои аргументы!!!
% Должно давать только одно решение!!!
fib(1, 1):- !.
fib(2, 1):- !.
fib(N, _):-
    N =< 0,
    nl,
    print('error'),
    !
    .
fib(N, F):-
    Prev is N - 1,
    PrevPrev is N - 2,
    fib(Prev, PrevF),
    fib(PrevPrev, PrevPrevF),
    F is PrevF + PrevPrevF
    .


% 4.3.1 Отсортируйте массив методом Шелла. Сортировка Шелла алгоритм сортировки, 
% являющийся усовершенствованным  вариантом сортировки вставками. Идея метода 
% Шелла состоит в сравнении  элементов, стоящих не только рядом, но и на 
% определённом расстоянии  друг от друга. Последовательность длин промежутков:
% d(1) = N / 2, d(i) = d(i-1) / 2, d(k) = 1, где N - длина массива.


% 4.3.2  #1
% Дополните программу предикатами ввода-вывода таким образом,   чтобы мог быть реализован следующий диалог:
%   ?-sort_3.
%   list?        [3,4,2,1].
%   answer: [1,2,3,4].


% 4.4. Для каждого из перечисленных методов сортировки выполните следующее:
%   Дополните программы сортировки предикатами ввода-вывода таким образом, 
%   чтобы мог быть реализован следующий диалог:
%       ?-sort_4.
%       list?   [3,4,2,1].
%       answer: [1,2,3,4].
input_arr_for_sort(Proc):-
    write("list? "),
    read(In),
    nl,
    call(Proc, In, Out),
    write("answer: "),
    write(Out)
    .


% 4.4.1 #0.5
% Метод наивной сортировки (назвать правило sort_4_1).
order(X, Y):-
    X =< Y.

sorted([_]).
sorted([X,Y|T]):- 
    order(X,Y),
    sorted([Y|T]).

permutation(L, [H|T]):-
    append(V, [H|U], L),
    append(V, U, W),
    permutation(W, T)
    .
permutation([], []).

sort_n(In, Out):-
    permutation(In, Out),
    sorted(Out),
    !
    .

sort_4_1:-
    input_arr_for_sort(sort_n)
    .


% 4.4.2  #0.5
% Метод пузырька (назвать правило sort_4_2).
swap([X, Y|R], [Y, X|R]) :- order(Y, X).
swap([X|R], [X|R1]) :- swap(R, R1). 

busort(L, S):- 
    swap(L, M),
    !, 
    busort(M, S)
    .
busort(L, L):- !.

sort_4_2:-
    input_arr_for_sort(busort)
    .


% 4.4.3  #0.5
% Mетод вставки (назвать правило sort_4_3).
insortx(X, [A|L], [A|M]):-
    order(A, X),
    !,
    insortx(X, L, M)
    .
insortx(X, L, [X|L]).

insort([], []).
insort([X|L], M):-
    insort(L, N),
    insortx(X, N, M)
    .

sort_4_3:-
    input_arr_for_sort(insort)
    .


% 4.4.4  #0.5
% Быстрая сортировка quick (назвать правило sort_4_4).
split(H, [A|Tail], [A|Small], Big):-
    order(A, H), 
    !, 
    split(H, Tail, Small, Big)
    .
split(H, [A|Tail], Small, [A|Big]):-
    split(H, Tail, Small, Big)
    .
split(_, [], [], []).

qsort([], []).
qsort([H|Tail], S):-
    split(H, Tail, Small, Big),
    qsort(Small, Small1),
    qsort(Big, Big1),
    append(Small1, [H|Big1], S)
    .

sort_4_4:-
    input_arr_for_sort(qsort)
    .


% 4.5. #3
% Построить бесповторный упорядоченный список L3, состоящий из всех элементов, содержащихся как в списке L1, так и в списке L2.
%       Должно давать только одно решение!!!
%       ?-common([11,1,8,8,4],[6,3,2,8,6],L3).
%       дает ответ
%       L3=[1,2,3,4,6,8,11]
% make_unique(In, Out)
make_unique([], []).
make_unique([Head|Tail], Out):-
    member(Head, Tail), 
    !, 
    make_unique(Tail, Out)
    .
make_unique([Head|Tail], [Head|OutTail]):-
    make_unique(Tail, OutTail)
    .

common(L1, L2, L3):-
    append(L1, L2, Tmp),
    make_unique(Tmp, Tmp2),
    qsort(Tmp2, L3),
    !
    .


% 4.7. #3
% Определить самый распространенный элемент X в списке L. Если в списке
% несколько самых распространенных элементов, то ответ надо сделать в виде 
% списка из самых распространенных элементов.
%       Должно давать только одно решение!!!
%       ?-most_oft([a,f,8,3,a,f,a,d,g],X).
%       дает ответ
%       X=a

%       ?-most_oft([a,f,8,3,a,f,f,d,g],X).
%       дает ответ
%       X=f

%       ?-most_oft([a,f,8,3,a,a,f,f,d,g],X).
%       дает ответ
%       X=[a,f]

% most_oft(L, X):-
%     qsort(L, X)
%     .














