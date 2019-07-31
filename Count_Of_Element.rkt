#lang racket

(define (check_if_member element array)
  (cond
    ((eq? (cdr array) '()) "NOT PRESENT")
    ((eq? (car array) element) #t)
    (else (check_if_member element (cdr array)))))

(define initialize_array
  (lambda (array_of_integers number_of_integers)
    (if (< (length array_of_integers) number_of_integers)
         (initialize_array (cons (read) array_of_integers) number_of_integers)
          array_of_integers)))

(define (count_occurences element array count)
     (cond
      ((eq? array '()) count)
      ((null? array) count)
      ((eq? (car array) element) (count_occurences element (cdr array) (+ count 1)))
      (else (count_occurences element (cdr array)))))
   
(count_occurences 1 (initialize_array '() (read)) 0)
