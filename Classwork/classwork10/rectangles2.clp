;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;;  File name  : rectangles.clp
;;;  demonstration of summing using rules
;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

(deftemplate rectangle "a simple rectangle"
   (slot height)
   (slot width)
)

(deffacts lots-of-em "define a bunch of rectangles"
   (rectangle (height 10)(width 6))
   (rectangle (height  7)(width 5))
   (rectangle (height  6)(width 8))
   (rectangle (height  2)(width 5))
   (sum 0)
)

(defrule sum-rectangles "add 'em up!"
   (rectangle (height ?height)(width ?width))
  =>
   (assert (add-to-sum (* ?height ?width)))
)

(defrule sum-areas "add up the areas"
   ?sum <- (sum ?total)
   ?new-area <- (add-to-sum ?area)
  =>
   (retract ?sum ?new-area)
   (assert (sum (+ ?total ?area)))
)

(defrule print-sum "print 'em out"
   (sum ?sum)
  =>
   (printout t "Total Area: " ?sum crlf)
)
