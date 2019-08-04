#lang racket

(define (subsets set)
  (if (null? set)
      (list set)
      (let ((rest (subsets (cdr set))))
        (append rest (map (lambda (x)
                            (cons (car set) x)) rest)))))

(define example_list '(3 4 5))

(define subsets_of_list (cdr (subsets example_list)))

(define charged_elements '())

(define number_of_occurences 0)

(define (check_occurences_in_subset current_element current_subset)
  (cond 
    ((null? current_subset) number_of_occurences)
    ((eq? (car current_subset) current_element) (set! number_of_occurences (+ number_of_occurences 1)))
    (else (check_occurences_in_subset current_element (cdr current_subset)))))

(define (check_presence_in_subsets current_element list_of_subsets)

  (cond
    ((null? list_of_subsets) number_of_occurences)
    ((list? (car list_of_subsets))
     (check_occurences_in_subset current_element (car list_of_subsets))
     (check_presence_in_subsets current_element (cdr list_of_subsets)))
    (else (check_presence_in_subsets current_element (cdr list_of_subsets)))))

(define (calculate_total_charge charged_elements)
  (cond
    ((null? charged_elements) number_of_occurences)
    (else
     (set! number_of_occurences (+ number_of_occurences (car charged_elements)))
     (calculate_total_charge (cdr charged_elements)))))

(define (check_if_charged list)
  (cond
    ((null? list) (set! number_of_occurences 0) (calculate_total_charge charged_elements))
    ((>= (car list) (check_presence_in_subsets (car list) subsets_of_list ))
     (set! number_of_occurences 0)
     (set! charged_elements (cons (car list) charged_elements))
     (check_if_charged (cdr list)))
    (else (set! number_of_occurences 0)
     (check_if_charged (cdr list)))))

(check_if_charged example_list)