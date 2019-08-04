#lang racket

(define (summation list)
  (cond
    ((null? list) 0)
    (else (+ (car list)
             (cond
               ((null?  list) 0)
               (else (summation (cdr list))))))))

(summation '(1 2 3))