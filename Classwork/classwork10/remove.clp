;;;
; filename: remove.clp
; demonstration
;;;

(defrule remove-eyes "remove person with eye color"
   (find (eyes ?eyes))
   ?f1 <- (person (name ?name) (eyes ?eyes))
  =>
   (printout t ?name " has " ?eyes " eyes." crlf )
   (retract ?f1)
   (printout t "... " ?name " removed." crlf )
)

