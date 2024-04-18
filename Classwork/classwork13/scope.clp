(defrule scope-1 "local scope example"
   (data-1 ?x)
  =>
   (printout t crlf "local scope: ?x = " ?x crlf)
)

(defrule scope-2 "local scope example"
   (data-2 ?x)
  =>
   (printout t crlf "local scope: ?x = " ?x crlf)
)
(defglobal ?*x* = 47
           ?*y* = (+ ?*x* 1)
)
(defrule scope-3 "global scope example"
  =>
   (printout t crlf "global scope: ?*x* = " ?*x* crlf)
)
