% Relaciones de parentesco
parent(jose, mathew).
parent(jose, daniel).
parent(christina, daniel).
parent(christina, mathew).
parent(christina, jane).
parent(mathew, andy).
parent(mathew, fabio).
parent(mathew, jim).
parent(julie, jim).
parent(julie, andy).
parent(julie, fabio).
parent(julie, maya).
parent(victoria, julie).
parent(victoria, jack).
parent(victoria, marco).
parent(juan, julie).
parent(juan, jack).
parent(juan, marco).
parent(daniel, sophia).
parent(daniel, sebastian).
parent(jessica, sophia).
parent(jessica, sebastian).
parent(analia, jessica).
parent(analia, ingrid).
parent(giuseppe, jessica).
parent(giuseppe, ingrid).
parent(giuseppe, gino).

% Género
male(jose).
male(mathew).
male(daniel).
female(christina).
female(jane).
female(andy).
male(fabio).
male(jim).
female(julie).
female(maya).
female(victoria).
male(jack).
male(marco).
male(juan).
female(sophia).
male(sebastian).
female(jessica).
female(analia).
female(ingrid).
male(giuseppe).
male(gino).

% Reglas de parentesco
father(X, Y) :- parent(X, Y), male(X).
mother(X, Y) :- parent(X, Y), female(X).
brother(X, Y) :- parent(Z, X), parent(Z, Y), male(X), X \= Y.
sister(X, Y) :- parent(Z, X), parent(Z, Y), female(X), X \= Y.
grandfather(X, Y) :- parent(X, Z), parent(Z, Y), male(X).
grandmother(X, Y) :- parent(X, Z), parent(Z, Y), female(X).
uncle(X, Y) :- brother(X, Z), parent(Z, Y).
aunt(X, Y) :- sister(X, Z), parent(Z, Y).
cousin(X, Y) :- parent(Z, X), parent(W, Y), Z \= W, (brother(Z, W); sister(Z, W)).

% Nivel de consanguinidad
levelConsanguinity(X, 1) :- father(X, _); mother(X, _).
levelConsanguinity(X, 2) :- brother(X, _); sister(X, _).
levelConsanguinity(X, 3) :- uncle(X, _); aunt(X, _).
levelConsanguinity(X, 3) :- cousin(X, _).

% Porcentaje de herencia
percentLegacy(1, 30).
percentLegacy(2, 20).
percentLegacy(3, 10).

% Distribución de herencia
legacyMoney(_, [], []).  
legacyMoney(LegacyTotal, [Family|F], [Distribution|F2]) :-
    levelConsanguinity(Family, Level),              
    percentLegacy(Level, Percent),                   
    Distribution is (LegacyTotal * (Percent / 100)),  
    legacyMoney(LegacyTotal, F, F2).    

% Predicado para distribuir herencia
distribute_legacy(LegacyTotal, Heirs) :-
    legacyMoney(LegacyTotal, Heirs, Distributions),
    write('Distributions: '), write(Distributions), nl.