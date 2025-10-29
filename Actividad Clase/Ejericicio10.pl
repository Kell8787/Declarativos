
:- op(500, yfx, +).
:- op(400, yfx, -).
:- op(300, yfx, *).

% Evitar warnings por cláusulas no contiguas (por si agregas reglas luego)
:- discontiguous simplifica/2.

% ------------------------------
% 1) SIMPLIFICACIÓN simbólica
% ------------------------------

% Casos base
simplifica(X, X) :- var(X), !.
simplifica(X, X) :- number(X), !.
simplifica(X, X) :- atom(X), !.

% --- MENOS UNARIO ---
simplifica(-A, R) :-
    simplifica(A, SA),
    simplifica_neg(SA, R).

simplifica_neg(0, 0) :- !.
simplifica_neg(-B, B) :- !.        % --A → A
simplifica_neg(N, R) :- number(N), R is -N, !.
simplifica_neg(A, -A).             % deja el signo si no hay más qué hacer

% Suma
simplifica(A+B, R) :-
    simplifica(A, SA),
    simplifica(B, SB),
    simplifica_suma(SA, SB, R).

% Combinar x + x -> 2*x (caso básico de combinación)
simplifica_suma(A, A, 2*A) :- !.
simplifica_suma(0, B, B) :- !.
simplifica_suma(A, 0, A) :- !.
simplifica_suma(A, B, A+B).

% Resta
simplifica(A-B, R) :-
    simplifica(A, SA),
    simplifica(B, SB),
    simplifica_resta(SA, SB, R).

simplifica_resta(A, 0, A) :- !.
simplifica_resta(A, B, A-B).

% Producto
simplifica(A*B, R) :-
    simplifica(A, SA),
    simplifica(B, SB),
    simplifica_prod(SA, SB, R).

simplifica_prod(0, _, 0) :- !.
simplifica_prod(_, 0, 0) :- !.
simplifica_prod(1, B, B) :- !.
simplifica_prod(A, 1, A) :- !.
simplifica_prod(A, B, A*B).


% ------------------------------
% 2) DERIVACIÓN simbólica
%    derivada(Expr, Var, D)
% ------------------------------

derivada(C, _, 0) :- number(C), !.
derivada(V, V, 1) :- atom(V), !.
derivada(W, V, 0) :- atom(W), W \== V, !.

% --- DERIVADA DE MENOS UNARIO ---
derivada(-A, V, -DA) :- !, derivada(A, V, DA).

% Suma y resta
derivada(A+B, V, DA+DB) :- !, derivada(A, V, DA), derivada(B, V, DB).
derivada(A-B, V, DA-DB) :- !, derivada(A, V, DA), derivada(B, V, DB).

% Producto: (A*B)' = A'*B + A*B'
derivada(A*B, V, DA*B + A*DB) :- !, derivada(A, V, DA), derivada(B, V, DB).

% (Opcional) Si quieres que siempre salga simplificado:
% derivada_simpl(E, V, S) :- derivada(E, V, D), simplifica(D, S).


% ------------------------------
% 3) EVALUACIÓN simbólica
%    evalua(Expr, Var, Valor, Resultado)
% ------------------------------

evalua(Expr, Var, Val, R) :-
    sustituye(Expr, Var, Val, ExprSub),
    R is ExprSub.

% sustitución recursiva Var -> Val en la expresión aritmética
sustituye(N, _, _, N) :- number(N), !.
sustituye(V, V, Val, Val) :- atom(V), !.
sustituye(A, _, _, A) :- atom(A), !.

sustituye(A+B, V, Val, SA+SB) :- !, sustituye(A, V, Val, SA), sustituye(B, V, Val, SB).
sustituye(A-B, V, Val, SA-SB) :- !, sustituye(A, V, Val, SA), sustituye(B, V, Val, SB).
sustituye(A*B, V, Val, SA*SB) :- !, sustituye(A, V, Val, SA), sustituye(B, V, Val, SB).
sustituye(-A, V, Val, -SA) :- !, sustituye(A, V, Val, SA).


% ------------------------------
% 4) Fracciones simbólicas
%    Representación: frac(N, D)
% ------------------------------

mcd(A, B, G) :-
    A1 is abs(A), B1 is abs(B),
    ( B1 =:= 0 -> G = A1
    ; R is A1 mod B1, mcd(B1, R, G)
    ).

normaliza_frac(frac(N, D), frac(N2, D2)) :-
    (D < 0 -> N1 is -N, D1 is -D ; N1 = N, D1 = D),
    mcd(N1, D1, G),
    N2 is N1 // G, D2 is D1 // G.

suma(frac(A,B), frac(C,D), R) :-
    Num is A*D + C*B,
    Den is B*D,
    normaliza_frac(frac(Num, Den), R).

resta(frac(A,B), frac(C,D), R) :-
    Num is A*D - C*B,
    Den is B*D,
    normaliza_frac(frac(Num, Den), R).


% ------------------------------
% 5) Resolución simbólica sencilla
% ------------------------------

resuelve(LHS = RHS, X, V) :-
    ( LHS = (X + N) ; LHS = (N + X) ),
    number(N), number(RHS), !,
    V is RHS - N.

resuelve(LHS = RHS, X, V) :-
    ( RHS = (X + N) ; RHS = (N + X) ),
    number(N), number(LHS), !,
    V is LHS - N.


% ===========================================================
% CONSULTAS 
% ===========================================================

% -------------------------------
% 1. Simplificación simbólica
% -------------------------------
% ?- simplifica(1 * (0 + X), R).
% ?- simplifica(0 * (X + 3), R).
% ?- simplifica(X + 0, R).
% ?- simplifica(1 * (Y + 0), R).

% -------------------------------
% 2. Derivación simbólica
% -------------------------------
% ?- derivada(x*x + 3*x + 2, x, D), simplifica(D, DS).
% ?- derivada(x*x*x, x, D).
% ?- derivada(x*x - 4*x + 1, x, D), simplifica(D, DS).
% ?- derivada(5*x*x + 2*x + 7, x, D).

% -------------------------------
% 3. Evaluación simbólica
% -------------------------------
% ?- evalua(x*x + 3*x + 2, x, 3, R).
% ?- evalua(x*x - 4*x + 4, x, 2, R).
% ?- derivada(x*x + 3*x + 2, x, D), evalua(D, x, 2, R).

% -------------------------------
% 4. Suma y resta de fracciones simbólicas
% -------------------------------
% ?- suma(frac(1,2), frac(1,3), R).
% ?- suma(frac(2,5), frac(3,10), R).
% ?- resta(frac(3,4), frac(1,2), R).

% -------------------------------
% 5. Resolución simbólica sencilla
% -------------------------------
% ?- resuelve(x + 3 = 7, x, V).
% ?- resuelve(5 + x = 10, x, V).
% ?- resuelve(x + 8 = 20, x, V).
