; example of 'if' statement
(defrule check
   ?phase <- (phase check-continue)
  =>
   (retract ?phase)
   (printout t "Continue? ")
   (bind ?ans (read))
   (if (or (eq ?ans y) (eq ?ans yes))
      then (assert (phase check-continue))
      else (assert (phase cont))
   )
)

; example of 'while' statement
(defrule continue
   ?phase <- (phase check)
  =>
   (retract ?phase)
   (printout t "Continue? ")
   (bind ?ans (read))
   (while (and (neq ?ans yes) (neq ?ans no))
      do
         (printout t "Continue? ")
         (bind ?ans (read))
      (if (eq ?ans yes)
         then (assert (phase cont))
         else (assert (phase halt))
      )
   )
)

; example of 'switch' statement
(defrule do-it-to-it
   (op ?type ?arg1 ?arg2)
  =>
   (switch ?type
      (case times then
         (printout t ?arg1 " times " ?arg2
                           " is " (* ?arg1 ?arg2) crlf))
      (case plus then
         (printout t ?arg1 " plus " ?arg2
                           " is " (+ ?arg1 ?arg2) crlf))
      (case minus then
         (printout t ?arg1 " minus " ?arg2
                           " is " (- ?arg1 ?arg2) crlf))
      (case div then
         (printout t ?arg1 " divided by " ?arg2
                           " is " (/ ?arg1 ?arg2) crlf))
   )
)

; example of 'loop-for-count' statement
(defrule woof
  =>
   (loop-for-count (?cnt1 2 4) do
      (loop-for-count (?cnt2 3) do
         (printout t ?cnt1 " ")
         (loop-for-count 3 do
            (printout t "."))
            (printout t " " ?cnt2 crlf)
      )
   )
)
