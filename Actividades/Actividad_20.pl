% Personas en la mansion
persona(alice).
persona(robert).
persona(clara).
persona(james).

% Relaciones
esposo(alice, lord_henry).
sobrina(clara, lord_henry).
socio(james, lord_henry).
empleado(robert, lord_henry).

% Motivos (quién podría tener razones)
motivo(alice, herencia).
motivo(robert, maltrato).
motivo(clara, deuda).
motivo(james, negocios).

% Medios (quién tuvo acceso al arma)
acceso(alice, veneno).
acceso(robert, cuchillo).
acceso(clara, cuerda).
acceso(james, pistola).

% Oportunidad (quién estuvo en la biblioteca)
estuvo(alice, sala).
estuvo(robert, cocina).
estuvo(clara, biblioteca).
estuvo(james, estudio).

% Reglas
persona(X).
motivo(X, _) :- persona(X).
estuvo(X, biblioteca) :- persona(X).
estuvo(X, biblioteca) :- persona(X) , motivo(X, _).
acceso(X, cuerda).
acceso(X, cuerda):-motivo(X, deuda), estuvo(X, biblioteca). 
motivo(X, deuda), estuvo(X, biblioteca), acceso(X, cuerda).