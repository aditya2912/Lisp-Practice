#lang racket

(define dummy_list '(1 2 3 4 5))

(define another_dummy_list '(4 5 3 2 10))

(define (combine_lists output_list length_of_lists)
  (cond
    ((eq? (length output_list) length_of_lists)  output_list)
    (else
     (set! output_list (cons (+ (car dummy_list) (car another_dummy_list)) output_list))
     (set! dummy_list (cdr dummy_list))
     (set! another_dummy_list (cdr another_dummy_list))
     (combine_lists output_list length_of_lists))))

(combine_lists '() 5)