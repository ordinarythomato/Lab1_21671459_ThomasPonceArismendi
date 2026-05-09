#lang racket
(require "GENERAL-FUNCTIONS_21671459_PonceArismendi.rkt" "TDA-CARD_21671459_PonceArismendi.rkt") ; Función para importar los TDA
;; TDA DECK ;;

;; 1) Capa de Modelación
; Estructura de constructor deck: (card_nº1, card_nº2, card_nº3, ... card_nº60). Tal que cada elemento pertenece al constructor card
(define EmptyDeck
  (lambda ()
    (make-list 60 empty-card)))
; Descripción: Función Modeladora que crea un Mazo "vacío" de 60 elementos perteneciente a la función empty-card (carta vacía)
; Dominio: (null)
; Recorrido: (List empty-card)
; Tipo de Recursión: No Aplica

;; 2) Capa de Construcción
(define deck
  (lambda ( deck . cards)
    (if (and (= (LengthOfAList cards 0)) (IsACardList? cards) (AtLeastOneBasicPokemon? cards) (ListWith4RepeatedCards? (filter IsPokemonCard? cards))
             (ListWith4RepeatedCards? (filter IsTrainerCard? cards)))
        (cards)
        (raise "Error: Incorrect input to create a deck")
    )))
; Descripción: Función Constructora que crea un Mazo de 60 cartas, con al menos una de ellas siendo Pokemon básico, siempre y cuando las cartas de Pokemon y entrenador no se repitan más de 4 veces por igual nombre
; Dominio: (list card)
; Recorrido: (deck)
; Tipo de Recursión: No Aplica

;; 3) Capa de Selección
(define GetDeckCard
  (lambda (deck index)
    (if ((integer? index) (>= index 0) (<= index 60))
        (FindingByIndex deck index)
        (raise "Error: Unvalid index.")
        )))

; Descripción: Función de Selección que permite ver la carta de un Mazo por su índice, siempre y cuando el índice esté entre 0 y 60
; Dominio: deck (List card) X index (integer)
; Recorrido: (List card)
; Tipo de Recursión: No Aplica
