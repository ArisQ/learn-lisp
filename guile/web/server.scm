
(use-modules (web server)
			 (web request)
			 (web response)
			 (web uri))

(define (request-path-components request)
  (split-and-decode-uri-path (uri-path (request-uri request))))

(define (hello-world-handler-v1 request request-body)
  (values '((content-type . (text/plain)))
		  "Hello World!"))

(define (hello-world-handler request request-body)
  (if (equal? (request-path-components request)
			  '("hacker"))
	  (values '((content-type . (text/plain)))
			  "Hello hacker!")
	  (not-found request)))

(define (not-found request)
  (values (build-response #:code 404)
		  (string-append "Resource not found: "
						 (uri->string (request-uri request)))))

(run-server hello-world-handler)

