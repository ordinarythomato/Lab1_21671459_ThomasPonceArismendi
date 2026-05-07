#lang racket
;; TDA ATTACKS ;;
(require "TDA-CARD.rkt")
; 1) Definiciones previas para TDA
(define MIN_DAÑO 0)

; 2) Capa de Modelación
; Estructura de constructor attack : (list cost nombre texto funciondedaño) 
(define EmptyAttack ; Valores neutros para un Ataque
  (lambda ()
    (list '() "Name" "Description" 'procedure)))
; Descripción: Función Modeladora que representa la estructura de una lista de ataques, con valores nulos y neutrales.
; Dominio: null
; Recorrido: (list)
; Tipo de Recursión: No aplica

;CAPA SELECTORA (Funciones Getters)
(define GetNombreAtaque   (lambda (Ataque) (car Ataque)))
(define GetDaño           (lambda (Ataque) (cadr Ataque)))
(define GetTipoAtaque     (lambda (Ataque) (caddr Ataque)))
(define GetDescripcion    (lambda (Ataque) (cadddr Ataque)))

;CAPA DE CONSTRUCCIÓN

(define Ataque ; Ataque representado como lista
  (lambda (Nombre Daño TipoElemental Descripcion)
    (list Nombre Daño TipoElemental Descripcion)))

;CAPA DE PERTENENCIA

