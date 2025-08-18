% Aves
ave(loro).
ave(aguila).
ave(pinguino).

% Qué come cada ave
come(loro, semillas).
come(aguila, carne).
come(pinguino, pescado).

% Regla
comida(X) :- ave(X), X \= aguila.
