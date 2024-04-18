;;;
; filename: findeyes.clp
; demonstration
;;;

(deftemplate find (slot eyes))

(defrule find-eyes "find person with eye color"
   (find (eyes ?eyes))
   (person (name ?name)(eyes ?eyes))
  =>
   (printout t ?name " has " ?eyes " eyes." crlf)
)
