% 1
parent(bill, joe).
parent(bill, ann).
parent(sue, joe).
parent(sue, ann).
parent(joe, tammy).
parent(paul, jim).
parent(mary, jim).
parent(ann, bob).
parent(jim, bob).

child(C, P):- parent(P, C).

male(bill).
male(joe).
male(bob).
male(jim).
male(paul).

female(sue).
female(ann).
female(tammy).
female(mary).

grandmother(Grand, Child):- parent(Parent, Child), parent(Grand, Parent), female(Grand).
% grandmother(X, bob).

grandson(Child, Grand):- child(Child, Parent), child(Parent, Grand), male(Child).
% grandson(X, paul)

different(X, Y):- X \= Y.
sister(Sister, BrotherSister):- parent(P, BrotherSister), child(Sister, P), female(Sister), different(Sister, BrotherSister).
% sister(X, joe)

aunt(Aunt, Nephew):- parent(P, Nephew), sister(Aunt, P).
% aunt(ann, tammy)

cousin(Cousin, OtherCousin):- parent(P, OtherCousin), parent(G, P), child(C, G), child(Cousin, C), different(Cousin, OtherCousin).
% cousin(bob,tammy)


% 2

likes(ellen, reading).
likes(john, computers).
likes(john, badminton).
likes(john, photo).
likes(john, reading).
likes(leonard, badminton).
likes(eric, swimming).
likes(eric, reading).
likes(eric, chess).
likes(paul, swimming).

has4Hobby(Name):- likes(Name, A), likes(Name, B), likes(Name, C), likes(Name, D), different(A, B), different(A,C), different(A,D), different(B,C), different(B,D), different(C,D).
% has4Hobby(Name)

equal(A, B):- likes(A, Z), likes(B, Z), different(A, B).
% equal(A, B)



