#lang racket
;TDA CARTAS (POKÉMON, ENERGÍA Y DE ENTRENADOR)
(define TipoComponente '(CartaPokémon CartaDeEnergía CartaDeEntrenador)); Tipos Principales de Cartas
;;
;CARTAS POKÉMON
(define MIN_PS 0) ; Punto de salud más bajo para una Carta Pokémon
(define MIN_ATAQUE 0) 
(define TiposElementales '("agua", "fuego", "eléctrico", "tierra", "metal", "normal", "lucha", "psíquico", "planta" )); Tipos Elementales para un Pokémon
;;
(define CartaPokemon; Función representadora de una carta Pokémon
  (lambda (Nombre TipoElemental PS Ataque Habilidad Nivel)
   list (Nombre TipoElemental PS Ataque Habilidad Nivel)
    ; La Carta Pokémon será una lista con los atributos: Nombre, TipoElemental, PS, Ataque, Habilidad y Nivel.
   )
 )
;;
(define EsCartaPokemon? ; Función identificadora para una carta Pokémon
 (lambda (CartaPokemon)
   (if (and (string? (car CartaPokemon)) ;Es el primer elemento de la Carta un string? (Nombre)
            (string?(car(cdr CartaPokemon))) ;Es el segundo elemento de la Carta un string? (TipoElemental)
            (integer?(car(cdr(cdr CartaPokemon)))); Es el tercer elemento de la Carta un entero? (PS: Puntos de Salud)
            (integer?(car(cdr(cdr(cdr CartaPokemon))))); Es el 4to elemento de la Carta un entero? (Valor de Ataque)
            (string? (car(cdr(cdr(cdr(cdr CartaPokemon)))))) ; Es el 5to elemento de la Carta un string? (Detalles de Habilidad)
            (string? (car(cdr(cdr(cdr(cdr(cdr CartaPokemon))))))) ; Es el 6to elemento de la Carta un string? (Detalles de Nivel)
            )
       #t
       #f
       )))