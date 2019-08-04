#lang racket

(define input '())

(define length->l (read))

(define (init_list)
  (cond
    ((eq? (length input) length->l) input)
    (else
     (set! input (cons (read) input))
     (init_list))))
