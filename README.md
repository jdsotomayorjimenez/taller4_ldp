# Taller 4 - Prolog #3 - Narrativa de nivel para misiones

Este código en Prolog modela un sistema básico tipo RPG, donde existen personajes, misiones, niveles, experiencia, inventarios y requisitos. A partir de estos datos, el programa permite validar si un personaje o un grupo puede participar en una misión y generar reportes narrativos según las condiciones del juego. La lógica implementada utiliza hechos, reglas, listas, recursividad, acumuladores, comparación aritmética, backtracking y construcción de mensajes.

## Ejercicios implementados

### Base de conocimiento del RPG

El programa parte de una base de conocimiento que representa los elementos principales del juego. En ella se registran personajes con sus atributos, misiones con dificultad y recompensa, inventarios asociados a cada personaje y objetos requeridos para determinadas misiones.

Esta información funciona como el mundo inicial del RPG. A partir de estos hechos, las reglas pueden consultar datos, relacionarlos y producir conclusiones sobre qué personajes están preparados para avanzar dentro de una misión.

**Nota:** esta sección se basa en hechos declarativos, que son el punto de partida para las inferencias del programa.

### Validación de misiones e inventarios

El código permite comprobar si un personaje puede aceptar una misión comparando su nivel con la dificultad requerida. También permite revisar si un personaje posee un objeto específico dentro de su inventario.

Esta lógica es importante porque conecta las características del personaje con las condiciones de cada misión, simulando una validación típica de un RPG antes de permitir que el jugador avance.

**Nota:** se usan comparaciones aritméticas y búsqueda dentro de listas mediante `member/2`.

### Cálculo de experiencia

Se implementan predicados para calcular experiencia acumulada de forma recursiva. Esta lógica permite obtener valores de XP a partir de un número dado, como el nivel de un personaje o la dificultad asociada a una misión.

El cálculo de experiencia se utiliza como parte de la progresión del sistema, ya que permite transformar niveles o requisitos en valores numéricos comparables.

**Nota:** se aplica recursividad directa con caso base y evaluación aritmética mediante `is/2`.

### Comparación y balance de personajes

El programa incluye reglas para comparar personajes que tienen el mismo nivel y para verificar si un personaje se encuentra balanceado según su cantidad de vida.

Esta parte permite realizar consultas sobre el estado de los personajes, identificando coincidencias de nivel o condiciones específicas de balance dentro del sistema.

**Nota:** se diferencian operaciones de comparación lógica, desigualdad entre términos y comparación numérica.

### Fusión de inventarios

Se implementó una regla para unir los inventarios de dos personajes en una sola lista. Esto permite representar la combinación de recursos de un equipo dentro del RPG.

La fusión de inventarios resulta útil para simular cooperación entre personajes, ya que permite reunir los objetos disponibles de dos integrantes en una sola estructura.

**Nota:** se aplica manipulación de listas en Prolog mediante `append/3`.

### Conjugación de acciones narrativas

El programa incluye predicados relacionados con tiempo, persona, número y conjugaciones simples del verbo `ser`. Estos elementos permiten construir mensajes narrativos más naturales dentro de los reportes generados.

Esta sección conecta la lógica del juego con una salida textual más descriptiva, haciendo que los resultados no sean únicamente valores lógicos, sino mensajes interpretables.

**Nota:** se emplean reglas condicionales y validación de combinaciones gramaticales.

### Generación de reporte narrativo individual

El programa puede generar reportes narrativos para un personaje y una misión. Primero valida si el personaje cumple con las condiciones necesarias para aceptar la misión, luego obtiene los datos de la base de conocimiento y finalmente construye un mensaje usando concatenación de átomos.

Este reporte permite mostrar el resultado de una consulta de forma más clara, explicando la acción del personaje dentro del contexto del RPG.

**Nota:** esta sección integra validación lógica, consulta de hechos y generación de texto.

### Generación de reportes grupales

El ejercicio final trabaja con una lista de personajes y es la parte más importante del programa. Para resolverlo se implementaron dos enfoques distintos de validación grupal.

#### Enfoque principal: validación por XP acumulada del grupo

El primer enfoque calcula la XP acumulada de todos los personajes que forman parte del grupo. Para esto, el programa obtiene la experiencia asociada a cada personaje, suma la XP total del equipo usando recursividad con acumulador y luego compara ese resultado con la XP requerida por la misión.

Si la experiencia total acumulada por el grupo es mayor o igual a la experiencia requerida, el reporte indica que el equipo puede completar la misión. En este enfoque, el grupo se evalúa como una unidad, por lo que lo importante no es si cada personaje cumple individualmente, sino si la fuerza total del equipo alcanza el requisito.

#### Enfoque alternativo: validación individual por nivel

El segundo enfoque revisa jugador por jugador. En este caso, el programa no suma la experiencia total del grupo, sino que analiza si cada personaje cumple con el nivel requerido para aceptar la misión.

Con esta lógica se puede determinar si al menos un personaje del grupo cumple con el requisito o si todos los integrantes están preparados. Este enfoque evalúa a los personajes de manera individual y permite comparar el rendimiento de cada integrante frente a la dificultad de la misión.

#### Comparación entre ambos enfoques

La diferencia principal es que el enfoque principal mide la capacidad del grupo como conjunto mediante XP acumulada, mientras que el enfoque alternativo evalúa a cada personaje por separado según su nivel.

El enfoque por XP acumulada es más grupal y representa mejor la cooperación entre personajes. En cambio, el enfoque individual permite saber si uno o todos los jugadores cumplen por cuenta propia con la dificultad de la misión.

**Nota:** esta sección combina listas, recursividad, acumuladores, comparación aritmética y generación de reportes narrativos.

## Capturas de ejecución

#### Captura 1 — Validación de experiencia acumulada, aceptación de misión e inventario requerido

![Captura 1](capturas/1.png)

#### Captura 2 — Error por comparación aritmética con variable no instanciada y corrección con `is/2`

![Captura 2](capturas/2.png)

#### Captura 3 — Fusión de inventarios, conjugación verbal, reporte individual y comparaciones de igualdad

![Captura 3](capturas/3.png)

#### Captura 4 — Reportes grupales por XP acumulada para misiones `m2` y `m3`

![Captura 4](capturas/4.png)

#### Captura 5 — Reporte grupal con validación individual usando los modos `alguno` y `todos`

![Captura 5](capturas/5.png)

## Tabla de predicados implementados

| Predicado | Descripción |
|---|---|
| `personaje` | Hecho que registra el nombre, nivel y vida de un personaje. |
| `mision` | Hecho que registra el identificador, nombre, dificultad y recompensa de experiencia de una misión. |
| `inventario` | Hecho que asocia un personaje con una lista de objetos disponibles. |
| `requiere` | Hecho que indica qué objeto requiere una misión específica. |
| `puede_aceptar` | Regla que verifica si el nivel de un personaje es mayor o igual que la dificultad de una misión. |
| `xp_acumulada` | Regla recursiva que calcula la experiencia acumulada para un valor numérico dado. |
| `tiene_requerido` | Regla que verifica si un personaje posee un objeto dentro de su inventario. |
| `mismo_nivel` | Regla que identifica dos personajes distintos con el mismo nivel. |
| `es_balanceado` | Regla que comprueba si la vida de un personaje es exactamente igual a `100`. |
| `fusionar_equipo` | Regla que concatena los inventarios de dos personajes en una lista resultante. |
| `tiempo` | Hecho que define tiempos verbales válidos para la conjugación. |
| `persona` | Hecho que define personas gramaticales válidas. |
| `numero` | Hecho que define números gramaticales válidos. |
| `ser` | Hecho que almacena conjugaciones del verbo `ser` según tiempo, persona y número. |
| `conjugar_accion` | Regla que devuelve la conjugación de una acción según verbo, tiempo, persona y número. |
| `generar_reporte` | Regla que genera un mensaje narrativo individual para una misión aceptable. |
| `xp_personaje` | Regla que calcula la experiencia de un personaje a partir de su nivel. |
| `xp_total_grupo` | Regla que calcula la experiencia total de un grupo de personajes. |
| `xp_total_grupo` | Regla auxiliar con acumulador para sumar la experiencia de los integrantes del grupo. |
| `xp_requerida_mision` | Regla que calcula la experiencia requerida a partir de la dificultad de una misión. |
| `grupo_puede_por_xp` | Regla que verifica si la experiencia total del grupo alcanza la experiencia requerida por la misión. |
| `generar_reporte_grupo` | Regla que genera un reporte narrativo grupal usando experiencia acumulada. |
| `alguno_puede` | Regla que verifica si al menos un integrante de un grupo puede aceptar una misión. |
| `todos_pueden` | Regla que verifica si todos los integrantes de un grupo pueden aceptar una misión. |
| `generar_reporte_grupo_v1` | Regla que genera un reporte grupal según el modo `alguno` o `todos`. |

## Archivos del repositorio

| Archivo | Descripción |
|---|---|
| `taller4.pl` | Archivo fuente en Prolog que contiene la base de conocimiento, reglas de inferencia, cálculo de experiencia y generación de reportes narrativos. |
| `Capturas - Prolog 3.pdf` | Capturas de ejecución en PDF |
| `capturas/` | Carpeta con las capturas en formato PNG |
