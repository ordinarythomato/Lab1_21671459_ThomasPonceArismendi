#lang racket
(provide ELEMENT-TYPE)
;; TDA CARD ;;

; 1) Definiciones previas para TDA
; 1.1) Ennumeración de los tipos de Carta a considerar
(define CARD-TYPE '(pokemon trainer energy))
(define (card-type? t)
  (and (symbol? t) (member t CARD-TYPE) ))
; Descripción: Función que verifica que una entrada "t" sea un tipo de carta siempre y cuando sea un símbolo perteneciente a la lista CARD-TYPE
; Dominio: t (CARD-TYPE)
; Recorrido: boolean
; Tipo de Recursión: No aplica

; 1.2) Enumeración de Tipos de Elementos
(define ELEMENT-TYPE '(grass fire water lightning psychic fighting darkness metal colorless fairy))
(define (element-type? t)
  (and (symbol? t) (member t ELEMENT-TYPE)))
; Descripción: Función que verifica si la entrada es un elemento verdadero siempre y cuando sea un símbolo perteneciente a la lista ELEMENT-TYPE
; Dominio: t (ELEMENT-TYPE)
; Recorrido: boolean
; Tipo de Recursión: No aplica

; 1.3) Asignación de tipos a cada elemento de una carta
(define ENERGY
  '((fire-energy      . fire)
    (water-energy     . water)
    (grass-energy     . grass)
    (lightning-energy . lightning)
    (psychic-energy   . psychic)
    (fighting-energy  . fighting)
    (darkness-energy  . darkness)
    (metal-energy     . metal)
    (fairy-energy     . fairy)
    (colorless-energy . colorless)))

; 2) Capa de Modelación
(define empty-card
  (lambda ()
    (list 'pokemon "Nameless" '() 0 '() '() '() 0 #f '() '())))
; Descripción: Carta vacía que retorna una lista de 11 variables, en representación del máximo de variables de una carta
; Dominio: null
; Recorrido: list
; Tipo de Recursión: No Aplica

; 3) Capa de Construcción
(define card
  (lambda (chosen-card-type name . list_of_arguments)
    (if (card-type? chosen-card-type)
    (cons chosen-card-type (cons name list_of_arguments))
    (raise "Error: Unvalid type of card")
    )))
; Descripción: Función constructora de carta que recibe 3 variables: un tipo de carta, un nombre de carta y una lista de argumentos.
; Si la entrada contiene un tipo de carta perteneciente a CARD-TYPE, entonces se retorna una lista única con todas las variables presentes.
; Dominio: chosen-card-type (CARD-TYPE) X name (string) X list_of_arguments (list)
; Recorrido: list
; Tipo de Recursión: No Aplica

; 4) Capa de Selección
; 4.1) Definiciones previas
(define MIN_HP 0) ; Punto de salud más bajo para una Carta Pokémon
(define MIN_ATAQUE 0) ; Ataque más bajo que puede influir en Carta Pokémon
(define TRAINER-TYPE '(item supporter)); Item -> Carta de Entrenador Objeto | Supporter -> Carta de Entrenador Partidario

; 4.2) Funciones de Selección para Card general (Card Getters)
; |OBSERVACIÓN|: Los Selectores (o "Getters") se han definido primero porque ayudan a armar y validar las funciones de las capas sucesoras  (Pertenencia y demás)

(define GetCardType
  (lambda (Carta)(car Carta)))
; Descripción: Función para obtener Tipo de Carta (1er elemento), consultando: Pertenece el primer elemento de la carta a la lista de Tipos de Carta.
; Dominio: (Carta) (card)
; Recorrido: (CARD-TYPE)
; Tipo de Recursión: No Aplica

(define GetName
  (lambda (Carta)
    (cadr Carta)
    ))
; Descripción: Obtener nombre de carta (2do elemento)
; Dominio: (Carta) (card)
; Recorrido: string
; Tipo de Recursión: No Aplica

; 4.3) Funciones de Selección para Carta Pokemon
; Estructura: (TypeOfCard name EvolvesFrom HP TypeOfPokemon Weakness Resistance RetiringCost IsEx? Ability ListOfAttacks)

(define GetEvolutionAscendant (lambda (Carta) (caddr Carta)))
; Descripción: Obtener Pokemon del que evolucionó la Carta Pokemon evaluada (Tercer elemento)
; Dominio: (Carta) (card)
; Recorrido: (caddr Carta) (string v null)
; Tipo de Recursión: No Aplica

(define GetHP (lambda (Carta) (cadddr Carta)))
; Descripción: Obtener Puntos de Salud (Cuarto elemento)
; Dominio: (Carta) (card)
; Recorrido: (cadddr Carta) (integer)
; Tipo de Recursión: No Aplica

(define GetTypeOfPokemon (lambda (Carta) (car (cddddr Carta))))
; Descripción: Obtener Tipo Elemental del Pokemon evaluado (Quinto elemento)
; Dominio: (Carta) (card)
; Recorrido: (car (cddddr Carta)) (ELEMENT-TYPE)
; Tipo de Recursión: No Aplica

(define GetWeakness (lambda (Carta) (cadr (cddddr Carta))))
; Descripción: Obtener Debilidad del Pokemon (Sexto elemento)
; Dominio: (Carta) (card)
; Recorrido: (cadr (cddddr Carta)) (ELEMENT-TYPE)
; Tipo de Recursión: No Aplica

(define GetResistance (lambda (Carta) (caddr (cddddr Carta))))
; Descripción: Obtener Tipo Elemental que provoca Resistencia en el Pokemon (Séptimo elemento)
; Dominio: (Carta) (card)
; Recorrido: (caddr (cddddr Carta)) (ELEMENT-TYPE)
; Tipo de Recursión: No Aplica

(define GetRetiringCost (lambda (Carta) (cadddr (cddddr Carta))))
; Descripción: Obtener Costo de Retiro, expresado en un cantidad entera positiva de Incoloros (Octavo elemento)
; Dominio: (Carta) (card)
; Recorrido: (cadddr (cddddr Carta)) (integer)
; Tipo de Recursión: No Aplica

(define GetExState (lambda (Carta) (car (cddddr (cddddr Carta)))))
; Descripción: Obtener estado Ex del Pokemon (Noveno elemento)
; Dominio: (Carta) (card)
; Recorrido: (car (cddddr (cddddr Carta))) (boolean)
; Tipo de Recursión: No Aplica

(define GetAbility (lambda (Carta) (cadr (cddddr (cddddr Carta)))))
; Descripción: Obtener Habilidad del Pokemon (Décimo elemento)
; Dominio: (Carta) (card)
; Recorrido: (cadr (cddddr (cddddr Carta))) (list)
; Tipo de Recursión: No Aplica

(define GetListOfAttacks (lambda (Carta) (caddr (cddddr (cddddr Carta)))))
; Descripción: Obtener Lista de Ataques (Undécimo elemento)
; Dominio: (Carta) (card)
; Recorrido: (caddr (cddddr (cddddr Carta))) (list)
; Tipo de Recursión: No Aplica

; 4.5) Funciones de Selección para Carta de Entrenador
; Estructura de Carta de Entrenador: (TypeOfCard name TrainerType description ActionsFunction)
; GetTypeOfCard -> Previamente definida
; GetName -> Previamente definida
(define GetTrainerType (lambda (Carta) (caddr Carta)))
; Descripción: Función para obtener el subtipo de Entrenador de la carta (Para ver si es Objeto o Partidario)
; Dominio: (Carta) (card)
; Recorrido: (cadddr Carta) (TRAINER_TYPE)
; Tipo de Recursión: No Aplica

(define GetTrainerDescription (lambda (Carta) (car (cddddr Carta))))
; Descripción: Función para obtener la descripción adjunta a la Carta de Entrenador evaluada
; Dominio: (Carta) (card)
; Recorrido: (car (cddddr Carta)) (string)
; Tipo de Recursión: No Aplica

(define GetActionsFunction (lambda (Carta) (cadr (cddddr Carta))))
; Descripción: Función para obtener el Componente de Función de Acciones, perteneciente a la Carta de Entrenador,
; donde la Función de Acciones será considerada una variable de tipo procedure
; Dominio: (Carta) (card)
; Recorrido: (cadr (cddddr Carta)) (procedure)
; Tipo de Recursión: No Aplica

; 4.6) Función de Selección para Carta de Energía
; Estructura de Carta de Energía: (TypeOfCard name EnergyType)
(define GetTypeOfEnergy (lambda (Carta) (caddr Carta)))
; Descripción: Obtener Tipo de Energía para Carta de Energía (Tercer elemento)
; Dominio: (Carta) (card)
; Recorrido: (caddr Carta) (ELEMENT-TYPE)
; Tipo de Recursión: No Aplica

; 5.1) Función de Pertenencia para Carta en General
(define IsCard?
  (lambda (Carta)
    (and (card-type? (GetCardType Carta)) (string? (GetName Carta)) (or (list? (cdr Carta)) (null? (cdr Carta)))
    )))
; Descripción: Función para verificar que una carta cualquiera pertenezca al objeto card (del que derivan las Cartas Pokemon, Entrenador y Energía)
; Dominio: (Carta) (Card)
; Recorrido: boolean
; Tipo de Recursión: No Aplica

; 5.2) Función de Pertenencia para Carta Pokemon
(define IsPokemonCard?
  (lambda (Carta)
    (and (IsCard? Carta) (integer? (GetHP Carta)) (> (GetHP Carta) MIN_HP) (list? (GetListOfAttacks Carta))
         (list? (GetAbility Carta))
         (or (string? (GetEvolutionAscendant Carta)) (null? (GetEvolutionAscendant Carta))) (boolean? (GetExState Carta))
         (member (GetTypeOfPokemon Carta) ELEMENT-TYPE) (element-type? (GetWeakness Carta)) (element-type? (GetResistance Carta))
         (or (>= (GetRetiringCost Carta) 1) (null? (GetRetiringCost Carta))))
    ))
; Descripción: Función que verifica que una lista hecha a partir del constructor card sea una carta con atributos de carta Pokemon.
; Dominio: (Carta) (card)
; Recorrido: boolean
; Tipo de Recursión: No Aplica

; |OBSERVACIÓN|: El Costo de Retiro de un Pokemon puede ser de dos tipos: Entero (valor mayor o igual a 1), o Vacío (en representación de que el Pokemon no tiene costo de retiro).
; 5.3) Función de Pertenencia para Carta de Energía
(define IsEnergyCard?
  (lambda (Carta)
    (and (IsCard? Carta) (member (GetTypeOfEnergy Carta) ELEMENT-TYPE))
     ))
; Descripción: Función que comprueba si una carta hecha a través del constructor card es una carta de energía
; Dominio: (Carta) (card)
; Recorrido: boolean
; Tipo de Recursión: No Aplica

; 5.4) Función de Pertenencia para Carta de Entrenador
(define IsTrainerCard?
  (lambda (Carta)
    (and (IsCard? Carta) (member (GetTrainerType Carta) TRAINER-TYPE) (string? (GetTrainerDescription Carta)) (procedure? (GetActionsFunction Carta)))
    ))
; Descripción: Función que comprueba si una carta hecha a través del constructor card es una carta de entrenador
; Dominio: (Carta) (card)
; Recorrido: boolean
; Tipo de Recursión: No Aplica

; 6) Capa de modificación (Funciones Setters)
; 6.1) Funciones de Modificación para Carta Pokemon
(define SetHP
  (lambda
      (CartaPokemon NewHP)
    (if (and (IsPokemonCard? CartaPokemon) (integer? NewHP))
         (card (GetCardType CartaPokemon) (GetName CartaPokemon) (GetEvolutionAscendant CartaPokemon)
               NewHP (GetTypeOfPokemon CartaPokemon) (GetWeakness CartaPokemon) (GetResistance CartaPokemon)
               (GetRetiringCost CartaPokemon) (GetExState CartaPokemon) (GetAbility CartaPokemon)
               (GetListOfAttacks CartaPokemon))
         (raise "Error. Input Card has no correct Pokemon data or input Health Points are unvalid")
         )))
; Descripción: Función que altera el valor de los Puntos de Salud de un Pokemon
; Dominio: (CartaPokemon) (card) x (NewHP) (integer)
; Recorrido: (CartaPokemon) (card)
; Tipo de Recursión: No aplica