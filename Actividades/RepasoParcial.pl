% Don Ernesto maestro(Jubilado) y esposo de Teresa 


trabaja_en(ernesto, jubilado).
trabaja_en(teresa, jubilado).

casado_con(teresa, carlos).

%Hijos de Teresa y Ernesto
hijo(carlos, ernesto).
hijo(ana, ernesto).
hijo(lucia, ernesto).
padre(ernesto, carlos).
padre(ernesto, ana)
padre(ernesto, lucia)

hijo(carlos, teresa).
hijo(ana, teresa).
hijo(lucia, teresa).
madre(teresa, carlos).
madre(teresa, ana).
madre(teresa, lucia).



% Carlos casado con Sofia (Arqui) hijos son ana
trabaja_en(carlos, civil).
trabaja_en(sofia, arqui).

casado_con(sofia, carlos).

%Hijos de Sofia y Carlos
hijo(mateo, carlos).
hijo(valeria, carlos).
padre(carlos, mateo).
padre(carlos, valeria).

hijo(mateo, sofia).
hijo(valeria, sofia).
madre(sofia, mateo).
madre(sofia, valeria).

%Lo que hace Ana
trabaja_en(ana, maestra).

%Hijo de Anda
hijo(andres, ana).
madre(ana, andres).

trabaja_en(lucia, estudiande_medicina).

%Primos Lucia(hija de carlos) y Daniel
primo(lucia, daniel).

%Ricardo y Carlos mejores amigos
amigo(carlos, ricardo).

trabaja_en(ricardo, abogado).

casado_con(ricardo, laura).

%Hijos de Laura y Ricardo
hijo(daniel,ricardo).
hijo(daniel,laura).
padre(ricador, daniel).
madre(laura, daniel).

amigo(daniel, mateo).
amigo(daliel, valeria).
amigo(mateo, valeria).
amigo(laura, valeria).

trabaja_en(laura, bibliotecaria).

%Miguel hermano de Ernesto
trabaja_en(miguel, agricultor).

casado_con(miguel, rosa).

trabaja_en(rosa, administradora_empresas).

hijo(fernanda, miguel).
hijo(fernanda, rosa).
padre(miguel, fernanda).
madre(rosa, fernanda).

primo(fernanda, andres).
primo(fernanda, valeria).
primo(fernanda, mateo).

amigo(carmen, teresa).

trabaja_en(carmen, partera).

amigo(isabel, fernanda).

trabaja_en(felipe, comerciante).

amigo(felipe, miguel).

hijo(juaquin, felipe).
padre(felipe, juaquin).

amigo(andres, juaquin).


trabaja_en(daniel, estudiante).
trabaja_en(mateo, estudiante).
trabaja_en(valeria, estudiante).

%Residencias
vive_en(ernesto, valle_verde).
vive_en(teresa,  valle_verde).
vive_en(carlos, capital).
vive_en(sofia,   capital).
vive_en(mateo,   capital).
vive_en(valeria, capital).
vive_en(ana,     valle_verde).
vive_en(andres,  valle_verde).
vive_en(lucia,   capital).
vive_en(miguel,  valle_verde).
vive_en(rosa,    valle_verde).
vive_en(fernanda, capital).
vive_en(ricardo, capital).
vive_en(laura,   capital).
vive_en(daniel,  capital).
vive_en(carmen,  valle_verde).
vive_en(isabel,  capital).
vive_en(felipe,  capital).
vive_en(joaquin, valle_verde).


%REGLAS
% Abuelos y abuelas

abuelo(A, N) :- padre(A, P), (padre(P, N) ; madre(P, N)).
abuela(A, N) :- madre(A, P), (padre(P, N) ; madre(P, N)).

% Hermanos/as: comparten al menos un progenitor (y no son la misma persona)

hermanos(X, Y) :- X \= Y, ( (padre(P, X), padre(P, Y)) ; (madre(M, X), madre(M, Y)) ).

% Tío/Tía: hermano/a de un progenitor o cónyuge de ese hermano/a

tio_tia(T, S) :- ( padre(P, S) ; madre(P, S) ), (  hermanos(T, P) ;  (casado_con(T, C), hermanos(C, P)) ).

% Primos/as: sus progenitores son hermanos

primo_regla(A, B) :- A \= B, ( padre(PA, A) ; madre(PA, A) ), ( padre(PB, B) ; madre(PB, B) ), hermanos(PA, PB).

% Nota: combinamos los hechos explícitos "primo/2" con la regla general.
es_primo(A, B) :- primo(A, B).
es_primo(A, B) :- primo_regla(A, B).

% "Amigo de un primo": X es amigo de algún primo de Y
amigo_de_primo(X, Y) :- es_primo(Y, P), amigo(X, P).

