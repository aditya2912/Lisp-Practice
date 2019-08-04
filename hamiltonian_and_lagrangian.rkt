#lang racket
; Since we have lists as a program in lisp (a procedure is treated as a list), how does one list communicate with another when we call an identifier

(define (is_valid_element? current_element marks_array)
  (cond
    ((null? marks_array) #t)
    ((< current_element (car marks_array)) #f)
    (else (is_valid_element? current_element (cdr marks_array)))))

(define (find_marks marks_array greater_marks)
  (cond
    ((null? marks_array) greater_marks)
    ((is_valid_element? (car marks_array) (cdr marks_array))  (find_marks (cdr marks_array) (cons (car marks_array) greater_marks)))
    ((not (is_valid_element? (car marks_array) (cdr marks_array))) (find_marks (cdr marks_array) greater_marks))
    (else (find_marks (cdr marks_array ) greater_marks))))

(find_marks '(16 17 4 3 5 2) '())
