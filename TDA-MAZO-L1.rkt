#lang racket
(require "TDA-CARTA-POKEMON-L1.rkt") ; Función para importar los TDA
;TDA MAZO

;;CAPA DE MODELACIÓN
(define CrearMazoVacio ; Función Modeladora que crea un Mazo "vacío"
  (lambda ()
    (make-list 60 '()))) ; El mazo vacío será una lista con 60 elementos vacíos

;;CAPA DE CONSTRUCCIÓN
(define MazoConCartas ;Función que crea un Mazo exclusivamente con 60 cartas existentes
  (lambda (SesentaCartas)
    (if (and (= 60 (length SesentaCartas)) (andmap (EsCartaPokemon?) SesentaCartas)) ;Se busca que hayan 60 cartas y que cada una sea de tipo Pokemón (ESTO ES PRELIMINAR, RECORDAR AGREGR CARTAS ENTRENADOR Y ENERGÍA)
        SesentaCartas ;retorno de la lista de cartas
        (raise "Error: No se pudo crear Mazo por presencia de Carta(s) Incompatible(s)")
        )
    )
  )
;; CAPA DE PERTENENCIA
(define (EsMazoVacio? Mazo) ; Función Identificadora para un Mazo existente pero no rellenado
  (if (null? Mazo)
      #t ;Retorno afirmativ0 si el mazo está vacío
      #f ;Retorno negativo si el mazo no está vacío
  ))

(define EsMazoDeCartas?; Función Identificadora para un Mazo lleno con 60 elementos
  (lambda (Mazo); Entrada, una lista "Mazo"
    (if (list? Mazo); Es la entrada una lista?
     (if (= 60 (length Mazo)); Es el Mazo una lista de 60 elementos?
         #t ; Afirmativo
         #f ; Mazo inválido, Requiere 60 cartas
         )
     #f) ; Mazo inválido, se requiere un Mazo en formato de lista
))
(define EsMazoDeCartasLleno?
  (lambda(Mazo)
    (if (and (not (EsMazoVacio? Mazo)) (EsMazoDeCartas? Mazo)) ;Pendiente verificar si los elementos pertenecen a los TDA de Cartas
        #t
        #f
        )))
; Ejecución de TDA MAZO
(define Mazo (make-list 60 '())); creación de ejemplo para una lista de 60 elementos que simulará nuestro "Mazo"
(EsMazoVacio? Mazo); Es el Mazo vacío? De la forma '()
(EsMazoDeCartas? Mazo); Es el Mazo una lista de 60 elementos?
