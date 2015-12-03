/**
* Generate solution for N-Queens problem
*/

solution(_,[]):-!.
solution(N,[X/Y|Others]) :-
 gen(N,L),solution(N,Others),member(Y, L),
 noattack(X/Y, Others).

noattack(_,[]).
 
noattack(X/Y,[X1/Y1|Others]) :-
 Y =\= Y1,
 Y1 - Y =\= X1 - X,
 Y1 - Y =\= X - X1,
 noattack(X/Y,Others).
 
member(Item,[Item|_]).
 
member(Item,[_|Rest]) :-
 member(Item,Rest).
 
% generate a list
gen(N, L) :- gen(N, [], L).

gen(0, L, L) :- !.
gen(N, R, L) :- N > 0, N1 is N-1, gen(N1, [N|R], L).

var(N,L):-length(L,N).
unif([],[],_).
unif([HL|L],[HR|R],[HL/HR|S]):-unif(L,R,S).

% map of solver

row(_,[]):-!.
row(I,[_/Y|Tail]):- (I = Y), write(*),row(I,Tail),!.
row(I,[_|Tail]):- write(-), row(I,Tail).

col(0,_):- !.
col(I,X):- row(I,X),put(10),I1 is I - 1, col(I1,X).

draw(S):- length(S,L),col(L,S).

% solver
queens(N,S):-gen(N,L),var(N,R),unif(L,R,S),solution(N,S),draw(S).