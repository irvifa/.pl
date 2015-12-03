connected(a,b).
connected(b,c).
connected(c,a).
connected(a,e).
connected(e,c).
connected(c,d).
connected(d,e).
connected(e,b).

eulerianpath(E, Cs) :-
   setof(A-B, call(E, A,B), ABs),
   travel(ABs, Cs).

travel([], [_]).
travel(L, [X,Y|Xs]) :-
    select(A-B,L,Tmp),
    ( A = X, B = Y ; B = X, A = Y ),
    travel(Tmp, [Y|Xs]).

gen(S,L):-S=[H|T],gen(H,T,[],L).
gen(_,[],L,L):-!.
gen(H,[X|Y],T,L):-gen(X,Y,[[H,X]|T],L).

rev(S,L):-rev(S,[],L).
rev([],Z,Z).
rev([H|T],Acc,Z) :- rev(T,[H|Acc],Z).

%for the purpose of debug only
%test(L):-eulerianpath(connected,L).

solver(S):-eulerianpath(connected,L),gen(L,Z),rev(Z,S).

% Find all possible path
sum_of_solution(S):-findall(T,solver(T),Z),length(Z,S).