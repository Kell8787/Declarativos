estudiante(kelvin).
estudiante(raul).
estudiante(florence).
estudiante(mauricio).
estudiante(melisa).

% Hacer si  Ellacuria es estudiante

no_es_estudiante(Nombre) :- \+ estudiante(ellacuria).

% optener solo el primer estudiante de la lista.Con Corte

estudiante(Nombre) :- estudiante(_), !.

% Con fallo listar todos los estudianes usando FAIL

mostrar_estudiantes :-
    estudiante(Nombre),
    write('Estudiante: '), write(Nombre), nl,
    fail.
mostrar_estudiantes.

% Entrada/Salida pedir al usuario un nombre y verificar si es estudiante o no.

es_estudiante :- 
    write('Ingrese un nombre: '), read(Nombre),
    ( estudiante(Nombre) != false
    ->  write('Es estudiante')
    ;   write('No es estudiante')
    ).
