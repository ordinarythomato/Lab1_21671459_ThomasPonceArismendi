#lang racket
;TDA ATAQUES
(require "TDA_CARTA_POKEMON-L1.rkt")

; DEFINICIONES PREVIAS
(define MIN_DAÑO 0)

; CAPA SELECTORA (Funciones Getters)
(define GetNombreAtaque   (lambda (Ataque) (car Ataque)))
(define GetDaño           (lambda (Ataque) (cadr Ataque)))
(define GetTipoAtaque     (lambda (Ataque) (caddr Ataque)))
(define GetDescripcion    (lambda (Ataque) (cadddr Ataque)))

;CAPA DE MODELACIÓN
(define AtaqueVacio ; Valores neutros para un Ataque
  (lambda ()
    (list "Nombre" 0 "Normal" "Descripción")))

; CAPA DE CONSTRUCCIÓN

(define Ataque ; Ataque representado como lista
  (lambda (Nombre Daño TipoElemental Descripcion)
    (list Nombre Daño TipoElemental Descripcion)))

;CAPA DE PERTENENCIA
(define EsAtaqueValido?
  (lambda (Ataque)
    (if (string? (GetNombreAtaque Ataque))
         (if (and (integer? (GetDaño Ataque))(>= (GetDaño Ataque) MIN_DAÑO))
             (EsTipoElementalValido? Ataque) 
             (string? (GetDescripcion Ataque)))
         #t
         #f)))