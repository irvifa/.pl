connected(a,b).
connected(b,c).
connected(c,a).
connected(a,e).
connected(e,c).
connected(c,d).
connected(d,e).
connected(e,b).

eulerianpath(Edges, Res) :-
   setof(From-To, call(Edges, From, To), Acc),
   travel(Acc, Res).

travel([], [_]).
travel(L, [Now,Next|Rest]) :-
    select(From-To,L,Tmp),
    ( From = Now, To = Next ; To = Now,From = Next ),
    travel(Tmp, [Next|Rest]).

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