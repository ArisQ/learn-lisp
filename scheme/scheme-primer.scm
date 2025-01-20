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

(define (dump-tree tree indent)
  (if (= (length tree) 1)
      (format #f "(~a)" (car tree))
      (let* ((node-str (format #f "(~a " (car tree)))
             (sub-indent (+ indent (string-length node-str))))
        (string-append
         node-str
         (dump-tree (car (cdr tree)) sub-indent)
         (format #f "\n")
         (fill-indent sub-indent)
         (dump-tree (car (cdr (cdr tree))) sub-indent)
         (format #f ")")))))

(display (dump-tree (build-tree 3) 0))
