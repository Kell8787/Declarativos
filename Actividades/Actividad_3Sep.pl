% ejercicios de aritmetica
rectangulo :-
    write('Base: '), read(Base),
    write('Altura: '), read(Altura),
    Area is Base*Altura,
    Perimetro is 2*(Base+Altura),
    format('Area = ~w, Perimetro = ~w~n', [Area, Perimetro]).

par_impar :-
    write('Numero: '), read(N),
    ( 0 is N mod 2 -> writeln('Par') ; writeln('Impar') ).

tabla_multiplicar :-
    write('Numero: '), read(N),
    between(1,10,I),
    R is N*I,
    format('~w x ~w = ~w~n',[N,I,R]),
    fail ; true.

% operaciones relacionales
mayor :-
    write('A: '), read(A),
    write('B: '), read(B),
    ( A>B -> format('Mayor: ~w~n',[A])
    ; B>A -> format('Mayor: ~w~n',[B])
    ; writeln('Son iguales') ).

categoria_edad :-
    write('Edad: '), read(E),
    ( E=<12 -> writeln('chiquito')
    ; E=<17 -> writeln('Adolescente')
    ; E=<64 -> writeln('Adulto')
    ; writeln('Adulto mayor') ).

aprobo :-
    write('Nota: '), read(N),
    ( N>=6 -> writeln('Aprobo') ; writeln('Reprobo') ).


% Base de conocimiento
% ligadura unificacion
progenitor(rodrigo, juan).
progenitor(kelvin, sofia).
progenitor(allen, juan).
progenitor(david, sofia).

es_hermano :-
    write('Persona 1: '), read(X),
    write('Persona 2: '), read(Y),
    ( progenitor(P,X), progenitor(P,Y), X\=Y
    -> format('~w y ~w son hermanos.~n',[X,Y])
    ;  writeln('No son hermanos') ).

%funciones aritmeticas predefinidas
distancia :-
    write('X1: '), read(X1),
    write('Y1: '), read(Y1),
    write('X2: '), read(X2),
    write('Y2: '), read(Y2),
    D is sqrt((X2-X1)^2 + (Y2-Y1)^2),
    format('Distancia = ~2f~n',[D]).

grados_radianes :-
    write('Grados: '), read(G),
    R is G*pi/180,
    format('Radianes = ~4f~n',[R]).


analisis :-
    write('Lista: '), read(L),
    sum_list(L,S), length(L,N),
    Prom is S/N, min_list(L,Min), max_list(L,Max),
    format('Promedio=~2f, Min=~w, Max=~w~n',[Prom,Min,Max]).

estadisticas :-
    write('Numero: '), read(N),
    Abs is abs(N), Red is round(N), Piso is floor(N), Techo is ceiling(N),
    format('Abs=~w, Round=~w, Piso=~w, Techo=~w~n',[Abs,Red,Piso,Techo]).

%desafio integradores
calculadora :-
    write('Operacion (+,-,*,/): '), read(Op),
    write('A: '), read(A),
    write('B: '), read(B),
    ( Op=+ -> R is A+B
    ; Op=- -> R is A-B
    ; Op=* -> R is A*B
    ; Op=/, B=\=0 -> R is A/B ),
    format('Resultado=~w~n',[R]).

hipotenusa :-
    write('Cateto1: '), read(C1),
    write('Cateto2: '), read(C2),
    H is sqrt(C1^2+C2^2),
    format('Hipotenusa=~2f~n',[H]).

notas :-
    write('Notas (lista): '), read(L),
    analisis(L,Prom,extremos(Min,Max)),
    format('Promedio=~2f, Min=~w, Max=~w~n',[Prom,Min,Max]).

analisis(Lista, Prom, extremos(Min,Max)) :-
    sum_list(Lista,S), length(Lista,N),
    Prom is S/N,
    min_list(Lista,Min),
    max_list(Lista,Max).
