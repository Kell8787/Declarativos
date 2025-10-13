% Sistema simple de empleados en Prolog
% Permite listar, agregar, eliminar y actualizar empleados

:- set_prolog_flag(encoding, utf8).
:- dynamic empleado/3.

% Datos iniciales
empleado('Ana', contabilidad, 900).
empleado('Luis', sistemas, 1200).
empleado('Sofía', marketing, 1100).

% Para imprimir líneas o encabezados
linea(Parte) :-
    ( Parte = menu_top -> writeln('% ========= MENÚ =========')
    ; Parte = menu_bot -> writeln('% ========================')
    ; Parte = lista_top -> writeln('% --- LISTA DE EMPLEADOS ---')
    ; Parte = lista_bot -> writeln('% ----------------------------')
    ).

% Muestra un empleado en formato más ordenado
imprimir_empleado(Nombre, Depto, Salario) :-
    format('% Nombre: ~w | Depto: ~w | Salario: $~w~n', [Nombre, Depto, Salario]).

% Mostrar todos los empleados
listar_empleados :-
    linea(lista_top),
    (   empleado(N, D, S),
        imprimir_empleado(N, D, S),
        fail
    ;   true
    ),
    linea(lista_bot).

% Agregar un nuevo empleado
agregar_empleado(Nombre, Depto, Salario) :-
    asserta(empleado(Nombre, Depto, Salario)),
    format('% Se agregó a ~w en el departamento ~w con salario $~w.~n',
           [Nombre, Depto, Salario]).

% Eliminar un empleado
eliminar_empleado(Nombre) :-
    retract(empleado(Nombre, Depto, Salario)),
    format('% 🗑️  Se eliminó a ~w del departamento ~w (salario $~w).~n',
           [Nombre, Depto, Salario]), !.
eliminar_empleado(Nombre) :-
    format('% No se encontró a ~w para eliminar.~n', [Nombre]).

% Cambiar datos de un empleado
actualizar_empleado(Nombre, NuevoDepto, NuevoSalario) :-
    retract(empleado(Nombre, _, _)),
    asserta(empleado(Nombre, NuevoDepto, NuevoSalario)),
    format('% Datos actualizados: ~w → Depto: ~w | Salario: $~w~n',
           [Nombre, NuevoDepto, NuevoSalario]), !.
actualizar_empleado(Nombre, _, _) :-
    format('% No se encontró a ~w para actualizar.~n', [Nombre]).

% Agregar solo si no existe el mismo registro
agregar_unico_empleado(Nombre, Depto, Salario) :-
    (   empleado(Nombre, Depto, Salario)
    ->  format('% El empleado ~w ya existe con esos datos.~n', [Nombre])
    ;   asserta(empleado(Nombre, Depto, Salario)),
        format('% Se agregó a ~w en ~w con salario $~w.~n',
               [Nombre, Depto, Salario])
    ).

% Eliminar todos los registros
eliminar_todos_empleados :-
    retractall(empleado(_,_,_)),
    writeln('% Todos los empleados han sido eliminados de la base.').

% Mostrar el menú principal
mostrar_menu :-
    linea(menu_top),
    writeln('% 1. Listar empleados'),
    writeln('% 2. Agregar empleado'),
    writeln('% 3. Eliminar empleado'),
    writeln('% 4. Actualizar empleado'),
    writeln('% 5. Agregar con validación'),
    writeln('% 6. Eliminar todos'),
    writeln('% 0. Salir'),
    linea(menu_bot).

% Simulación del funcionamiento paso a paso
main :-
    writeln('% =========================================='),
    writeln('% SISTEMA DE EMPLEADOS EN PROLOG'),
    writeln('% Simulación de una sesión con el menú principal'),
    writeln('% =========================================='),
    nl,
    writeln('% Inicio del sistema'),
    writeln('?- main.'),
    writeln('% SISTEMA DE EMPLEADOS INICIADO'),
    mostrar_menu,
    writeln('% Seleccione una opción: 1.'),
    nl,
    listar_empleados, nl,

    writeln('% Seleccione una opción: 2.'),
    writeln("% Nombre: 'Carlos'."),
    writeln("% Departamento: 'ventas'."),
    writeln('% Salario: 950.'),
    agregar_empleado('Carlos', ventas, 950), nl,

    writeln('% Seleccione una opción: 4.'),
    writeln("% Nombre: 'Luis'."),
    writeln("% Nuevo departamento: 'infraestructura'."),
    writeln('% Nuevo salario: 1400.'),
    actualizar_empleado('Luis', infraestructura, 1400), nl,

    writeln('% Seleccione una opción: 3.'),
    writeln("% Nombre a eliminar: 'Ana'."),
    eliminar_empleado('Ana'), nl,

    writeln('% Seleccione una opción: 1.'),
    listar_empleados, nl,

    writeln('% Fin de la simulación del sistema de empleados'),
    writeln('% ==========================================').
