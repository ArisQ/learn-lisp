#!/usr/bin/env guile -e main -s
!#

(display "Hello, world!")
(display "你好！")
(newline)

(define (inc x) (+ x 1))
(display (inc 1))


(define (main ...)
  (display "你好！"))

;; guile -e main2 hello-guile.scm
(define (main2 args)
  (display args))

(write (command-line))

