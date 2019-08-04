#lang racket

(define (summation list)
  (if
   (null? list) 0
   (+ (car list) (summation (cdr list)))))

(summation '(1 2 3))
