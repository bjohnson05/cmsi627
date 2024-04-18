
(defrule get-human-move
   (player-move h)
   (pile-size ?size)
   (test (> ?size 1))
  =>
   (printout t "How many sticks do you wish to take? ")
   (assert (human-takes (read)))
)

(defrule good-human-move
   ?whose-turn <- (player-move h)
   (pile-size ?size)
   ?number-taken <- (human-takes ?choice)
   (test (and (integerp ?choice)
              (>= ?choice 1)
              (<= ?choice 3)
              (<  ?choice ?size))
   )
  =>
   (retract ?whose-turn ?number-taken)
   (printout t "human move valid" crlf)
)

(defrule bad-human-move
   ?whose-turn <- (player-move h)
   (pile-size ?size)
   ?number-taken <- (human-takes ?choice)
   (test (and (integerp ?choice)
              (< ?choice 1)
              (> ?choice 3)
              (>=  ?choice ?size))
   )
  =>
   (printout t "human move invalid" crlf)
   (retract ?whose-turn ?number-taken)
   (assert (player-move h))
)

(defmethod check-input ((?question STRING)
                        (?value1 INTEGER)
                        (?value2 INTEGER))
   (printout t ?question " (" ?value1 "-" ?value2 ") ")
   (bind ?answer (read))
   (while (or (not (integerp ?answer))
              (< ?answer ?value1)
              (> ?answer ?value2))
      (printout t ?question " (" ?value1 "-" ?value2 ") ")
      (bind ?answer (read))
   )
   (return ?answer)
)
