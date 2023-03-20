% Data
square(1,1,4). square(1,2,8). square(1,3,1). square(1,4,6). square(1,5,3). square(1,6,2). square(1,7,5). square(1,8,7).
square(2,1,3). square(2,2,6). square(2,3,7). square(2,4,2). square(2,5,1). square(2,6,6). square(2,7,5). square(2,8,4).
square(3,1,2). square(3,2,3). square(3,3,4). square(3,4,8). square(3,5,2). square(3,6,8). square(3,7,6). square(3,8,1).
square(4,1,4). square(4,2,1). square(4,3,6). square(4,4,5). square(4,5,7). square(4,6,7). square(4,7,3). square(4,8,5).
square(5,1,7). square(5,2,2). square(5,3,3). square(5,4,1). square(5,5,8). square(5,6,5). square(5,7,1). square(5,8,2).
square(6,1,3). square(6,2,5). square(6,3,6). square(6,4,7). square(6,5,3). square(6,6,1). square(6,7,8). square(6,8,4).
square(7,1,6). square(7,2,4). square(7,3,2). square(7,4,3). square(7,5,5). square(7,6,4). square(7,7,7). square(7,8,8).
square(8,1,8). square(8,2,7). square(8,3,1). square(8,4,4). square(8,5,2). square(8,6,3). square(8,7,5). square(8,8,6).

% For each pair of squares in the same row and with the same value, one of them is 
% chosen as darkened.
darkened(I,J); darkened(I,K):- square(I,J,V), square(I,K,V), K>J.

% For each pair of squares in the same column and with the same value, one of them is 
% chosen as darkened.
darkened(I,J); darkened(U,J):- square(I,J,V), square(U,J,V), U>I.

% Darkened squares can not be connected (considering 4-adjacency).
:- darkened(I,J), darkened(U,K), |I-U|+|J-K| = 1.

% CWH - All square that is not known to be darkened, is undarkened.
undarkened(I,J) :- square(I,J,V), not darkened(I,J).

% Define 4-connection.
% Two squares are connected if both are undarkened, and are adjacent horizontal or vertical (diagonal are not considered as adjacent).
connected(I,J,U,K) :- undarkened(I,J), undarkened(U,K), U>=I, K>=J, |I-U|+|J-K|=1.
connected(U,K,I,J) :- connected(I,J,U,K).

% Transitive clousure of the 4-connectivity relation.
connected(I,J,U,K) :- connected(I,J,M,N), connected(M,N,U,K).

% Each pair of undarkened squares must be connected.
:- undarkened(I,J),  undarkened(U,K), U >= I, K >= J, (U-I)+(K-J) > 0, not connected(I,J,U,K).

#show darkened/2.