% Data
color(red; green; yellow; blue; ivory).
nation(english; spanish; ukranian; norweian; japanese).
pet(dog;snails;fox;horse;zebra).
drink(water;juice;cofee;milk;tea).
brand(kools;oldgold;chesterfields;luckystrike;parliaments).


% A house is described by its color, ..., brand. 

house(C,N,P,D,B,I) :- color(C), prop(C,I), nation(N), prop(N, I), pet(P), prop(P,I), 
                        drink(D), prop(D,I), brand(B), prop(B, I).

% There are five houses 
numHouses(5).

% Generation of posible solutions: It is chosen one (and only one) color, ..., brand for
% each house.

1{prop(C,I) : color(C)}1 :- numHouses(H), I=1..H.
1{prop(N,I) : nation(N)}1 :-  numHouses(H), I=1..H.
1{prop(P,I) : pet(P)}1 :-  numHouses(H), I=1..H.
1{prop(D,I) : drink(D)}1 :-   numHouses(H), I=1..H.
1{prop(B,I) : brand(B)}1 :-   numHouses(H), I=1..H.

% All of the houses have different colors, ..., brands. That is the same, it can not exist a
% model in which two different houses have the same quality.

:- prop(Q,I), prop(Q,J), I != J.


% Specific constraints:

% The Englishman lives in the red house.
:- prop(red,I), prop(english,J), I != J. 

% The Spaniard owns the dog.
:- prop(dog,I), prop(spanish, J), I != J.

% Coffee is drunk in the green house.
:- prop(cofee,I), prop(green, J), I != J.

% The Ukrainian drinks tea.
:- prop(ukranian,I), prop(tea, J), I != J.

% The green house is immediately to the right of the ivory house.
:- prop(green,I), prop(ivory, J), I != J + 1.

% The Old Gold smoker owns snails.
:- prop(oldgold,I), prop(snails, J), I != J.

% Kools are smoked in the yellow house.
:- prop(kools,I), prop(yellow, J), I != J.

% Milk is drunk in the middle house.
:- not prop(milk,3).

% The Norwegian lives in the first house.
:- not prop(norweian,1).

% The man who smokes Chesterfields lives in the house next to the man with the fox.
:- prop(chesterfields,I), prop(fox, J), |I-J|!=1.

% Kools are smoked in the house next to the house where the horse is kept.
:- prop(kools, I), prop(horse,J), |I-J|!=1.

% The Lucky Strike smoker drinks orange juice.
:- prop(luckystrike, I), prop(juice, J), I != J.

% The Japanese smokes Parliaments.
:- prop(japanese,I), prop(parliaments, J), I != J.

% The Norwegian lives next to the blue house.
:- prop(norweian, I), prop(blue,J), |I-J|!=1.


#show house/6.

% If we want to view explictely the who owns zebra, and who drinks water.

% zebrasOwner(W) :- nation(W), prop(W,I), prop(zebra,I).
% drinksWater(W) :- nation(W), prop(W,I), prop(water,I).

% #show zebrasOwner/1.
% #show drinksWater/1.






