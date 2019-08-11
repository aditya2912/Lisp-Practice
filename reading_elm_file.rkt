#lang racket
; C:/WebApps/eis/assets/elm/OrgIdentity/Main.elm
; C:/practice Programs/Elm Projects/src/question_24.elm
(define file_format "")

(define file_as_list '())

(define types_in_file '())

(define functions '())

(define type_aliases '())

(define (find_body file_as_list)
  (cond
    ((null? file_as_list) type_aliases)
    ((regexp-match #rx" }\r" (car file_as_list)) type_aliases)
    (else (set! type_aliases (append type_aliases (list (car file_as_list)))) (find_body (cdr file_as_list)))))

(define (identify_type_aliases file_as_list)
  (cond
    ((null? file_as_list) null)
    ((regexp-match #rx"type alias [A-Z]" (car file_as_list))
     ;(display (car file_as_list))
     (find_body file_as_list)
     )
    (else (identify_type_aliases (cdr file_as_list)))))

;(define (identify_type_aliases)
;  (map (lambda (line) (cond
;                      ((regexp-match #rx"type alias [A-Z]" line) (set! type_aliases (cons line type_aliases)))))
;       file_format))

(define (identify_types)
  (map (lambda (line) (cond
                      ((regexp-match #rx"type [A-Z]" line) (set! types_in_file (cons line types_in_file)))))
       file_format))

(define (identify_functions)
  (map (lambda (line) (cond
                        ((and (regexp-match #rx"[a-z] : " line)
                              (regexp-match #rx" ->" line))
                         (set! functions (cons line functions)))))
       file_format))

(let ((file (file->string "C:/WebApps/eis/assets/elm/OrgIdentity/Main.elm")))
  (set! file_format file)
  (set! file_as_list (string-split file_format "\n"))
  ;(identify_types)
  (identify_type_aliases file_as_list)
  (display "TYPE ALIAS")
  type_aliases
  ;type_aliases
  ;(identify_functions)
  ;functions
  )
