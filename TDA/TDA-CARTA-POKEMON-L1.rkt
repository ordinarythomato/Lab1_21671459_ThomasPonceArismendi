#lang racket
(provide CartaPokemon EsCartaPokemon? Pokedex)
;TDA CARTA POKÉMON
;DEFINCIONES PREVIAS
(define MIN_PS 0) ; Punto de salud más bajo para una Carta Pokémon
(define MIN_ATAQUE 0) ;Ataque más bajo que puede influir en Carta Pokémon
(define TiposElementales '("Agua" "Fuego" "Eléctrico" "Metal" "Normal" "Lucha" "Planta" )); Tipos Elementales para un Pokémon. Buscar 6 con debilidades significativas
(define Niveles '("Básico" "Fase 1" "Fase 2"))

;; CAPAS DE TDA CARTAS ;;

;; CAPA SELECTORA ;;
; |OBSERVACIÓN|: Los Selectores (o "Getters") se han definido primero porque ayudan a armar y validar las funciones de las capas sucesoras (Los Constructores, los de Pertenencia y demás)

(define GetNombre (lambda (Carta) (car Carta))) ;Obtener nombre de carta (1er elemento)
(define EsTipoElementalValido? ;Función que apoya a GetTipoElemental, que permite obtener el Tipo Elemental de una Carta Pokemon
  (lambda (Carta)
    (if (member (cadr Carta) TiposElementales); se usa la función member de la forma (member elemento lista), si elemento pertenece a lista se interpreta como un output #t
        #t
        #f
        )))
(define GetTipoElemental
  (lambda (Carta) ; Obtener Tipo Elemental (2do elemento), consultando: Pertenece el segundo elemento de la carta a la lista de Tipos Elementales
    (if (EsTipoElementalValido? Carta); Se usa la función member de la forma (member elemento lista), si elemento pertenece a lista se interpreta como un output #t
        (cadr Carta)
        (raise "Elemento incosistente con Cartas Pokemon")
        )
    ))
(define GetPS (lambda (Carta) (caddr Carta))); Obtener Puntos de Salud (Tercer elemento)
(define GetAtaque (lambda (Carta) (cadddr Carta))); Obtener Ataque (Cuarto elemento)
(define EsNivelValido? ;Función que apoya a GetNivel, que permite obtener el Nivel de una Carta Pokemon (Básico, Fase 1 o Fase 2)
  (lambda (Carta)
    (if (member (car(cddddr Carta)) Niveles)
        #t
        #f)
    ))
(define GetNivel ; Obtener Nivel de Carta (Quinto elemento)
  (lambda (Carta)
    (if (EsNivelValido? Carta)
        (car(cddddr Carta))
        (raise "Nivel incosistente con Cartas Pokémon"))
    ))
(define GetExEstado
  (lambda (Carta)
    (car(cdr(cddddr Carta))))
    )

(define GetHabilidad (lambda (Carta) (car (cdr(cdr(cddddr Carta)))))); Obtener Habilidad de Carta (Sexto elemento)

;; CAPA DE MODELACIÓN ;;
(define CartaPokemonVacia ;Función modeladora, que muestra la estructura y cantidad de variables de una Carta Pokémon sin considerar valores de entrada
  (lambda ()
    (list "Sin Nombre" "Normal" 0 0 "Básico" #f null)
    )
  )
;; CAPA DE CONSTRUCCIÓN ;;
(define CartaPokemon; Función constructora de una carta Pokémon, que permite construir la carta con valores de entrada
  (lambda (Nombre TipoElemental PS Ataque Nivel ExEstado Habilidad)
   (list Nombre TipoElemental PS Ataque Nivel ExEstado Habilidad)
    ; La Carta Pokémon será una lista con los atributos: Nombre, TipoElemental, PS, Ataque, Habilidad y Nivel.
   )
 )
;; CAPA DE PERTENENCIA ;;
(define EsCartaPokemon? ; Función verificadora para una carta Pokémon
 (lambda (CartaPokemon)
   (if (and (string? (GetNombre CartaPokemon)) ;Es el primer elemento de la Carta un string? (Nombre)
            (EsTipoElementalValido? CartaPokemon) ;Es el segundo elemento de la Carta un string? (TipoElemental)
            (integer? (GetPS CartaPokemon))
            (>= (GetPS CartaPokemon) MIN_PS)
            ; Es el tercer elemento de la Carta, PS, un entero mayor o igual a MIN_PS? (PS: Puntos de Salud, MIN_PS: Mínimo Punto de Salud)
            (integer?(GetAtaque CartaPokemon))
            (>= (GetAtaque CartaPokemon) MIN_ATAQUE)
            ; Es el 4to elemento de la Carta, Valor de Ataque, un entero mayor o igal a MIN_ATAQUE? (MIN_ATAQUE: Mínimo valor de ataque)
            (EsNivelValido? CartaPokemon) ; Es el 5to elemento de la Carta un string? (Detalles de Nivel)
            (boolean? (GetExEstado CartaPokemon))
            (or (string? (GetHabilidad CartaPokemon)) (null? (GetHabilidad CartaPokemon))) ; Es el 6to elemento de la Carta un string o vacío? (Detalles de Habilidad, opcional)
            )
       #t
       #f
       )))

;; CAPA DE OTRAS FUNCIONES ;;
; Función de Escáner Pokedex
(define Pokedex ;FUNCIÓN POKEDEX: Imprime por consola los resultados de las funciones Getters aplicadas a una carta Pokémon
  (lambda (CartaPokemon)
    (if (EsCartaPokemon? CartaPokemon)
        (displayln (list "|ESCÁNER POKEDEX|" "Nombre: " (GetNombre CartaPokemon) "|"
              "Tipo Elemental: " (GetTipoElemental CartaPokemon) "|"
              "Puntos de Salud: " (GetPS CartaPokemon) "|"
              "Ataque: " (GetAtaque CartaPokemon) "|"
              "Nivel: " (GetNivel CartaPokemon) "|"
              "Tipo Ex: " (GetExEstado CartaPokemon) "|"
              "Habilidad: " (GetHabilidad CartaPokemon)
              ))
        (raise "Datos Inexistentes de Carta Pokémon")
        )
    )
  )
;; Definiendo Cartas
(define Pikachu(CartaPokemon "Pikachu" "Eléctrico" 150 60 "Básico" #f "Thunders"))
(define Charmander (CartaPokemon "Charmander" "Fuego" 80 50 "Básico" #t "Fire Spitting"))
(define Torchic (CartaPokemon "Torchic" "Fuego" 60 10 "Básico" #t "Call the Family"))
;Ejecutando funciones en cartas definidas
(Pokedex Pikachu)
(Pokedex Charmander)
(Pokedex Torchic)
(GetTipoElemental Charmander)
(define Void (CartaPokemonVacia))
(EsCartaPokemon? Void)
;; PENDIENTE ;;
;Plantear mejor el apartado de Habilidad (pensando que puede ser opcional, también es agregable un apartado booleano)
;Empezar a trabajar en funciones modificadoras del TDA
;Empezar a avanzar un TDA juego, TDA jugador, TDA Carta de Energía, TDA Carta de Entrenador