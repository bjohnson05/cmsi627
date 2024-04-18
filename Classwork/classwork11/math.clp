
;;;  PEMDAS RULES!
;;;  (3 + 4) * (5 + 6) + 7 = 84
;;;  (5 * (5 + 6 + 7)) - ((3 * (4 / 9) + 2) / 8) = 89.58333333
;;;  6 - 9 * 8 / 3 + 4 - (8 - 2 - 3) * 6 / 7 = -16.571428

;;;  CLIPS versions:
;;;  (+ (* (+ 3 4) (+ 5 6)) 7)
;;;  (- (* 5 (+ 5 6 7)) (/ (+ (* 3 (/ 4 9)) 2) 8))
;;;  (+ (- 6 (/ (* 9 8) 3)) (- 4 (/ (* (- 8 2 3) 6) 7)))

;  the rule to calculate and print the results
(defrule blah "do some math"
  =>
   (bind ?m1 (+ (* (+ 3 4) (+ 5 6)) 7))
   (bind ?m2 (- (* 5 (+ 5 6 7)) (/ (+ (* 3 (/ 4 9)) 2) 8)))
   (bind ?m3 (+ (- 6 (/ (* 9 8) 3)) (- 4 (/ (* (- 8 2 3) 6) 7))))
   (printout t crlf "m1: " ?m1 crlf)
   (printout t crlf "m2: " ?m2 crlf)
   (printout t crlf "m3: " ?m3 crlf)
)
