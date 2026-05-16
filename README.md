# Taller 4 - Prolog #3 - Narrativa de nivel para misiones

## 1. Título y descripción

Este taller corresponde a una continuación del trabajo con el lenguaje de programación lógica Prolog, aplicado a la construcción de una narrativa de nivel para misiones dentro de un entorno de juego. El código modela personajes, misiones, inventarios y requisitos, y permite inferir si un personaje o un grupo puede completar una misión según su nivel o su experiencia acumulada. Se implementaron predicados para calcular experiencia de forma recursiva, consultar inventarios mediante listas, comparar valores, conjugar acciones y generar reportes narrativos, aplicando conceptos como hechos, reglas, unificación, comparación aritmética, recursividad, acumuladores, listas, predicados integrados y control del backtracking.

## 2. Ejercicios implementados

### Base de conocimiento de personajes, misiones, inventarios y requisitos

Esta sección define los hechos principales del dominio del taller. Los predicados `personaje/3`, `mision/4`, `inventario/2` y `requiere/2` almacenan la información necesaria para representar personajes con nivel y vida, misiones con dificultad y recompensa, objetos disponibles en el inventario y objetos requeridos por ciertas misiones. Esta base de conocimiento permite que las reglas posteriores consulten datos concretos mediante unificación.

**Nota:** esta parte se basa en hechos declarativos y sirve como punto de partida para las inferencias del programa.

### Verificación de aceptación de misiones y consulta de objetos requeridos

El predicado `puede_aceptar/2` determina si un personaje puede aceptar una misión comparando su nivel con la dificultad de la misión mediante el operador relacional `>=`. Además, `tiene_requerido/2` consulta si un personaje posee un objeto determinado dentro de su inventario usando `member/2` sobre una lista.

**Nota:** se aplican comparación aritmética y procesamiento de listas con un predicado integrado de Prolog.

### Cálculo recursivo de experiencia acumulada

El predicado `xp_acumulada/2` calcula la experiencia total acumulada a partir de un número de misiones o niveles. La regla usa un caso base para `0` y un paso recursivo que reduce el valor de `N` hasta llegar al caso base, acumulando `30 * N` en cada retorno de la recursión.

**Nota:** esta sección evidencia recursividad directa, uso de caso base, instanciación previa con `is/2` y evaluación aritmética.

### Comparación, unificación y balance de personajes

El predicado `mismo_nivel/2` identifica personajes que tienen exactamente el mismo nivel, evitando que el mismo personaje se compare consigo mismo mediante `\==`. Por su parte, `es_balanceado/1` valida si la vida de un personaje es exactamente `100` usando comparación aritmética con `=:=`.

**Nota:** se diferencian conceptos de unificación, desigualdad estricta entre términos y comparación aritmética.

### Procesamiento de listas para fusión de inventarios

El predicado `fusionar_equipo/3` obtiene los inventarios de dos personajes y los combina en una sola lista mediante `append/3`. Esto permite formar un equipo fusionado con los objetos de ambos personajes.

**Nota:** se utiliza manipulación de listas y se conserva el orden de los elementos de los inventarios originales.

### Conjugación de acciones narrativas

Esta sección define los predicados `tiempo/1`, `persona/1`, `numero/1` y `ser/4` para representar una base simple de conjugaciones del verbo `ser`. El predicado `conjugar_accion/5` valida tiempo, persona y número, y luego usa una estructura condicional para devolver la conjugación correspondiente cuando el verbo recibido es `"ser"`; en caso contrario, devuelve el verbo original.

**Nota:** se aplica una estructura condicional con `->` y `;`, además de backtracking cuando se consultan combinaciones posibles con variables libres.

### Generación de reporte narrativo individual

El predicado `generar_reporte/3` construye un mensaje narrativo para un personaje y una misión. Primero valida que el personaje pueda aceptar la misión, luego obtiene el nombre y la experiencia de recompensa, conjuga el verbo `ser` en tercera persona singular y finalmente une todos los fragmentos del mensaje con `atomic_list_concat/3`.

**Nota:** combina inferencia lógica, consulta de hechos, reutilización de predicados y construcción de texto.

### Generación de reporte narrativo grupal por experiencia acumulada

El enfoque principal de reportes grupales calcula si un grupo puede completar una misión con base en experiencia acumulada. `xp_personaje/2` calcula la experiencia asociada al nivel de cada personaje, `xp_total_grupo/2` inicia el cálculo total del grupo, `xp_total_grupo/3` realiza la acumulación recursiva, `xp_requerida_mision/2` calcula la experiencia requerida por la dificultad de la misión y `grupo_puede_por_xp/2` compara ambas cantidades. Finalmente, `generar_reporte_grupo/3` produce un mensaje narrativo con los nombres del grupo, la experiencia total, la experiencia requerida y el premio de la misión.

**Nota:** esta sección destaca el uso de recursividad con acumulador y composición de reglas para resolver una validación grupal.

### Generación de reporte grupal con modos de validación

El enfoque secundario permite evaluar grupos con dos modos: `alguno` y `todos`. El predicado `alguno_puede/2` verifica si al menos un personaje del grupo puede aceptar la misión, mientras que `todos_pueden/2` exige que todos los integrantes la puedan aceptar. Con estos resultados, `generar_reporte_grupo_v1/4` genera un mensaje narrativo dependiendo del modo solicitado.

**Nota:** `alguno_puede/2` usa recursividad y corte (`!`) para detener la búsqueda cuando encuentra el primer personaje válido; `todos_pueden/2` usa recursividad para validar todos los elementos de la lista.

## 3. Tabla de predicados implementados

| Predicado | Aridad | Descripción |
|---|---:|---|
| `personaje` | 3 | Hecho que registra el nombre, nivel y vida de un personaje. |
| `mision` | 4 | Hecho que registra el identificador, nombre, dificultad y recompensa de experiencia de una misión. |
| `inventario` | 2 | Hecho que asocia un personaje con una lista de objetos disponibles. |
| `requiere` | 2 | Hecho que indica qué objeto requiere una misión específica. |
| `puede_aceptar` | 2 | Regla que verifica si el nivel de un personaje es mayor o igual que la dificultad de una misión. |
| `xp_acumulada` | 2 | Regla recursiva que calcula la experiencia acumulada para un valor numérico dado. |
| `tiene_requerido` | 2 | Regla que verifica si un personaje posee un objeto dentro de su inventario. |
| `mismo_nivel` | 2 | Regla que identifica dos personajes distintos con el mismo nivel. |
| `es_balanceado` | 1 | Regla que comprueba si la vida de un personaje es exactamente igual a `100`. |
| `fusionar_equipo` | 3 | Regla que concatena los inventarios de dos personajes en una lista resultante. |
| `tiempo` | 1 | Hecho que define tiempos verbales válidos para la conjugación. |
| `persona` | 1 | Hecho que define personas gramaticales válidas. |
| `numero` | 1 | Hecho que define números gramaticales válidos. |
| `ser` | 4 | Hecho que almacena conjugaciones del verbo `ser` según tiempo, persona y número. |
| `conjugar_accion` | 5 | Regla que devuelve la conjugación de una acción según verbo, tiempo, persona y número. |
| `generar_reporte` | 3 | Regla que genera un mensaje narrativo individual para una misión aceptable. |
| `xp_personaje` | 2 | Regla que calcula la experiencia de un personaje a partir de su nivel. |
| `xp_total_grupo` | 2 | Regla pública que inicia el cálculo de experiencia total de un grupo. |
| `xp_total_grupo` | 3 | Regla auxiliar con acumulador para sumar la experiencia de los integrantes del grupo. |
| `xp_requerida_mision` | 2 | Regla que calcula la experiencia requerida a partir de la dificultad de una misión. |
| `grupo_puede_por_xp` | 2 | Regla que verifica si la experiencia total del grupo alcanza la experiencia requerida por la misión. |
| `generar_reporte_grupo` | 3 | Regla que genera un reporte narrativo grupal usando experiencia acumulada. |
| `alguno_puede` | 2 | Regla que verifica si al menos un integrante de un grupo puede aceptar una misión. |
| `todos_pueden` | 2 | Regla que verifica si todos los integrantes de un grupo pueden aceptar una misión. |
| `generar_reporte_grupo_v1` | 4 | Regla que genera un reporte grupal según el modo `alguno` o `todos`. |

## 4. Capturas de ejecución

#### Captura 1 — Validación de experiencia acumulada, aceptación de misión e inventario requerido
![Captura 1](capturas/1.png)

#### Captura 2 — Error por comparación aritmética con variable no instanciada y corrección con `is/2`
![Captura 2](capturas/2.png)

#### Captura 3 — Fusión de inventarios, conjugación verbal, reporte individual y comparaciones de igualdad
![Captura 3](capturas/3.png)

#### Captura 4 — Reportes grupales por experiencia acumulada para misiones `m2` y `m3`
![Captura 4](capturas/4.png)

#### Captura 5 — Reporte grupal con modos `alguno` y `todos`
![Captura 5](capturas/5.png)

## 5. Archivos del repositorio

| Archivo | Descripción |
|---|---|
| `README.md` | Documento principal del repositorio con la descripción del taller, ejercicios, predicados, capturas y archivos. |
| `taller4.pl` | Archivo fuente en Prolog que contiene la base de conocimiento, reglas de inferencia, cálculo de experiencia y generación de reportes narrativos. |
| `Capturas - Prolog 3.pdf` | Documento PDF que recopila evidencias de ejecución del taller en el entorno de Prolog. |
| `capturas/1.png` | Captura de consultas sobre `xp_acumulada/2`, `puede_aceptar/2` y `tiene_requerido/2`. |
| `capturas/2.png` | Captura que muestra el error de comparación aritmética con variable no instanciada y el uso correcto de `is/2`. |
| `capturas/3.png` | Captura de consultas sobre fusión de inventarios, conjugación del verbo `ser`, generación de reporte individual y pruebas de igualdad. |
| `capturas/4.png` | Captura de consultas de `generar_reporte_grupo/3` con grupos que cumplen o no la experiencia requerida. |
| `capturas/5.png` | Captura de consultas de `generar_reporte_grupo_v1/4` usando los modos `alguno` y `todos`. |
