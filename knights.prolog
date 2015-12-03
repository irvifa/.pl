dist(1,2).
dist(2,1).
dist(2,-1).
dist(1,-2).
dist(-1,-2).
dist(-2,-1).
dist(-2,1).
dist(-1,2).

move(Boundary,X1/Y1,X2/Y2) :- 
   dist(X,Y), 
   X2 is X1+X, X2 > 0, X2 =< Boundary,
   Y2 is Y1+Y, Y2 > 0, Y2 =< Boundary.

knights(_,0,Knights,Knights).
knights(N,M,Visited,Knights) :-
   Visited = [X/Y|_],
   move(N,X/Y,U/V),
   \+ member(U/V,Visited),
   M1 is M-1,
   knights(N,M1,[U/V|Visited],Knights).

knights(N,Knights) :- M is N*N-1,  knights(N,M,[1/1],Knights).

findall_solution(N,S) :- findall(Knights,knights(N,Knights),L), length(L,S).