;;;
;  filename: accident.clp
;  demonstration of quantifier 'forall'
;;;

(deftemplate accident
   (slot collision-type)
   (slot vehicle-1-type)
   (slot vehicle-2-type)
   (slot location)
)

(deftemplate injury
   (slot severity)
)

(defrule handle-accident
   (forall (accident (collision-type head-on)
                     (vehicle-1-type truck)
                     (vehicle-2-type sedan)
                     (location ?loc ))
           (injury (severity critical))
   )
  =>
   (printout t "CALL 911 IMMEDIATELY!" crlf)
)
