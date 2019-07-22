(import
  :judah/la
  :std/test)


;; Tests for λ alias
;; -----------------

(def ldef-test
  (test-suite "λ ALIAS TESTS"
    (test-case "Simple definition"
      (def return-from-lambda (λ (x) x))
      (check-eqv? (return-from-lambda 1) 1)
      (check-eqv? (return-from-lambda (return-from-lambda (+ 5 5))) 10))))


;; Tests for λ* alias
;; ------------------

(def lcase-test
  (test-suite "λ* ALIAS TESTS"
    (test-case "Case definition"
      (def return-from-case-lambda
        (λ*
          ((x y z) (+ x y z))
          ((x y) (+ x y))
          ((x) (+ x 1))))

      (check-eqv? (return-from-case-lambda 1) 2)
      (check-eqv? (return-from-case-lambda 1 2) 3)
      (check-eqv? (return-from-case-lambda 1 2 3) 6))))


;; Tests for λ and λ* aliases
;; --------------------------

(def llet-test
  (test-suite "LET TESTS"
    (test-case "Let with lambda"
      (check-eqv? ((let (x 0) (λ (y) (* 2 (+ y y)))) 1) 4))
    (test-case "Let with case-lambda"
      (check-eqv? ((let () (λ* ((x) (- x x)))) 1) 0))
      (check-eqv? ((let () (λ* ((x y) (* x y)))) 5 3) 15)))


;; Test Execution
;; ---------------------------------------------------------------------------

(run-tests! ldef-test lcase-test llet-test)
(test-report-summary!)

(case (test-result)
    ((OK) (exit 0))
    (else (exit 1)))
