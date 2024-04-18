;;;
;;; filename: problem7.1.clp
;;; define relationships
;;;

(deftemplate person "define a person for problem 7.1"
   (slot name)
   (slot father)
   (slot mother)
   (slot gender)
   (slot child)
)

(deffacts family "family members"
   (person (name John)
           (gender male)
           (father Tom)
           (mother Susan)
   )
   (person (name Tom)
           (gender male)
           (child John)
   )
   (person (name Susan)
           (gender female)
           (child John)
   )
)

