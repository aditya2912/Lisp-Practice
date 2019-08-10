#lang racket
; C:/WebApps/eis/assets/elm/OrgIdentity/Main.elm
; C:/practice Programs/Elm Projects/src/question_24.elm
(define file_format "")

(define types_in_file '())

(define functions '())

(define type_aliases '())

(define (identify_type_aliases)
  (map (lambda (line) (cond
                      ((regexp-match #rx"type alias [A-Z]" line) (set! type_aliases (cons line type_aliases)))))
       file_format))

(define (identify_types)
  (map (lambda (line) (cond
                      ((regexp-match #rx"type [A-Z]" line) (set! types_in_file (cons line types_in_file)))))
       file_format))

(define (identify_functions)
  (map (lambda (line) (cond
                        ((and (regexp-match #rx"[a-z] : " line)
                              (regexp-match #rx" ->" line))
                          
                         
                         (set! functions (cons line functions))))
         )file_format))

(let ((file (file->string "C:/practice Programs/Elm Projects/src/question_24.elm")))
  (set! file_format file)
  (set! file_format (string-split file_format "\n"))
  (identify_types)
  (identify_type_aliases)
  (identify_functions)
  functions)
