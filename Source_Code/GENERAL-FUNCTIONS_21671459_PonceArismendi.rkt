#lang racket
(provide LengthOfAList IsACardList? AtLeastOneBasicPokemon? CountCardName ListWith4RepeatedCards? FindingByIndex)
(require "TDA-CARD_21671459_PonceArismendi.rkt")
; Funciones Generales

; 1) Largo de una lista
(define LengthOfAList
  (lambda (list number)
    (if (and (list? list) (integer? number))
        (if (null? list)
            number
            (LengthOfAList (cdr list) (+ 1 number)))
        
    (raise "List Size had not been calculated. Either List or acummulation number are incorrect"))
    ))
; Descripción: Función que calcula el largo de una lista desde recursión
; Dominio: list (list) X number (integer)
; Recorrido: number (integer)
; Tipo de Recursión: De Cola

; 2) Verificación de lista de cartas
(define IsACardList?
  (lambda (list)
    (equal? list (filter IsCard? list))
    )
  )
; Descripción: Función que determina si una lista contiene elemento pertenecientes al constructor card del TDA CARD
; Dominio: list (List card)
; Recorrido: (boolean)
; Tipo de Recursión: No aplica

; 3) Verificación de presencia de Pokemon Básico en lista
(define AtLeastOneBasicPokemon?
  (lambda (list)
    (and (IsACardList? list) (>= (LengthOfAList (filter IsBasicPokemonCard? list) 0) 1))
    )
  )
; Descripción: Función que determina si una lista contiene elementos es una carta del TDA CARD y al menos una carta Pokemon básica
; Dominio: list (List card)
; Recorrido: (boolean)
; Tipo de Recursión: No aplica

; 4) Contar cuántas cartas en una lista tienen un nombre especificado
(define CountCardName
  (lambda (name list)
    (if (null? list)
        0
        (if (equal? name (GetName (car list)))
            (+ 1 (CountCardName name (cdr list)))
            (CountCardName name (cdr list)))
        ))
  )
; Descripción: Cuenta cuántas cartas en la lista tienen el nombre especificado en la entrada
; Dominio: name (string) X list (List card)
; Recorrido: (integer)
; Tipo de Recursión: Natural

; 5) Verificación de lista de cartas sin más de 4 cartas iguales en nombre
(define ListWith4RepeatedCards?
  (lambda (list)
    (if (null? list)
        #t                                                    
        (if (<= (CountCardName (GetName (car list)) list) 4)  
            (ListWith4RepeatedCards? (cdr list))              
            #f))))                                           
; Descripción: Función que verifica que en una lista de cartas no haya más de 4 cartas de igual nombre
; Dominio: list (List card)
; Recorrido: (boolean)
; Tipo de Recursión: Natural

; 6) Búsqueda de elementos de una lista desde índice
(define FindingByIndex
  (lambda (list index)
    (if (and (list? list) (integer? index) (>= index 0) (< index (LengthOfAList list 0)))
        (if (= index 0)
            (car list)
            (FindingByIndex (cdr list) (- index 1) ))
        (raise "Unvalid index or an invalid list while processing input")
        ))
  )
; Descripción: Función que obtiene el elemento en la posición n de una lista (indexado desde 0)
; Dominio: list (list card) X position (integer)
; Recorrido: element (card)
; Tipo de Recursión: De Cola
