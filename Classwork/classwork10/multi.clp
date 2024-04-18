
(deftemplate person "a sample deftemplate"
   (multislot name)
   (slot age)
   (slot e-mail)
)

(deffacts folks "sample deffacts using person"
   (person (name Dr. Hugo Z. Hackenbush)
           (age 29)(e-mail "hackenbush@lmu.edu"))
   (person (name Rufus Z. Firefly)
           (age 31)(e-mail "rz.firefly@lmu.edu"))
   (person (name Otis P. Driftwood)
           (age 30)(e-mail "his.woodness@lmu.edu"))
   (person (name J. Cheever Loophole)
           (age 29)(e-mail "loopy.lupe@lmu.edu"))
)

(defrule print-name "print a matching name"
   (look-at ?age)
   (person (name $?name)
           (age  ?age))
  =>
   (printout t ?name " is " ?age " years old." crlf)
)

(defrule first-name "print the first name only"
   (look-at ?age)
   (person (name ?first $?rest)
           (age  ?age))
  =>
   (printout t ?first " is " ?age " years old." crlf)
)
