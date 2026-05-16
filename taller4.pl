% Hechos (Base de conocimiento)
personaje('Elara', 5, 100).
personaje('Kael', 3, 80).
personaje('Rin', 7, 120).

mision(m1, 'Bosque de Sombras', 2, 50).
mision(m2, 'Cueva del Dragón', 5, 120).
mision(m3, 'Torre Arcana', 7, 200).

inventario('Elara', [espada, escudo, pocion]).
inventario('Kael', [arco, flechas]).
inventario('Rin', [varita, grimorio, pocion, amuleto]).

requiere(m2, escudo).
requiere(m2, pocion).
requiere(m3, grimorio).
requiere(m3, pocion).

% Reglas aritmeticas y recursivas
% 1. Verificacion de nivel (Operador relacional >=)
puede_aceptar(Personaje, ID_Mision):-
    personaje(Personaje, Nivel, _),
    mision(ID_Mision, _, Dificultad, _),
    Nivel >= Dificultad.

% 2. Calculo recursivo de XP acumulada (Patron factorial de 2.1)
% Caso base: 0 misiones = 0 XP
xp_acumulada(0, 0).
% Paso recursivo: XP(N) = XP(N-1) + (30 * N)
xp_acumulada(N, Total):-
    N > 0,
    N1 is N - 1,                    % Instanciacion obligatoria antes de recursion
    xp_acumulada(N1, Prev),
    Total is Prev + (30 * N).       % Precedencia: * antes de +

% Verificacion de inventario con member/2
tiene_requerido(Personaje, Objeto):-
    inventario(Personaje, Lista),
    member(Objeto, Lista).          % Funcion built-in (2.3)

% REGLAS DE UNIFICACION Y COMPARACION
% 1. Detectar personajes del mismo nivel exacto (vs unificacion)
mismo_nivel(P1, P2):-
    personaje(P1, N, _),
    personaje(P2, N, _),
    P1 \== P2.

% 2. Validar balance aritmetio estricto
es_balanceado(Personaje):-
    personaje(Personaje, _, Vida),
    Vida =:= 100.


% PROCESAMIENTO DE LISTAS Y NLP
% 1. Fusionar inventarios de dos personajes usando append/3 (2.3)
fusionar_equipo(P1, P2, EquipoFusionado):-
    inventario(P1, L1),
    inventario(P2, L2),
    append(L1, L2, EquipoFusionado).

% 2. Base de conjugacion (Adaptacion directa de conjugar_verbo/5 en 2.3)
tiempo(presente).
tiempo(pasado).
tiempo(futuro).

persona(primera).
persona(segunda).
persona(tercera).

numero(singular).
numero(plural).

ser(presente, tercera, singular, "es").
ser(pasado, tercera, singular, "fué").
ser(futuro, tercera, singular, "será").
ser(presente, primera, singular, "soy").
ser(presente, primera, plural, "somos").

ser(presente, tercera, plural, "son").
ser(pasado,   tercera, plural, "fueron").
ser(futuro,   tercera, plural, "serán").

% 3. Regla de inferencia con estructura condicional (2.3)
conjugar_accion(Verbo, Tiempo, Persona, Numero, Conjugacion):-
    tiempo(Tiempo),
    persona(Persona),
    numero(Numero),
    ( Verbo = "ser" ->
        ( ser(Tiempo, Persona, Numero, R),
          Conjugacion = R )
    ;
        Conjugacion = Verbo ).

% 4. Generacion de reporte narrativo
generar_reporte(Personaje, MisionID, Mensaje):-
    puede_aceptar(Personaje, MisionID),
    mision(MisionID, Nombre, _, XP),
    conjugar_accion("ser", presente, tercera, singular, FormaVerbal),
    atomic_list_concat([Personaje, FormaVerbal, "capaz de completar", Nombre, "por", XP, "XP"], ' ', Mensaje).

% 4.1 Generacion de reporte narrativo grupales
% ENFOQUE 1 (PRINCIPAL)
xp_personaje(Personaje, XP) :-
    personaje(Personaje, Nivel, _),
    xp_acumulada(Nivel, XP).

xp_total_grupo(Grupo, Total) :-
    xp_total_grupo(Grupo, 0, Total).
xp_total_grupo([], Acc, Acc).
xp_total_grupo([Cabeza|Cola], Acc, Total) :-
    xp_personaje(Cabeza, XP_Cabeza),
    NuevoAcc is Acc + XP_Cabeza,
    xp_total_grupo(Cola, NuevoAcc, Total).

xp_requerida_mision(MisionID, XP_Requerida) :-
    mision(MisionID, _, Dificultad, _),
    xp_acumulada(Dificultad, XP_Requerida).

grupo_puede_por_xp(Grupo, MisionID) :-
    xp_total_grupo(Grupo, XP_Total),
    xp_requerida_mision(MisionID, XP_Requerida),
    XP_Total >= XP_Requerida.

generar_reporte_grupo(Grupo, MisionID, Mensaje) :-
    grupo_puede_por_xp(Grupo, MisionID),
    mision(MisionID, NombreMision, _, XP_Premio),
    xp_total_grupo(Grupo, XP_Total),
    xp_requerida_mision(MisionID, XP_Requerida),
    conjugar_accion("ser", presente, tercera, plural, FormaVerbal),
    atomic_list_concat(Grupo, ', ', NombresGrupo),
    atomic_list_concat(
        [NombresGrupo, FormaVerbal, "capaces de completar", NombreMision,
         "| XP del grupo:", XP_Total, "/ XP requerida:", XP_Requerida,
         "| Premio:", XP_Premio, "XP"],
        ' ', Mensaje).

% ENFOQUE 2 (SECUNDARIA)
alguno_puede([], _) :- fail.

alguno_puede([Cabeza|_], MisionID) :-
    puede_aceptar(Cabeza, MisionID), !.

alguno_puede([_|Cola], MisionID) :-
    alguno_puede(Cola, MisionID).

todos_pueden([], _).
todos_pueden([Cabeza|Cola], MisionID) :-
    puede_aceptar(Cabeza, MisionID),
    todos_pueden(Cola, MisionID).

generar_reporte_grupo_v1(Grupo, MisionID, Modo, Mensaje) :-
    ( Modo = alguno -> alguno_puede(Grupo, MisionID)
    ; Modo = todos  -> todos_pueden(Grupo, MisionID)
    ),
    mision(MisionID, NombreMision, _, XP),
    conjugar_accion("ser", presente, tercera, plural, FormaVerbal),
    atomic_list_concat(Grupo, ', ', NombresGrupo),
    atomic_list_concat(
        [NombresGrupo, FormaVerbal, "capaces de completar",
         NombreMision, "por", XP, "XP"],
        ' ', Mensaje).