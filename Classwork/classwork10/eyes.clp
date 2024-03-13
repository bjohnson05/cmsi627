;;;
; filename: eyes.clp
; demonstration for class
;;;

(deftemplate person
   (slot name)(slot eyes)(slot hair)
)

(defrule has-blue-eyes
   (person (name ?name) (eyes blue))
  =>
   (printout t ?name " has blue eyes." crlf)
)

(deffacts people
   (person (name Sammy)(eyes blue) (hair black))
   (person (name Esmerelda)(eyes green) (hair blue))
   (person (name Gollum)(eyes red) (hair missing))
   (person (name Groucho)(eyes blue) (hair black))
)
