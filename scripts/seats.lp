% Data

couple(ana,benito).
couple(jesus,julia).
couple(david,antonio).
couple(petra,pavel).
couple(carla,sara).

conflict(ana,(jesus;sara)).
conflict(benito,(antonio;pavel)).
conflict(jesus,antonio).
conflict(julia,(carla;sara)).
conflict(david,petra).
conflict(pavel,carla).

% NOTE: We suppose that different people have different names and each couple is 
% given only once (in an unique tuple).

% The position and direction must be fixed for breaking the simetry of the problem
% You can select an arbitrary couple, position and direction. You must include the 
% the following fact with filling the holes with an arbitrary couple

% posC(_,_,0,0). 

posC(ana, benito, 0,0).

% General rules - DO NOT CHANGE IT

% Calculate the number of couples from the data.
ncouples(N) :- N = #count {X,Y : couple(X,Y)}.


% Generate the permutations of the couple positions. That is for each couple select a position
% and an order, such that different couples have different position, and one same couple has
% an unique order.

1{posC(L1,L2,P,O) : P=0..(N-1), O=0..1}1 :- couple(L1,L2), ncouples(N). 

:- posC(A,_,P,_), posC(C,_,P,_), A != C.
:- posC(_,_,P,O1), posC(_,_,P,O2), O1 != O2.


% We calculate the position of each person, related to the assignment of the couples.

pos(A,2*P+O):- posC(A,B,P,O).
pos(B,2*P+1-O) :- posC(A,B,P,O).


% We calculate the distance between each pair of diners (in both directions). 

dist(A,B,D) :- 
    pos(A,P1), pos(B,P2), P2>P1, ncouples(N),  D=#min{P2-P1; 2*N-(P2-P1)}.

dist(B,A,D) :- dist(A,B,D).

:- dist(A,B,D1), dist(A,B,D2), D1 != D2.

% Two conflictive people must be separated by two diners.

:- conflict(A,B), dist(A,B,D), D<3.


#show pos/2.
 

%#maximize {D : dist(jesus, antonio, D)}. % ==> We obtain 5

dist(jesus, antonio, 5).

%#maximize {D : dist(pavel, ana, D)}. % ==> We obtain 4

dist(pavel, ana, 4).