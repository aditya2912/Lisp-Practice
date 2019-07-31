#lang racket

(define (f return)
  (return 2)3)

;(display (f (lambda (x) x)))

;(display (call-with-current-continuation f))

(define member
   (lambda (x ls )
     (call/cc
      (lambda (break)
        (do ((ls ls (cdr ls)))
          ((null?  ls) #f)
          (if (equal? x (car ls))
              (break ls) #f))))))

(define is_square_root
  (lambda (first_argument second_argument)
    (if (eq? (* second_argument second_argument) first_argument) #t #f)))

;(define (square_root dummy_argument)
;  (the another_argument (and (>= another_argument)
;       ( = (square another_argument) dummy_argument))))

(define initial_guess 1)

(define new_guess 0)
(define list_of_averages '())
(define average1 0)
(define quotient1 0)

(define newtons_square_root
  (lambda (number)
       (display initial_guess)
      (set! quotient1 (/ number initial_guess) )
      (set! average1 (/ (+ quotient1 initial_guess ) 2))
      ;(set! list_of_averages (cons average1 list_of_averages))
      (set! initial_guess average1)
      (if  (<= (* average1 average1) number)
           (newtons_square_root number)
           average1)))

(define square
  (lambda (argument)
    (* argument argument)))

(define  (average first_number second_number)
  (/ (+ first_number second_number) 2))

(define (improve guess number)
  (average guess (/ number guess)))

(define (good_enough? guess actual_number)
  (< (abs (- (square guess) actual_number) ) 0.001))

(define (square_root_iteration guess number)
  (if (good_enough? guess number) guess (square_root_iteration (improve guess number) number)))

(define (compose_square_root_v1 number)
      (square_root_iteration 1.0 number))

;(compose_square_root_v1 2)


(define (dec->bin n)
  (cond ((zero? n) '())
        (else (cons (remainder n 2)
                    (dec->bin (quotient n 2))))))

(define (bin->dec n)
  (if (zero? n)
      n
      (+ (modulo n 10) (* 2 (bin->dec (quotient n 10))))))

(define converted_to_binary
  (lambda (decimal_number)
    (dec->bin decimal_number)))

(define (reverse lst)
    (if (null? lst)
        lst
        (append (reverse (cdr lst)) (list (car lst)))))

(define (is_consecutive_element_one? binary_list)
  (if (eq?  (car binary_list) 1) #t #f)
  )

(define (has_consecutive_ones? binary_number)
  (cond
    ((eq? binary_number '()) #t)
    ((eq? (cdr binary_number) '()) #t)
    ((eq? (car binary_number) 0) (has_consecutive_ones? (cdr binary_number)) )
    ((eq? (car binary_number) 1)
     (if (is_consecutive_element_one? (cdr binary_number)) #f
          (if (eq? binary_number '()) #t (has_consecutive_ones? (cdr binary_number)))))
    (else (has_consecutive_ones? (cdr binary_number)))))

(define (check_if_sparse number)
  (if (has_consecutive_ones? (reverse (dec->bin number)))
      number(check_if_sparse (+ number 1))))
;(dec->bin 6)
(check_if_sparse (read))
;(has_consecutive_ones? (reverse (dec->bin 4)))

;(check_if_sparse_integer 6)
;(number->string 2 2)