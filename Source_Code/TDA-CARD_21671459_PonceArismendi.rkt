#lang racket
(provide ELEMENT-TYPE element-type? IsPokemonCard? empty-card IsCard? IsBasicPokemonCard? GetName IsTrainerCard?)
;; TDA CARD ;;

; 1) Definiciones previas para TDA
; 1.1) Ennumeración de los tipos de Carta a considerar
(define CARD-TYPE '(pokemon trainer energy))
(define (card-type? t)
  (and (symbol? t) (member t CARD-TYPE) ))
; Descripción: Función que verifica que una entrada "t" sea un tipo de carta siempre y cuando sea un símbolo perteneciente a la lista CARD-TYPE
; Dominio: t (CARD-TYPE)
; Recorrido: (boolean)
; Tipo de Recursión: No aplica

; 1.2) Enumeración de Tipos de Elementos
(define ELEMENT-TYPE '(grass fire water lightning psychic fighting darkness metal colorless fairy))
(define (element-type? t)
  (and (symbol? t) (member t ELEMENT-TYPE)))
; Descripción: Función que verifica si la entrada es un elemento verdadero siempre y cuando sea un símbolo perteneciente a la lista ELEMENT-TYPE
; Dominio: t (ELEMENT-TYPE)
; Recorrido: (boolean)
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
; Dominio: (null)
; Recorrido: (list)
; Tipo de Recursión: No Aplica

; 3) Capa de Construcción
(define card
  (lambda (chosen-card-type name . list_of_arguments)
    (if (card-type? chosen-card-type)
    (cons chosen-card-type (cons name list_of_arguments))
    (raise "Error: Unvalid type of card")
    )))
; Descripción: Función constructora de carta (card) que recibe 3 variables: un tipo de carta, un nombre de carta y una lista variable de argumentos
; Si la entrada contiene un tipo de carta perteneciente a CARD-TYPE, entonces se retorna una lista única con todas las variables presentes
; Dominio: chosen-card-type (CARD-TYPE) X name (string) X list_of_arguments (list)
; Recorrido: list
; Tipo de Recursión: No Aplica

; 4) Capa de Selección
; 4.1) Definiciones previas
(define MIN_HP 0) ; Punto de salud más bajo para una Carta Pokémon
(define TRAINER-TYPE '(item supporter)); Item -> Carta de Entrenador Objeto | Supporter -> Carta de Entrenador Partidario

(define (trainer-type? t)
  (and (symbol? t) (member t TRAINER-TYPE)))
; Descripción: Función que verifica si la entrada es un tipo de Carta de Entrenador verdadera siempre y cuando sea un símbolo perteneciente a la lista TRAINER-TYPE
; Dominio: t (TRAINER-TYPE)
; Recorrido: (boolean)
; Tipo de Recursión: No aplica


; 4.2) Funciones de Selección para Card general (Card Getters)
; |OBSERVACIÓN|: Los Selectores (o "Getters") se han definido primero porque ayudan a armar y validar las funciones de las capas sucesoras  (Pertenencia y demás)

(define GetCardType
  (lambda (Carta)(car Carta)))
; Descripción: Función para obtener Tipo de Carta (1er elemento)
; Dominio: Carta (card)
; Recorrido: (CARD-TYPE)
; Tipo de Recursión: No Aplica

(define GetName
  (lambda (Carta)
    (cadr Carta)
    ))
; Descripción: Obtener nombre de carta (2do elemento)
; Dominio: Carta (card)
; Recorrido: cadr Carta (string)
; Tipo de Recursión: No Aplica

; 4.3) Funciones de Selección para Carta Pokemon
; Estructura: (TypeOfCard name EvolvesFrom HP TypeOfPokemon Weakness Resistance RetiringCost IsEx? Ability ListOfAttacks)

(define GetEvolutionAscendant (lambda (Carta) (caddr Carta)))
; Descripción: Obtener Pokemon del que evolucionó la Carta Pokemon evaluada (Tercer elemento)
; Dominio: Carta (card)
; Recorrido: caddr Carta (string v null)
; Tipo de Recursión: No Aplica

(define GetHP (lambda (Carta) (cadddr Carta)))
; Descripción: Obtener Puntos de Salud (Cuarto elemento)
; Dominio: Carta (card)
; Recorrido: cadddr Carta (integer)
; Tipo de Recursión: No Aplica

(define GetTypeOfPokemon (lambda (Carta) (car (cddddr Carta))))
; Descripción: Obtener Tipo Elemental del Pokemon evaluado (Quinto elemento)
; Dominio: Carta (card)
; Recorrido: car (cddddr Carta) (ELEMENT-TYPE)
; Tipo de Recursión: No Aplica

(define GetWeakness (lambda (Carta) (cadr (cddddr Carta))))
; Descripción: Obtener Debilidad del Pokemon (Sexto elemento)
; Dominio: Carta (card)
; Recorrido: cadr (cddddr Carta) (ELEMENT-TYPE)
; Tipo de Recursión: No Aplica

(define GetResistance (lambda (Carta) (caddr (cddddr Carta))))
; Descripción: Obtener Tipo Elemental que provoca Resistencia en el Pokemon (Séptimo elemento)
; Dominio: Carta (card)
; Recorrido: caddr (cddddr Carta) (ELEMENT-TYPE)
; Tipo de Recursión: No Aplica

(define GetRetiringCost (lambda (Carta) (cadddr (cddddr Carta))))
; Descripción: Obtener Costo de Retiro, expresado en un cantidad entera positiva de Incoloros (Octavo elemento)
; Dominio: Carta (card)
; Recorrido: cadddr (cddddr Carta) (integer)
; Tipo de Recursión: No Aplica

(define GetExState (lambda (Carta) (car (cddddr (cddddr Carta)))))
; Descripción: Obtener estado Ex del Pokemon (Noveno elemento)
; Dominio: Carta (card)
; Recorrido: car (cddddr (cddddr Carta)) (boolean)
; Tipo de Recursión: No Aplica

(define GetAbility (lambda (Carta) (cadr (cddddr (cddddr Carta)))))
; Descripción: Obtener Habilidad del Pokemon (Décimo elemento)
; Dominio: Carta (card)
; Recorrido: cadr (cddddr (cddddr Carta)) (list)
; Tipo de Recursión: No Aplica

(define GetListOfAttacks (lambda (Carta) (caddr (cddddr (cddddr Carta)))))
; Descripción: Obtener Lista de Ataques (Undécimo elemento)
; Dominio: Carta (card)
; Recorrido: caddr (cddddr (cddddr Carta)) (list)
; Tipo de Recursión: No Aplica

; 4.5) Funciones de Selección para Carta de Entrenador
; Estructura de Carta de Entrenador: (TypeOfCard name TrainerType description ActionsFunction)
; GetTypeOfCard -> Previamente definida
; GetName -> Previamente definida
(define GetTrainerType (lambda (Carta) (caddr Carta)))
; Descripción: Función para obtener el subtipo de Entrenador de la carta (Para ver si es Objeto o Partidario)
; Dominio: Carta (card)
; Recorrido: cadddr Carta (TRAINER_TYPE)
; Tipo de Recursión: No Aplica

(define GetTrainerDescription (lambda (Carta) (car (cddddr Carta))))
; Descripción: Función para obtener la descripción adjunta a la Carta de Entrenador evaluada
; Dominio: Carta (card)
; Recorrido: (car (cddddr Carta)) (string)
; Tipo de Recursión: No Aplica

(define GetActionsFunction (lambda (Carta) (cadr (cddddr Carta))))
; Descripción: Función para obtener el Componente de Función de Acciones, perteneciente a la Carta de Entrenador,
; donde la Función de Acciones será considerada una variable de tipo procedure
; Dominio: Carta (card)
; Recorrido: cadr (cddddr Carta) (procedure)
; Tipo de Recursión: No Aplica

; 4.6) Función de Selección para Carta de Energía
; Estructura de Carta de Energía: (TypeOfCard name EnergyType)
(define GetTypeOfEnergy (lambda (Carta) (caddr Carta)))
; Descripción: Obtener Tipo de Energía para Carta de Energía (Tercer elemento)
; Dominio: Carta (card)
; Recorrido: caddr Carta (ELEMENT-TYPE)
; Tipo de Recursión: No Aplica

; 5.1) Función de Pertenencia para Carta en General
(define IsCard?
  (lambda (Carta)
    (and (card-type? (GetCardType Carta)) (string? (GetName Carta)) (or (list? (cdr Carta)) (null? (cdr Carta)))
    )))
; Descripción: Función para verificar que una carta cualquiera pertenezca al objeto card (del que derivan las Cartas Pokemon, Entrenador y Energía)
; Dominio: Carta (card)
; Recorrido: (boolean)
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
; Descripción: Función que verifica que una lista hecha a partir del constructor card sea una carta con atributos de carta Pokemon
; Dominio: Carta (card)
; Recorrido: (boolean)
; Tipo de Recursión: No Aplica

(define IsBasicPokemonCard?
  (lambda (Carta)
    (and (IsPokemonCard? Carta) (equal? null (GetEvolutionAscendant Carta)))
    )
  )
; Descripción: Función que verifica que una Carta Pokemon sea de tipo Básica (lo que implica que no posee antepasado evolutivo)
; Dominio: Carta (card)
; Recorrido: (boolean)
; Tipo de Recursión: No Aplica

; |OBSERVACIÓN|: El Costo de Retiro de un Pokemon puede ser de dos tipos: Entero (valor mayor o igual a 1), o Vacío (en representación de que el Pokemon no tiene costo de retiro)
; 5.3) Función de Pertenencia para Carta de Energía
(define IsEnergyCard?
  (lambda (Carta)
    (and (IsCard? Carta) (member (GetTypeOfEnergy Carta) ELEMENT-TYPE))
     ))
; Descripción: Función que comprueba si una carta hecha a través del constructor card es una carta de energía
; Dominio: Carta (card)
; Recorrido: (boolean)
; Tipo de Recursión: No Aplica

; 5.4) Función de Pertenencia para Carta de Entrenador
(define IsTrainerCard?
  (lambda (Carta)
    (and (IsCard? Carta) (member (GetTrainerType Carta) TRAINER-TYPE) (string? (GetTrainerDescription Carta)) (procedure? (GetActionsFunction Carta)))
    ))
; Descripción: Función que comprueba si una carta hecha a través del constructor card es una carta de entrenador
; Dominio: Carta (card)
; Recorrido: (boolean)
; Tipo de Recursión: No Aplica

; 6) Capa de modificación (Funciones Setters)
; 6.1) Funciones de Modificación para Carta Pokemon
; Estructura: (TypeOfCard name EvolvesFrom HP TypeOfPokemon Weakness Resistance RetiringCost IsEx? Ability ListOfAttacks)
(define SetPokemonHP
  (lambda
      (CartaPokemon NewHP)
    (if (and (IsPokemonCard? CartaPokemon) (integer? NewHP))
         (card (GetCardType CartaPokemon) (GetName CartaPokemon) (GetEvolutionAscendant CartaPokemon)
               NewHP (GetTypeOfPokemon CartaPokemon) (GetWeakness CartaPokemon) (GetResistance CartaPokemon)
               (GetRetiringCost CartaPokemon) (GetExState CartaPokemon) (GetAbility CartaPokemon)
               (GetListOfAttacks CartaPokemon))
         (raise "Error. Input Card has no correct Pokemon data or input Health Points number is unvalid")
         )))
; Descripción: Función que altera el valor de los Puntos de Salud de un Pokemon, desde una entrada Carta Pokemon y un nuevo puntaje de salud
; Dominio: CartaPokemon (card) X NewHP (integer)
; Recorrido: CartaPokemon (card)
; Tipo de Recursión: No aplica

(define SetPokemonName
  (lambda
      (CartaPokemon NewName)
    (if (and (IsPokemonCard? CartaPokemon) (string? NewName))
         (card (GetCardType CartaPokemon) NewName (GetEvolutionAscendant CartaPokemon)
               (GetHP CartaPokemon) (GetTypeOfPokemon CartaPokemon) (GetWeakness CartaPokemon) (GetResistance CartaPokemon)
               (GetRetiringCost CartaPokemon) (GetExState CartaPokemon) (GetAbility CartaPokemon)
               (GetListOfAttacks CartaPokemon))
         (raise "Error. Input Card has no correct Pokemon data or input Pokemon Name is unvalid")
         ))
  )
; Descripción: Función que altera el valor de nombre de un Pokemon, desde una entrada Carta Pokemon y un string que será el nuevo nombre
; Dominio: CartaPokemon (card) X NewName (string)
; Recorrido: CartaPokemon (card)
; Tipo de Recursión: No aplica

(define SetEvolutionAscendantName
  (lambda
      (CartaPokemon AscendantName)
    (if (and (IsPokemonCard? CartaPokemon) (or (string? AscendantName)(null? AscendantName)))
         (card (GetCardType CartaPokemon) (GetName CartaPokemon) AscendantName
               (GetHP CartaPokemon) (GetTypeOfPokemon CartaPokemon) (GetWeakness CartaPokemon) (GetResistance CartaPokemon)
               (GetRetiringCost CartaPokemon) (GetExState CartaPokemon) (GetAbility CartaPokemon)
               (GetListOfAttacks CartaPokemon))
         (raise "Error. Input Card has no correct Pokemon data or input Ascendant Name is unvalid")
         ))
  )
; Descripción: Función que altera el dato de predecesor evolutivo del Pokemon, desde una entrada Carta Pokemon y un string que será el nombre del ancestro evolutivo
; Dominio: CartaPokemon (card) X AscendantName (string)
; Recorrido: CartaPokemon (card)
; Tipo de Recursión: No aplica

(define SetPokemonWeakness
  (lambda
      (CartaPokemon Weakness)
    (if (and (IsPokemonCard? CartaPokemon) (element-type? Weakness))
         (card (GetCardType CartaPokemon) (GetName CartaPokemon) (GetEvolutionAscendant CartaPokemon)
               (GetHP CartaPokemon) (GetTypeOfPokemon CartaPokemon) Weakness (GetResistance CartaPokemon)
               (GetRetiringCost CartaPokemon) (GetExState CartaPokemon) (GetAbility CartaPokemon)
               (GetListOfAttacks CartaPokemon))
         (raise "Error. Input Card has no correct Pokemon data or input Weakness is unvalid")
         ))
  )
; Descripción: Función que altera el dato de Debilidad del Pokemon, desde una entrada Carta Pokemon y un símbolo de tipo elemental que será la debilidad del pokemon
; Dominio: CartaPokemon (card) X Weakness (ELEMENT-TYPE)
; Recorrido: CartaPokemon (card)
; Tipo de Recursión: No aplica

(define SetPokemonAttacks
    (lambda
      (CartaPokemon Attacks)
    (if (and (IsPokemonCard? CartaPokemon) (list? Attacks))
         (card (GetCardType CartaPokemon) (GetName CartaPokemon) (GetEvolutionAscendant CartaPokemon)
               (GetHP CartaPokemon) (GetTypeOfPokemon CartaPokemon) (GetWeakness CartaPokemon) (GetResistance CartaPokemon)
               (GetRetiringCost CartaPokemon) (GetExState CartaPokemon) (GetAbility CartaPokemon)
               Attacks)
         (raise "Error. Input Card has no correct Pokemon data or input Attacks list is unvalid")
         ))
  )
; Descripción: Función que altera la lista de ataques (perteneciente al TDA ATTACKS de constructor attack) del Pokemon, desde una entrada Carta Pokemon y una lista proveniente del constructor attack
; Dominio: CartaPokemon (card) X Attacks (attack)
; Recorrido: CartaPokemon (card)
; Tipo de Recursión: No aplica

(define SetPokemonResistance
    (lambda
      (CartaPokemon Resistance)
    (if (and (IsPokemonCard? CartaPokemon) (element-type? Resistance))
         (card (GetCardType CartaPokemon) (GetName CartaPokemon) (GetEvolutionAscendant CartaPokemon)
               (GetHP CartaPokemon) (GetTypeOfPokemon CartaPokemon) (GetWeakness CartaPokemon) Resistance
               (GetRetiringCost CartaPokemon) (GetExState CartaPokemon) (GetAbility CartaPokemon)
               (GetListOfAttacks CartaPokemon))
         (raise "Error. Input Card has no correct Pokemon data or input Resistance is unvalid")
         ))
  )
; Descripción: Función que altera la resistencia del Pokemon, desde una entrada Carta Pokemon y un símbolo de tipo elemental que será la debilidad del pokemon
; Dominio: CartaPokemon (card) X Resistance (ELEMENT-TYPE)
; Recorrido: CartaPokemon (card)
; Tipo de Recursión: No aplica

(define SetPokemonRetiringCost
      (lambda
      (CartaPokemon RetiringCost)
    (if (and (IsPokemonCard? CartaPokemon) (or (and (integer? RetiringCost) (> RetiringCost 0)) (null? RetiringCost)))
         (card (GetCardType CartaPokemon) (GetName CartaPokemon) (GetEvolutionAscendant CartaPokemon)
               (GetHP CartaPokemon) (GetTypeOfPokemon CartaPokemon) (GetWeakness CartaPokemon) (GetResistance CartaPokemon)
               RetiringCost (GetExState CartaPokemon) (GetAbility CartaPokemon)
               (GetListOfAttacks CartaPokemon))
         (raise "Error. Input Card has no correct Pokemon data or input Retiring Cost is unvalid")
         ))
  )
; Descripción: Función que altera el número de energías para retiro del Pokemon, desde una entrada Carta Pokemon y un valor entero positivo (o lista vacía) que representa la presencia de energías de retiro
; Dominio: CartaPokemon (card) X Resistance (integer v null)
; Recorrido: CartaPokemon (card)
; Tipo de Recursión: No aplica

(define SetPokemonAbility
    (lambda
      (CartaPokemon Ability)
    (if (and (IsPokemonCard? CartaPokemon) (list? Ability))
         (card (GetCardType CartaPokemon) (GetName CartaPokemon) (GetEvolutionAscendant CartaPokemon)
               (GetHP CartaPokemon) (GetTypeOfPokemon CartaPokemon) (GetWeakness CartaPokemon) (GetResistance CartaPokemon)
               (GetRetiringCost CartaPokemon) (GetExState CartaPokemon) Ability
               (GetListOfAttacks CartaPokemon))
         (raise "Error. Input Card has no correct Pokemon data or input Ability list is unvalid")
         ))
  )
; Descripción: Función que altera la habilidad (perteneciente al TDA ATTACKS de constructor attack) del Pokemon, desde una entrada Carta Pokemon y una lista proveniente del constructor attack
; Dominio: CartaPokemon (card) X Ability (attack)
; Recorrido: CartaPokemon (card)
; Tipo de Recursión: No aplica

(define SetPokemonExState
    (lambda
      (CartaPokemon ExState)
    (if (and (IsPokemonCard? CartaPokemon) (boolean? ExState))
         (card (GetCardType CartaPokemon) (GetName CartaPokemon) (GetEvolutionAscendant CartaPokemon)
               (GetHP CartaPokemon) (GetTypeOfPokemon CartaPokemon) (GetWeakness CartaPokemon) (GetResistance CartaPokemon)
               (GetRetiringCost CartaPokemon) ExState (GetAbility CartaPokemon)
               (GetListOfAttacks CartaPokemon))
         (raise "Error. Input Card has no correct Pokemon data or input Ex State is unvalid")
         ))
  )
; Descripción: Función que altera el estado EX del Pokemon, desde una entrada Carta Pokemon y un booleano que indica si el Pokemon es EX o no
; Dominio: CartaPokemon (card) X ExState (booleano)
; Recorrido: CartaPokemon (card)
; Tipo de Recursión: No aplica

(define SetPokemonType
    (lambda
      (CartaPokemon PokemonType)
    (if (and (IsPokemonCard? CartaPokemon) (element-type? PokemonType))
         (card (GetCardType CartaPokemon) (GetName CartaPokemon) (GetEvolutionAscendant CartaPokemon)
               (GetHP CartaPokemon) PokemonType (GetWeakness CartaPokemon) (GetResistance CartaPokemon)
               (GetRetiringCost CartaPokemon) (GetExState CartaPokemon) (GetAbility CartaPokemon)
               (GetListOfAttacks CartaPokemon))
         (raise "Error. Input Card has no correct Pokemon data or input Ex State is unvalid")
         ))
  )
; Descripción: Función que altera el tipo de elemento que identifica la naturaleza del Pokemon, desde una entrada Carta Pokemon y un símbolo de tipo elemental
; Dominio: CartaPokemon (card) X PokemonType (ELEMENT-TYPE)
; Recorrido: CartaPokemon (card)
; Tipo de Recursión: No aplica

; 6.2) Funciones de Modificación para Carta de Entrenador
; Estructura de Carta de Entrenador: (TypeOfCard name TrainerType description ActionsFunction)
(define SetTrainerName
  (lambda (CartaEntrenador NewName)
    (if (and (IsTrainerCard? CartaEntrenador) (string? NewName)) 
        (card (GetCardType CartaEntrenador) NewName (GetTrainerType CartaEntrenador) (GetTrainerDescription CartaEntrenador) (GetActionsFunction CartaEntrenador))
        (raise "Error. Input card has no correct Trainer data or input name is unvalid"))
    ) )
; Descripción: Función que altera el valor de nombre de una Carta de Entrenador, desde una entrada Carta de Entrenador y un string que será el nuevo nombre
; Dominio: CartaEntrenador (card) X NewName (string)
; Recorrido: CartaEntrenador (card)
; Tipo de Recursión: No aplica
(define SetTrainerType
  (lambda (CartaEntrenador NewType)
    (if (and (IsTrainerCard? CartaEntrenador) (trainer-type? NewType))
        (card (GetCardType CartaEntrenador) (GetName CartaEntrenador) NewType (GetTrainerDescription CartaEntrenador) (GetActionsFunction CartaEntrenador))
        (raise "Error. Input card has no correct Trainer data or input name is unvalid"))
    ) )
; Descripción: Función que altera el subtipo de una Carta de Entrenador, desde una entrada Carta de Entrenador y un símbolo perteneciente a TRAINER-TYPE
; Dominio: CartaEntrenador (card) X NewType (TRAINER-TYPE)
; Recorrido: CartaEntrenador (card)
; Tipo de Recursión: No aplica
(define SetTrainerDescription
  (lambda (CartaEntrenador NewDescription)
    (if (and (IsTrainerCard? CartaEntrenador) (string? NewDescription))
        (card (GetCardType CartaEntrenador) (GetName CartaEntrenador) (GetTrainerType CartaEntrenador) NewDescription (GetActionsFunction CartaEntrenador))
        (raise "Error. Input has no correct Trainer data or input description is unvalid")
        )
    )
 )
; Descripción: Función que altera la descripción de una Carta de Entrenador, desde una entrada Carta de Entrenador y un string que representa la descripción
; Dominio: CartaEntrenador (card) X NewDescription (string)
; Recorrido: CartaEntrenador (card)
; Tipo de Recursión: No aplica
(define SetTrainerActionsFunction
  (lambda(CartaEntrenador NewActionsFunction)
    (if (and (IsTrainerCard? CartaEntrenador)(procedure? NewActionsFunction))
       (card (GetCardType CartaEntrenador) (GetName CartaEntrenador) (GetTrainerType CartaEntrenador) (GetTrainerDescription CartaEntrenador) NewActionsFunction)
       (raise "Error. Input has no correct Trainer data or input procedure (New Actions Function) is unvalid"))
    ))
; Descripción: Función que altera la Función de Acciones de una Carta de Entrenador, desde una entrada Carta de Entrenador y una función de acciones (procedure) 
; Dominio: CartaEntrenador (card) X NewActionsFunction (procedure)
; Recorrido: CartaEntrenador (card)
; Tipo de Recursión: No aplica

; 6.3) Funciones de Modificación para Carta de Energía
; Estructura de Carta de Energía: (TypeOfCard name EnergyType)

(define SetEnergyName
  (lambda (CartaEnergía NewName)
    (if (and (IsEnergyCard? CartaEnergía) (string? NewName))
        (card (GetCardType CartaEnergía) NewName (GetTypeOfEnergy CartaEnergía))
        (raise "Error. Input has no correct Energy data or input name is unvalid")
        )
    )
  )
; Descripción: Función que altera el valor de nombre de una Carta de Energía, desde una entrada Carta de Energía y un string que será el nuevo nombre
; Dominio: CartaEnergía (card) X NewName (string)
; Recorrido: CartaEnergía (card)
; Tipo de Recursión: No aplica

(define SetEnergyType
  (lambda (CartaEnergía NewEnergy)
    (if (and (IsEnergyCard? CartaEnergía) (element-type? NewEnergy))
        (card (GetCardType CartaEnergía) (GetName CartaEnergía) NewEnergy)
        (raise "Error. Input has no correct Energy data or input Energy is unvalid")
        )
    ))
; Descripción: Función que altera el tipo de energía de una Carta de Energía, desde una entrada Carta de Energía y un símbolo perteneciente a ELEMENT-TYPE
; Dominio: CartaEnergía (card) X NewEnergy (ELEMENT-TYPE)
; Recorrido: CartaEnergía (card)
; Tipo de Recursión: No aplica