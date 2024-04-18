;;;
; filename: people.clp
; demonstration
;;;

(deftemplate person
   (slot name)(slot eyes)(slot hair)
)

(deffacts people
   (person (name Sammy)(eyes blue) (hair black))
   (person (name Esmerelda)(eyes green) (hair blue))
   (person (name Gollum)(eyes red) (hair missing))
   (person (name Groucho)(eyes blue) (hair black))
)

