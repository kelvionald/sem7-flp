% 5.1 #3 Загрузите из файла программу FWGC.PL. Найдите решения.
% FWGC.PL START

% transport:-  go(state(l,l,l,l),state(r,r,r,r)).

opposite(l,r).
opposite(r,l).

go(S,G):-
  path(S,G,[S],L3),
  nl,write('A solution is:'),nl,
  write_path(L3),
  fail.
go(_,_).

path(S,G,L,L1):-
    move(S,S1),
    not( unsafe(S1) ),
    not( member(S1,L) ),
    path( S1,G,[S1|L],L1),
    !
    .
path(G,G,T,T):-!.   /* Конечное состояние достигнуто  */

move(state(X,X,G,C),state(Y,Y,G,C)):-opposite(X,Y). /* FARMER + WOLF    */
move(state(X,W,X,C),state(Y,W,Y,C)):-opposite(X,Y). /* FARMER + GOAT    */
move(state(X,W,G,X),state(Y,W,G,Y)):-opposite(X,Y). /* FARMER + CABBAGE */
move(state(X,W,G,C),state(Y,W,G,C)):-opposite(X,Y). /* ONLY FARMER	  */

unsafe( state(F,X,X,_) ):- opposite(F,X).  /* Волк ест козу    */
unsafe( state(F,_,X,X) ):- opposite(F,X).  /* Коза ест капусту */

member(X,[X|_]).
member(X,[_|L]):-member(X,L).

write_move( state(X,W,G,C), state(Y,W,G,C) ) :-!,
    write('The farmer crosses the river from '),
    write(X),
    write(' to '),
    write(Y),nl
    .

write_move( state(X,X,G,C), state(Y,Y,G,C) ) :-!,
    write('The farmer takes the Wolf from '),
    write(X),
    write(' of the river to '),
    write(Y),nl
    .

write_move( state(X,W,X,C), state(Y,W,Y,C) ) :-!,
    write('The farmer takes the Goat from' ),
    write(X),
    write(' of the river to '),
    write(Y),nl
    .
    
write_move( state(X,W,G,X), state(Y,W,G,Y) ) :-!,
    write('The farmer takes the cabbage from '),
    write(X),
    write(' of the river to '),
    write(Y),nl
    .
	       
write_path( [H1,H2|T] ) :- !,
    write_move(H1,H2),
    write_path([H2|T])
    .
write_path(_).

% FWGC.PL END

% F, W, G, C
% а) фермер перевозит волка, козла и капусту на другой берег.
trans_a:-
    go(state(l,l,l,l),state(r,r,r,r)).

% A solution is:                                                                  
% The farmer takes the Goat fromr of the river to l                               
% The farmer crosses the river from l to r                                        
% The farmer takes the cabbage from r of the river to l                           
% The farmer takes the Goat froml of the river to r                               
% The farmer takes the Wolf from r of the river to l                              
% The farmer crosses the river from l to r                                        
% The farmer takes the Goat fromr of the river to l                               
% true.


% b) фермер перевозит волка, козла и капусту на другой берег, а сам возвращается.
trans_b:-
    go(state(l,l,l,l),state(l,r,r,r)).
    
% false


% c) фермер перевозит на другой берег волка и козла, а капуста уже находится на том берегу.
trans_c:-
    go(state(l,l,l,r),state(r,r,r,r)).
    
% A solution is:                                                                  
% The farmer takes the Goat fromr of the river to l                               
% The farmer crosses the river from l to r                                        
% The farmer takes the Wolf from r of the river to l                              
% true.


% d) фермер перевозит на другой берег волка и козла, а капусту оставляет.
trans_d:-
    go(state(l,l,l,l),state(r,r,r,l)).

% A solution is:                                                                  
% The farmer takes the Wolf from r of the river to l                              
% The farmer crosses the river from l to r                                        
% The farmer takes the Goat fromr of the river to l                               
% true. 


% e) фермер перевозит на другой берег волка и капусту, а козёл  уже ждет на том берегу.
trans_e:-
    go(state(l,l,r,l),state(r,r,r,r)).

% A solution is:                                                                  
% The farmer takes the Goat fromr of the river to l                               
% The farmer crosses the river from l to r                                        
% The farmer takes the cabbage from r of the river to l                           
% The farmer takes the Goat froml of the river to r                               
% The farmer takes the Wolf from r of the river to l                              
% true. 

% Сравните с решением на Haskell.
% Ответ представляем в комментариях

% Решение на Haskell строит список решений и ведет по нему поиск конечного состояния.
% Решение на Prolog строит один список состояний перебирая возможные пути достижения конечного состояния.




% В доме с комнатами a, b,c,d,e,f,g,h,i,j,k,l необходимо пройти до комнаты g и l.
door(a, b).
door(b, c).
door(b, e).

door(d, e).
door(d, c).
door(d, h).
door(e, f).

door(h, f).
door(f, i).
door(i, k).
door(k, l).

door(e, j).
door(j, g).
door(j, l).
door(j, i).

% 5.2 # 1 Напечатать список комнат, через которые лежит путь к комнате G, выбранный Прологом.
path2(Goal, Goal, Path):-
    write('Path: '),
    write(Path),
    nl,
    !
    .
path2(Start, Goal, Path):-
    door(Start, Tmp),
    not(member(Tmp, Path)),
    append(Path, [Tmp], NewPath),
    path2(Tmp, Goal, NewPath),
    !
    ;
    door(Tmp, Start),
    not(member(Tmp, Path)),
    append(Path, [Tmp], NewPath),
    path2(Tmp, Goal, NewPath)
    .
% path2(a,g,[]).


% 5.3 #1 При входе в комнату X печатать "entering room X".
path3(Start, _, _):-
    write('Entering room '),
    write(Start), 
    nl, 
    fail
    .
path3(Goal, Goal, Path):-
    reverse(Path, Answer), 
    write('Path: '),
    write(Answer),
    nl,
    !
    .
path3(Start, Goal, Path):-
    (door(Start, Tmp);door(Tmp, Start)), 
    not(member(Tmp, Path)), 
    path3(Tmp, Goal, [Tmp|Path]),
    !
    .
% path3(a,c,[]).


% 5.4 #1 посчитать и напечатать количество комнат, через которые надо пройти к G
path4(Goal, Goal, Path):-
    length(Path, PathLen),
    reverse(Path, Reversed),
    write('Length: '),
    write(PathLen),
    nl,
    write('Path: '),
    write(Reversed),
    nl,
    !
    .
path4(Start, Goal, Path):-
    (door(Start, Tmp); door(Tmp, Start)), 
    not(member(Tmp, Path)),
    path4(Tmp, Goal, [Tmp|Path]),
    !
    .
% path5(a,g,[]).


% 5.5 #1 Пройти к комнате L ,не входя в комнату E.
path5(Goal, Goal, Path):- 
    reverse(Path, Reversed), 
    write('Path: '),
    write(Reversed), 
    nl, 
    !
    .
path5(Start, Goal, Path):- 
    Start \= e, 
    (door(Start, Tmp); door(Tmp, Start)), 
    not(member(Tmp, Path)),
    path5(Tmp, Goal, [Tmp|Path]), 
    !
    .
% path5(a,l,[]).


% 5.6 #1 Найти и напечатать все возможные пути из комнаты А в комнату L.
path6(Goal, Goal, Path):-
    reverse(Path, Answer), 
    write('Path: '),
    write(Answer),
    nl,
    !
    .
path6(Start, Goal, Path):- 
    (door(Start, Tmp); door(Tmp, Start)), 
    not(member(Tmp, Path)), 
    path6(Tmp, Goal, [Tmp|Path])
    .
% path6(a, l, [])


% 5.7 #2  В некоторых комнатах есть окна. Например, в комнате H их целых три.  Надо посчитать количество окон в комнатах, через которые лежит путь  к комнате L.

% 5.8 #2  Найти самый короткий путь к комнате L, используя assert и retract. Идея состоит в следующем: надо задать заведомо самый длинный путь way(М), а затем, перебирая все возможные пути к L, заменять way(M) на более короткий,используя при этом assert и retract.

% 5.9 #2  Сделать то же, что в пункте 5.8, но без assert и retract.

% 5.10 #4 Найти кратчайший путь, проходящий через все комнаты с кладом   (клад в комнате обозначается знаком $)

% Оформление ответа:

% в комментариях пишем номер задания и текст задания, например

% /*5.3 При входе в комнату X печатать "entering room X".*/

% Затем пишем код (вне комментариях)

% Правила называем в соответствии с заданием. Например, для выполнения задания 5.2. используется правило path2, для задания 5.3 - правило path3 и т,д.












