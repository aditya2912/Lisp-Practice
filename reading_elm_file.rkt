#lang racket
; C:/WebApps/eis/assets/elm/OrgIdentity/Main.elm
; C:/practice Programs/Elm Projects/src/question_24.elm
(define file_format "")

(define file_as_list '())

(define types_in_file '())

(define functions '())

(define type_aliases '()) 

(define (find_body_for_type file_as_list)
  (cond ((null? file_as_list) types_in_file)
        ((and (regexp-match #rx"\r" (car file_as_list))
              (regexp-match #rx"\r" (cadr file_as_list)))
         (display types_in_file)
         (set! types_in_file (append types_in_file (list (car file_as_list))))
         (set! types_in_file (append types_in_file (list (cadr file_as_list))))
         (identify_types file_as_list))
        (else
          (set! types_in_file (append types_in_file (list (car file_as_list))))
          (find_body_for_type (cdr file_as_list)))))

(define (identify_types file_as_list)
  (cond
    ((null? file_as_list) null)
    ((regexp-match #rx"type [A-Z]" (car file_as_list)) (find_body_for_type file_as_list))
    (else (identify_types (cdr file_as_list)))))

(define (find_body file_as_list)
  (cond
    ((null? file_as_list) type_aliases)
    ((regexp-match #rx" }\r" (car file_as_list))
     (set! type_aliases (append type_aliases (list (car file_as_list))))
     (identify_type_aliases file_as_list))
    (else
     (set! type_aliases  (append type_aliases (list (car file_as_list))))
     (find_body (cdr file_as_list)))))

(define (identify_type_aliases file_as_list)
  (cond
    ((null? file_as_list) null)
    ((regexp-match #rx"type alias [A-Z]" (car file_as_list))
     (find_body file_as_list)
     )
    (else (identify_type_aliases (cdr file_as_list)))))

(let ((file (file->string "C:/WebApps/eis/assets/elm/OrgIdentity/Main.elm")))
  (set! file_format file)
  (set! file_as_list (string-split file_format "\n"))
  ;(identify_type_aliases file_as_list)
  (identify_types file_as_list)
  types_in_file
  ;type_aliases
  ;type_aliases
  ;(identify_functions)
  ;functions
  )
