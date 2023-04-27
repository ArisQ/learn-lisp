(defun make-cd (title artist rating ripped)
  (list :title title :artist artist :rating rating :ripped ripped))

(make-cd "Roses" "Kathy Matted" 7 t)

(defvar *db* nil)

(defun add-record (cd) (push cd *db*))

(add-record (make-cd "Roses" "Kathy Matted" 7 t))
(add-record (make-cd "Fly" "Dixie Chicks" 8 t))
(add-record (make-cd "Home" "Dixie Chicks" 9 t))

; show *db*
*db*

(defun dump-db ()
  (dolist (cd *db*)
    (format t "~{~a: ~10t~a~%~}~%" cd)))

(defun dump-cd-list (cd-list)
  (format t "~{~{~a: ~10t~a~%~}~%~}" cd-list))

;(defun clear-db ()
;  (dolist (cd *db*)
;    (pop *db*))) ; TODO
(defun clear-db ()
  (setf *db* nil))

(defun prompt-read (prompt)
  (format *query-io* "~a: " prompt)
  (force-output *query-io*)
  (read-line *query-io*))

(defun prompt-for-cd ()
  (make-cd
   (prompt-read "Title")
   (prompt-read "Artist")
   (or (parse-integer (prompt-read "Rating") :junk-allowed t) 0)
   (y-or-n-p "Ripped [y/n]")))

(defun add-cds ()
  (loop (add-record (prompt-for-cd))
	(if (not (y-or-n-p "Another? [y/n]: ")) (return))))

(defun save-db (filename)
  (with-open-file (out filename
		       :direction :output
		       :if-exists :supersede)
    (with-standard-io-syntax
      (print *db* out))))

; (save-db "x.db")

(defun load-db (filename)
  (with-open-file (in filename)
    (with-standard-io-syntax
      (setf *db* (read in)))))

; (load-db "x.db")


;; query
(defun select (selector-fn)
  (remove-if-not selector-fn *db*))

(defun artist-selector (artist)
  #'(lambda (cd) (equal (getf cd :artist) artist)))

;; (dump-cd-list (select (artist-selector "Dixie Chicks")))
(dump-cd-list (select (artist-selector "Kathy Matted")))

(defun where (&key title artist rating (ripped nil ripped-p))
  #'(lambda (cd)
      (and
       (if title    (equal (getf cd :title)  title)  t)
       (if artist   (equal (getf cd :artist) artist) t)
       (if rating   (equal (getf cd :rating) rating) t)
       (if ripped-p (equal (getf cd :ripped) ripped) t))))

(dump-cd-list (select (where :artist "Kathy Matted")))

(defun update (selector-fn &key title artist rating (ripped nil ripped-p))
  (setf *db*
	(mapcar
	 #'(lambda (row)
	     (when (funcall selector-fn row)
	       (if title    (setf (getf row :title)  title))
	       (if artist   (setf (getf row :artist) artist))
	       (if rating   (setf (getf row :rating) rating))
	       (if ripped-p (setf (getf row :ripped) ripped)))
	     row)
	 *db*)))

(update (where :artist "Dixie Chicks") :rating 11)

(defun delete-rows (selector-fn)
  (setf *db* (remove-if selector-fn *db*)))

;; (delete-rows (where :artist "Dixie Chicks"))

(dump-db)

(defmacro backwards (expr) (reverse expr))
(backwards ("hello, world" t format))

(print `(1 2 ,(+ 1 2)))

(defun make-comparision-expr (field value)
  `(equal (getf cd ,field) ,value))

(print (make-comparision-expr :artist "Dixie Chicks"))

(defun make-comparision-list (fields)
  (loop while fields
	collecting (make-comparision-expr (pop fields) (pop fields))))

(print (make-comparision-list '(:artist "Dixie Chicks" :rating 1)))

(defmacro wherem (&rest clauses)
  `#'(lambda (cd) (and ,@(make-comparision-list clauses))))

(print (wherem :artist "Dixie Chicks" :rating 11))
(print (macroexpand-1 '(wherem :artist "Dixie Chicks" :rating 11)))
(dump-cd-list (select (wherem :artist "Dixie Chicks" :rating 11)))

(defvar *cd-rate* 11)
(print (select (wherem :artist "Dixie Chicks" :rating *cd-rate*)))
(print (macroexpand-1 '(wherem :artist "Dixie Chicks" :rating *cd-rate*)))
(print (select (wherem :artist "Dixie Chicks" :rating (+ 10 1))))
(print (macroexpand-1 '(wherem :artist "Dixie Chicks" :rating (+ 10 1))))

