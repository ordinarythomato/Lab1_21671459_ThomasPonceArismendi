#lang racket
(require "TDA-CARD_21671459_PonceArismendi.rkt" "GENERAL-FUNCTIONS_21671459_PonceArismendi.rkt")
;; TDA ATTACKS ;;

; 1) Definiciones previas para TDA
(define MIN_ATAQUE 0) ; Ataque más bajo que puede influir en Carta Pokémon

; 2) Capa de Modelación
; Estructura de constructor attack : (Cost Name Text DamageFunction) 
(define EmptyAttack ; Valores neutros para un Ataque
  (lambda ()
    (list '() "Name" "Description" 'procedure)))
; Descripción: Función Modeladora que representa la estructura de un ataque, con valores nulos y neutrales.
; Dominio: (null)
; Recorrido: (List)
; Tipo de Recursión: No aplica

; 3) Capa de Construcción
(define attack
  (lambda (Cost Name Text DamageFunction)
    (if (and (IsCostList? Cost) (string? Name) (string? Text) (procedure? DamageFunction))
        (list Cost Name Text DamageFunction)
        (raise "Error: Unvalid type of card")
        )
    )
  )
; Descripción: Función constructora de ataque (attack) con las siguientes entradas: Elemento de Coste, Nombre de Ataque, Texto De Descripción y Función de Daño
; Dominio: Cost (ELEMENT-TYPE) X Name (string) X Text (string) X DamageFunction (procedure)
; Recorrido: (List)
; Tipo de Recursión: No Aplica

; 4) Capa de Selección
; Estructura de constructor attack : (Cost Name Text DamageFunction) 
(define GetAttackCost
  (lambda (Ataque) (car Ataque)))
; Descripción: Obtener el coste perteneciente a un ataque (1er elemento de constructor attack)
; Dominio: Ataque (attack)
; Recorrido: car Ataque (ELEMENT-TYPE)
; Tipo de Recursión: No aplica
(define GetAttackName
  (lambda (Ataque) (cadr Ataque)))
; Descripción: Obtener el nombre perteneciente a un ataque (2do elemento de constructor attack)
; Dominio: Ataque (attack)
; Recorrido: cadr Ataque (string)
; Tipo de Recursión: No aplica
(define GetAttackText
  (lambda (Ataque) (caddr Ataque)))
; Descripción: Obtener el texto descriptivo perteneciente a un ataque (3er elemento de constructor attack)
; Dominio: Ataque (attack)
; Recorrido: caddr Ataque (string)
; Tipo de Recursión: No aplica
(define GetAttackDamageFunction
   (lambda (Ataque) (cadddr Ataque)))
; Descripción: Obtener la Función de Daño perteneciente a un ataque (4to elemento de constructor attack)
; Dominio: Ataque (attack)
; Recorrido: cadddr Ataque (procedure)
; Tipo de Recursión: No aplica

; 5) Capa de Pertenencia
(define IsCostList?
  (lambda (list)
    (if (null? list)
        #t 
        (and (element-type? (car list)) (IsCostList? (cdr list))) ;Si la lista no es vacía, verificamos que cada elemento sea de tipo ELEMENT-TYPE
        )
    )
  )
; Descripción: Función que verifica que cada elemento de una lista tenga elementos de tipo ELEMENT-TYPE.
; Caso borde: Si la lista es vacía, es un caso válido de lista de Costos para Ataque,
; Si la lista no es vacía, verificamos que cada elemento sea de tipo ELEMENT-TYPE.
; Dominio: (List)
; Recorrido: (boolean)
; Tipo de Recursión: Natural

(define IsAttack?
  (lambda (Ataque)
    (and (= 4 (LengthOfAList Ataque)) (IsCostList? (GetAttackCost Ataque)) (string? (GetAttackName Ataque)) (string? (GetAttackText Ataque)) (procedure? (GetAttackDamageFunction Ataque)))))
; Descripción: Función que verifica que una lista hecha a partir del constructor attack sea una estructura con atributos de ataque Pokemon
; Dominio: Ataque (attack)
; Recorrido: (boolean)
; Tipo de Recursión: No Aplica

; 6) Capa de Modificación (Funciones Setters)
(define SetAttackCost
  (lambda (Ataque NewAttackCost)
    (if (and (IsAttack? Ataque) (IsCostList? NewAttackCost))
        (attack NewAttackCost (GetAttackName Ataque) (GetAttackText Ataque) (GetAttackDamageFunction Ataque))
        (raise "Error. Input has no correct Attack data or input Attack Cost is unvalid" ))
    )
  )
; Descripción: Función que altera la lista de Costo de un Ataque desde una entrada Ataque de tipo attack y una lista con elementos de tipo ELEMENT-TYPE que representará la nueva lista de Costo
; Dominio: Ataque (attack) X NewAttackCost (List ELEMENT-TYPE)
; Recorrido: (attack)
; Tipo de Recursión: No aplica

(define SetAttackName
  (lambda (Ataque NewAttackName)
    (if (and (IsAttack? Ataque) (string? NewAttackName))
        (attack (GetAttackCost Ataque) NewAttackName (GetAttackText Ataque) (GetAttackDamageFunction Ataque))
        (raise "Error. Input has no correct Attack data or input Attack name is unvalid"))
    )
  )

; Descripción: Función que altera el nombre de un Ataque desde una entrada Ataque de tipo attack y un elemento de tipo string que representará el nuevo nombre de ataque
; Dominio: Ataque (attack) X NewAttackName (string)
; Recorrido: (attack)
; Tipo de Recursión: No aplica


(define SetAttackText
  (lambda (Ataque NewAttackText)
    (if (and (IsAttack? Ataque) (string? NewAttackText))
        (attack (GetAttackCost Ataque) (GetAttackName Ataque) NewAttackText (GetAttackDamageFunction Ataque))
        (raise "Error. Input has no correct Attack data or input Attack name is unvalid")
        )
    )
  )
; Descripción: Función que altera el valor de texto de un Ataque desde una entrada Ataque de tipo attack y un elemento de tipo string que representará el nuevo texto
; Dominio: Ataque (attack) X NewAttackText (string)
; Recorrido: (attack)
; Tipo de Recursión: No aplica


(define SetAttackDamageFunction
  (lambda (Ataque NewAttackDamageFunction)
    (if (and (IsAttack? Ataque) (procedure? NewAttackDamageFunction))
        (attack (GetAttackCost Ataque) (GetAttackName Ataque) (GetAttackText Ataque) NewAttackDamageFunction)
        (raise "Error. Input has no correct Attack data or input Attack name is unvalid"))
    )
  )
; Descripción: Función que altera el valor de Función de Ataque, desde una entrada Ataque de tipo attack y un elemento de tipo procedure que representará la nueva función
; Dominio: Ataque (attack) X NewAttackDamageFunction (procedure)
; Recorrido: (attack)
; Tipo de Recursión: No aplica