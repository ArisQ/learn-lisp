(display "Hello world!\n")

(define (greet name)
  (string-append "Hello " name "!"))

(greet "Samantha")

((lambda (name)
   (string-append "Hello " name "!"))
 "Horace")

(let ((name "Horace"))
   (string-append "Hello " name "!"))

(let* ((name "Horace")
	  (greeting (string-append "Hello " name "!")))
  greeting)

(define (chatty-add chatty-name . nums)
        (format #t "<~a> 求和结果为 ~a!\n"
                chatty-name (apply + nums)))
(chatty-add "Chester" 2 4 8 6)

(define* (shopkeeper thing-to-buy
                     #:optional (how-many 1)
                     (cost 20)
                     #:key (shopkeeper "Sammy")
                     (store "Plentiful Great Produce"))
  (format #t "You walk into ~a, grab something from the shelves,\n" store)
  (display "and walk up to the counter.\n\n")
  (format #t "~a looks at you and says, " shopkeeper)
  (format #t "~a ~a, eh? That'll be ~a coins!'\n" how-many thing-to-buy
          (* cost how-many)))

(shopkeeper "apples")
(display "\n==========\n")
(shopkeeper "bananas" 10 28)
(display "\n==========\n")
(shopkeeper "screws" 3 2
            #:shopkeeper "Horace"
            #:store "Horace's Hardware")

(define (add-and-multiply x y)
  (values (+ x y)
          (* x y)))

(add-and-multiply 2 8)

(define-values (sum product)
  (add-and-multiply 3 10))

(format #t "sum=~a product=~a~%" sum product)

(values
 (string? "apple")
 (string? 128)
 (string? 'apple))

(define (string-enthusiast obj)
  (if (string? obj)
      "Oh my gosh you gave me A STRING!!!"
      "That WASN'T A STRING AT ALL!! MORE STRINGS PLEASE!"))

(string-enthusiast "carrot")

(values
 (> 8 9)
 (< 8 9)
 (> 8 8)
 (>= 8 8))

(define (goldilocks n smallest-ok biggest-ok)
  (if (< n smallest-ok)
      "Too small!"
      (if (> n biggest-ok)
          "Too big!"
          "Just right!")))

;; 多值返回string时，org-babel只显示了一个
(list
 (goldilocks 3 10 20)
 (goldilocks 33 10 20)
 (goldilocks 12 10 20))

(define (goldilocks n smallest-ok biggest-ok)
  (cond
   ((< n smallest-ok) "Too small!")
   ((> n biggest-ok) "Too big!")
   (else "Just right!")))

;; 多值返回string时，org-babel只显示了一个
(list
 (goldilocks 3 10 20)
 (goldilocks 33 10 20)
 (goldilocks 12 10 20))

(define a-list (list 1 2 3))
(define b-list (list 1 2 3))

(values
 (equal? a-list a-list)
 (equal? a-list b-list)
 (eq? a-list a-list)
 (eq? a-list b-list))

(define (fruit-sleuth fruit basket)
  (if (member fruit basket)
	  "Found the fruit you're looking for!"
	  "No fruit found! Gadzooks!"))
(define fruit-basket '(apple banana citron))

(values
 (member 'b '(a b c))
 (fruit-sleuth 'banana fruit-basket)
 (fruit-sleuth 'pineapple fruit-basket))

(values
 0
 (list 1 2 "cat" 33.8 'foo)
 '(1 2 "cat" 33.8 foo)
 '(foo 'bar '''baz)
 '()
 (null? '()) ;; nil
 (cons 'a '())
 (cons 'a (cons 'b (cons 'c '())))
 (list 'a 'b 'c)
 '(a b c)
 (cons 'a 'b) ;; dotted list
 (cons 'a (cons 'b '()))
'(a . b)
'(a b))

(values
 (car '(a b c))
 (cdr '(a b c))
 (car (cdr '(a b c)))
 )

(values
 0
 '(+ 1 2 (- 8 4))
 'foo
 (quote foo)
 '(lambda (x) (* x 2))
 (quote (lambda (x) (* x 2))))

(define animal-noises
  '((cat . meow)
    (dog . woof)
    (sheep . baa)))
(values
 animal-noises
 (assoc 'cat animal-noises)
 (assoc 'alien animal-noises))

(define (cat-years years)
  (cond
   ((<= years 1) (* years 15))
   ((<= years 2) (+ 15 (* 9 (- years 1))))
   (else (+ 24 (* 4 (- years 2))))))

(define (cat-entry name age)
  `(cat (name ,name)
        (age ,age)
        (cat-years-age ,(cat-years age))))

(values
 0
 (cat-entry "Missy Rose" 16)
 (cat-entry "Kelsey" 22))

(define (make-goldilocks smallest-ok biggest-ok)
  (define (goldilocks n)
    (cond
     ((< n smallest-ok) "Too small!")
     ((> n biggest-ok) "Too big!")
     (else "Just right!")))
  goldilocks)

(define goldi
  (make-goldilocks 10 30))

(values
 #t
 (goldi 3)
 (goldi 33)
 (goldi 12))

(define (symbol-length sym)
  (string-length (symbol->string sym)))

(values
 (string-length "cat")
 (string-length "gorilla")
 (map string-length '("cat" "dog" "gorilla" "salamander"))
 (map symbol-length '(basil oregano parsley thyme))
 (map (lambda (str)
        (string-append "I just love " (string-upcase str) "!!!"))
      '("straberries" "bananas" "grapes")))

(for-each (lambda (str)
            (display
             (string-append "I just love " (string-upcase str) "!!!\n")))
          '("ice cream" "fudge" "cookies"))

(define (my-for-each proc lst)
  (if (eq? lst '())
      'done
      (let ((item (car lst)))
        (proc item)
        (my-for-each proc (cdr lst)))))

(my-for-each (lambda (str)
               (display
                (string-append "I also love " (string-upcase str) "!!!\n")))
             '("ice cream" "fudge" "cookies"))

(define (build-tree depth)
  (if (= depth 0)
      '(0)
      (list depth
            (build-tree (- depth 1))
            (build-tree (- depth 1)))))

(define (fill-indent n)
  (if (= n 0)
      ""
      (string-append " " (fill-indent (- n 1)))))

(define* (fill-indent-2 n #:optional (idt ""))
  (if (= n 0)
      idt
      (fill-indent-2 (- n 1) (string-append idt " "))))

(define (dump-tree tree indent)
  (if (= (length tree) 1)
      (format #f "(~a)" (car tree))
      (let* ((node-str (format #f "(~a " (car tree)))
             (sub-indent (+ indent (string-length node-str))))
        (string-append
         node-str
         (dump-tree (car (cdr tree)) sub-indent)
         (format #f "\n")
         ;; (fill-indent sub-indent)
         (fill-indent-2 sub-indent)
         (dump-tree (car (cdr (cdr tree))) sub-indent)
         (format #f ")")))))

(display (dump-tree (build-tree 3) 0))

(letrec ((alice
          (lambda (first?)
            (report-status "Alice" first?)
            (if first? (bob #f))))
         (bob
          (lambda (first?)
            (report-status "Bob" first?)
            (if first? (alice #f))))
         (report-status
          (lambda (name first?)
            (display
             (string-append name " is "
                            (if first? "first" "second") "!\n")))))
  (alice #t)
  (display "-----\n")
  (bob #t))

(let loop ((words '("carrot" "potato" "pea" "celery"))
           (num-words 0)
           (num-chars 0))
  (if (eq? words '())
      (format #f "We found ~a words and ~a chars!"
              num-words num-chars)
      (loop (cdr words)
            (+ num-words 1)
            (+ num-chars (string-length (car words))))))

(define (fill-indent n)
  (let loop ((i n)
             (idt ""))
    (if (= i 0)
        idt
        (loop (- i 1)
              (string-append idt (format #f "~x" i))))))

(fill-indent 10)

(define chest 'sword)
(format #t "~a\n" chest)
(set! chest 'gold)
(format #t "~a\n" chest)

(define (make-count-down n)
  (lambda ()
    (define last-n n)
    (if (zero? n)
        0
        (begin
          (set! n (- n 1))
          last-n))))
(define cdown (make-count-down 3))
(values
 (cdown)
 (cdown)
 (cdown)
 (cdown)
 (cdown))

(define vec (vector 'a 'b 'c))
(define (print v) (format #t "~a~%" v))

(print vec)
(print (vector-ref vec 1))
(vector-set! vec 1 'boop)
(print (vector-ref vec 1))
(print vec)

(define (when test . body)
  `(if ,test
       ,(cons 'begin body)))

(define-macro (when2 test . body)
  `(if ,test
       ,(cons 'begin body)))

(define-syntax-rule (when3 test body ...)
  (if test
      (begin body ...)))

(define (our-test) #t)
(define (do-thing-1) (display "thing-1\n"))
(define (do-thing-2) (display "thing-2\n"))

(define (print v) (format #t "~a~%" v))

(print (when '(our-test)
		 '(do-thing-1)
		 '(do-thing-2)))
(display "=====\n")
(print (when2 (our-test)
			  (do-thing-1)
			  (do-thing-2)))
(display "=====\n")
(when3 (our-test)
       (do-thing-1)
       (do-thing-2))

(define-syntax-rule (for (item lst) body ...)
  (for-each (lambda (item)
              body ...)
            lst))

(for (str '("strawberries" "bananas" "grapes"))
     (display (string-append "I just love "
                             (string-upcase str)
                             "!!!\n")))

(define-syntax-rule (methods ((method-id method-args ...)
                              body ...) ...)
  (lambda (method . args)
    (letrec ((method-id
              (lambda (method-args ...)
                body ...)) ...)
      (cond
       ((eq? method (quote method-id))
        (apply method-id args)) ...
        (else
         (error "No such method: " method))))))

(define (make-enemy name hp)
  (methods
   ((get-name) name)
   ((damage-me weapon hp-lost)
    (cond
     ((dead?) (format #t "Poor ~a is already dead!\n" name))
     (else (set! hp (- hp hp-lost))
           (format #t "You attack ~a, doing ~a damage!\n" name hp-lost))))
   ((dead?) (<= hp 0))))

(define (print v) (format #t "~a~%" v))
(define hobgob (make-enemy "Hobgoblin" 25))
(print (hobgob 'get-name))
(print (hobgob 'dead?))
(print (hobgob 'damage-me "club" 10))
(print (hobgob 'damage-me "sword" 20))
(print (hobgob 'damage-me "pickle" 2))
(print (hobgob 'dead?))

(use-modules (ice-9 match))

(define (env-lookup env name)
  (match (assoc name env)
    ((_key . val) val)
    (_ (error "Variable unbound: " name))))

(define (extend-env env names vals)
  (if (eq? names '())
      env
      (cons (cons (car names) (car vals))
            (extend-env env (cdr names) (cdr vals)))))

(define (evaluate expr env)
  (match expr
    ((or #t #f (? number?)) expr)
    (('quote quoted-expr) quoted-expr)
    ((? symbol? name) (env-lookup env name))
    (('if test consequent alternate)
     (if (evaluate test env)
         (evaluate consequent env)
         (evaluate alternate env)))
    (('lambda (args ...) body)
     (lambda (. vals)
       (evaluate body (extend-env env args vals))))
    ((proc-expr arg-exprs ...)
     (apply (evaluate proc-expr env)
            (map (lambda (arg-expr)
                   (evaluate arg-expr env))
                 arg-exprs)))))

(define math-env
  `((+ . ,+)
    (- . ,-)
    (* . ,*)
    (/ . ,/)))

(values
 (evaluate '(* (- 8 (/ 30 5)) 21)
           math-env)
 (evaluate '((lambda (x) (* x x))
             4)
           math-env))

(define fib-program
  '((lambda (prog arg)
      (prog prog arg))
    (lambda (fib n)
      (if (= n 0)
          0
          (if (= n 1)
              1
              (+ (fib fib (+ n -1))
                 (fib fib (+ n -2))))))
    10))

(define fib-env
  `((+ . ,+)
    (n . ,1)
    (= . ,=)))

(evaluate fib-program fib-env)
;; (evaluate '(if (= n 0)
;;                0
;;                (if (= n 1)
;;                    1
;;                    2)) fib-env)

(values
 (env-lookup  '((foo . newer-foo)
                (bar . bar)
                (foo . older-foo))
              'foo)
 (extend-env '((foo . foo-val))
             '(bar quux)
             '(bar-val quux-val))
(evaluate #t '())
(evaluate #f '())
(evaluate 33 '())
(evaluate -2/3 '())
(evaluate ''foo '())
(evaluate ''(1 2 3) '())
(evaluate (quote (quote (1 2 3))) '())
(evaluate 'x '((x . 33)))
(evaluate '((lambda (x) x) 33) '())
((evaluate '(lambda (x y) x) '()) 'first 'second)
((evaluate '(lambda (x y) y) '()) 'first 'second))
