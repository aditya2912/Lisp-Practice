#lang racket

(define (is_every_element_valid? array k)
  (cond
    ((null? array) #t)
    ((< (car array) k) #f)
    (else (is_every_element_valid? (cdr array) k))))

(define (increment_and_check k test_array count)
  (cond
    ((is_every_element_valid? test_array k) count)
    ((not (is_every_element_valid? test_array k))
     (display count)
     (newline)
     (increment_and_check k (map (lambda (element) (+ element 1)) test_array) (+ count 1))
    )
  ))
(increment_and_check 2 '(2 5 5) 0)