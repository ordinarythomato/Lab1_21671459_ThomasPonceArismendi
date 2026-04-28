#lang racket
;TDA CARTA POKÉMON
;DEFINCIONES PREVIAS
(define MIN_PS 0) ; Punto de salud más bajo para una Carta Pokémon
(define MIN_ATAQUE 0) ;Ataque más bajo que puede influir en Carta Pokémon
(define TiposElementales '("Agua" "Fuego" "Eléctrico" "Tierra" "Metal" "Normal" "Lucha" "Psíquico" "Planta" )); Tipos Elementales para un Pokémon
;"Getters" para TDA
(define GetNombre (lambda (Carta) (car Carta))) ;Obtener nombre de carta (1er elemento)
(define GetTipoElemental
  (lambda (Carta) ; Obtener Tipo Elemental (2do elemento), consultando: Pertenece el segundo elemento de la carta a la lista de Tipos Elementales
    (if (member (cadr Carta) TiposElementales); se usa la función member de la forma (member elemento lista), si elemento pertenece a lista se interpreta como un output #t
        (cadr Carta)
        null
        )
    ))
(define GetPS (lambda (Carta) (caddr Carta))); Obtener Puntos de Salud (Tercer elemento)
(define GetAtaque (lambda (Carta) (cadddr Carta))); Obtener Ataque (Cuarto elemento)
(define GetNivel (lambda (Carta) (car(cddddr Carta)))) ; Obtener Nivel de Carta (Quinto elemento)
(define GetHabilidad (lambda (Carta) (cadr(cddddr Carta)))); Obtener Habilidad de Carta (Sexto elemento)
(define Pokedex ;FUNCIÓN POKEDEX: Imprime por consola los resultados de las funciones Getters aplicadas a una carta Pokémon
  (lambda (CartaPokemon)
    (if (EsCartaPokemon? CartaPokemon)
        (displayln (list "|ESCÁNER POKEDEX|" "Nombre: " (GetNombre CartaPokemon) "|"
              "Tipo Elemental: " (GetTipoElemental CartaPokemon) "|"
              "Puntos de Salud: " (GetPS CartaPokemon) "|"
              "Ataque: " (GetAtaque CartaPokemon) "|"
              "Habilidad: " (GetHabilidad CartaPokemon)
              ))
        (displayln "Datos Inexistentes de Carta Pokémon")
        )
    )
  )
;; CAPAS DE TDA CARTAS ;;
;CAPA REPRESENTADORA
(define CartaPokemon; Función representadora de una carta Pokémon
  (lambda (Nombre TipoElemental PS Ataque Nivel Habilidad)
   (list Nombre TipoElemental PS Ataque Nivel Habilidad)
    ; La Carta Pokémon será una lista con los atributos: Nombre, TipoElemental, PS, Ataque, Habilidad y Nivel.
   )
 )
; CAPA IDENTIFICADORA
(define EsCartaPokemon? ; Función identificadora para una carta Pokémon
 (lambda (CartaPokemon)
   (if (and (string? (GetNombre CartaPokemon)) ;Es el primer elemento de la Carta un string? (Nombre)
            (string? (GetTipoElemental CartaPokemon)) ;Es el segundo elemento de la Carta un string? (TipoElemental)
            (integer? (GetPS CartaPokemon)); Es el tercer elemento de la Carta un entero? (PS: Puntos de Salud)
            (integer?(GetAtaque CartaPokemon)); Es el 4to elemento de la Carta un entero? (Valor de Ataque)
            (string? (GetNivel CartaPokemon)) ; Es el 5to elemento de la Carta un string? (Detalles de Nivel)
            (string? (GetHabilidad CartaPokemon)) ; Es el 6to elemento de la Carta un string? (Detalles de Habilidad)
            )
       #t
       #f
       )))


;; Ejecución
(define Pikachu(CartaPokemon "Pikachu" "Eléctrico" 150 60 "Basic" "Thunders"))
(define Charmander (CartaPokemon "Charmander" "Fuego" 80 50 "Basic" "Fire Spitting"))
(define Torchic (CartaPokemon "Torchic" "Fuego" 60 10 "Basic" "Call the Family"))
(Pokedex Pikachu)
(Pokedex Charmander)
(Pokedex Torchic)
(GetTipoElemental Charmander)