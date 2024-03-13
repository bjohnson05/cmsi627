;;;
; filename: fire.clp
; demonstration
;;;

(deftemplate emergency (slot type))
(deftemplate response (slot action))

(defrule fire-emergency "A sample rule"
   (emergency (type fire))
  =>
   (assert (response (action activate-sprinklers)))
)

