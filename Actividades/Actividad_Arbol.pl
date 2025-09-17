% 1) ÁRBOL N-ARIO
arbol_olimpo(
  t(caos, [
      t(gea, []),
      t(uranos, []),
      t(cronos, [
          t(hestia,   []),
          t(demeter,  []),
          t(hera,     []),
          t(zeus, [
              t(hefestos, []),
              t(ares,     []),
              t(dioniso,  []),
              t(hermes,   []),
              t(atenea,   []),
              t(artemisa, []),
              t(apolo,    []),
              t(afrodita, [])
          ]),
          t(poseidon, []),
          t(hades,    [])
      ]),
      t(rea, [])
  ])
).

% 2) POSTORDEN MOSTRANDO NULOS

% postorden_con_nulos(+Arbol, -ListaResultado)
postorden_con_nulos(t(N, []), [null, N]) :- !.
postorden_con_nulos(t(N, Hijos), Lista)  :-
    postorden_nulos_lista(Hijos, LH),
    append(LH, [N], Lista).

postorden_nulos_lista([], []).
postorden_nulos_lista([T|Ts], L) :-
    postorden_con_nulos(T, LT),
    postorden_nulos_lista(Ts, LTs),
    append(LT, LTs, L).


% 3) UTILIDADES DE IMPRESIÓN
imprimir_postorden_nulos(Arbol) :-
    postorden_con_nulos(Arbol, L),
    forall(member(X, L), (write(X), write(' '))),
    nl.

% Atajo: imprime directamente el árbol del Olimpo
imprimir_olimpo_postorden_nulos :-
    arbol_olimpo(A),
    imprimir_postorden_nulos(A).