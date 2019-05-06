#lang racket

; Returns list of all possible tours with
; the vertices 1 through n.
; Can use Racket function permutations.
; ex output:
;    (genTours 4)
;    ((1 2 3 4) (1 2 4 3) (1 3 2 4) (1 3 4 2) (1 4 2 3) (1 4 3 2))
(define (genTours n)
  (fix-list '() (permutations (build-list n 1)))
)

; Returns length of tour from list of n vertices
; and a tour as input.
; ex output:
;    (score '((3 1) (8 2) (5 4) (2 6) (6 6) (4 8)) '(1 2 3 4 5 6))
;    26.22
(define (score vertices tour)
  (if (null? (cdr tour))
      ; if last stop on tour, connect back to one.
      (+ (pyth
          (get-vertex vertices 1 1)
          (get-vertex vertices (first tour) 1)))
      (+ (pyth
          (get-vertex vertices (first tour) 1) (get-vertex vertices (second tour) 1))
         (score vertices (cdr tour)))
  )
)

; Returns an optimal tour from a list of positions.
; Driver function.
(define (etsp positions)
  (println "etsp")
)

; Returns the number of items in a list.
(define (count list)
  (if (null? list)
      0
      (+ 1 (count (cdr list)))
   )
)

; Returns a list from 1 to n.
(define (build-list n p)
  (if (< n p)
      null
      (cons p (build-list n (+ p 1)))
  )
)

; Return list that doesn't have val as car.
(define (fix-list li original)
  (if (null? original)
      li
      (if (null? li)
          (fix-list (cons (first original) li) (cdr original))
          (if (eq? 1 (first (next original)))
              (fix-list (cons (next original) li) (cdr original))
              (fix-list li (cdr original))
          )
      )
  )
)

; Get's the next item in a list.
; Avoids contract violations.
(define (next li)
  (if (null? (cdr li))
      (car li)
      (cadr li)
  )
)

; Get's the first item in a list.
(define (first li)
  (car li)
)

; Gets the vertex from a list in position n
(define (get-vertex li n p)
  (if (= p n)
      (car li)
      (get-vertex (cdr li) n (+ p 1))
  )
)

; Computes the length of the edge between two vertices.
(define (pyth v1 v2)
  (sqrt
   (+
    (get-square (first v1) (first v2))
    (get-square (next v1) (next v2))))
)

; Computes the square of x and y vertice values
(define (get-square v1 v2)
  (expt (- v2 v1) 2)
)