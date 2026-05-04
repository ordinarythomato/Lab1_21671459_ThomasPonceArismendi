#lang racket
;; TDA CARD ;;
; Ennumeración de los tipos de Carta a considerar
(define CARD-TYPE '(pokemon trainer energy))
(define (card-type? t)
  (and (symbol? t) (member t CARD-TYPE) ))
; Enumeración de Elementos
(define ELEMENT-TYPE '(water fire lightning metal colorless fighting grass))
