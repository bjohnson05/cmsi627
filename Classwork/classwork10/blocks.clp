;;;
; filename: blocks.clp
; demonstration of blocks world
;  showing how to solve a goal
;;;

(deftemplate on-top-of "relationship of a block"
   (slot upper)
   (slot lower)
)

(deftemplate goal "define the goal state"
   (slot move)
   (slot on-top-of)
)

(deffacts stacks "initial stack configuration"
   (block A)
   (block B)
   (block C)
   (block D)
   (block E)
   (block F)
   (on-top-of (upper A)(lower B))
   (on-top-of (upper B)(lower C))
   (on-top-of (upper D)(lower E))
   (on-top-of (upper E)(lower F))
   (on-top-of (upper nothing)(lower A))
   (on-top-of (upper C)(lower floor))
   (on-top-of (upper nothing)(lower D))
   (on-top-of (upper F)(lower floor))
   (goal (move B)(on-top-of F))
)

(defrule move-direct "direct move of a block"
   ?goal <- (goal (move ?block1)
                  (on-top-of ?block2))
   (block ?block1)
   (block ?block2)
   (on-top-of (upper nothing)(lower ?block1))
   ?stack1 <- (on-top-of (upper ?block1)
                         (lower ?block3))
   ?stack2 <- (on-top-of (upper nothing)
                         (lower ?block2))
  =>
   (retract ?goal ?stack1 ?stack2)
   (assert (on-top-of (upper ?block1)
                      (lower ?block2))
           (on-top-of (upper nothing)
                      (lower ?block3)))
   (printout t ?block1 " moved on top of "
                              ?block2 "." crlf)
)

(defrule move-floor "move block to floor"
   ?goal <- (goal (move ?block1)
                     (on-top-of floor))
   (block ?block1)
   (on-top-of (upper nothing)(lower ?block1))
   ?stack <- (on-top-of (upper ?block1)
                           (lower ?block2))
  =>
   (retract ?goal ?stack)
   (assert (on-top-of (upper ?block1)
                      (lower floor))
           (on-top-of (upper nothing)
                      (lower ?block2)))
   (printout t ?block1 " moved to the floor." crlf)
)


(defrule clear-upper "clear blocks off top"
   (goal (move ?block1))
   (block ?block1)
   (on-top-of (upper ?block2)(lower ?block1))
   (block ?block2)
  =>
   (assert (goal (move ?block2)
                 (on-top-of floor)))
)

(defrule clear-lower "clear blocks for move"
   (goal (on-top-of ?block1))
   (block ?block1)
   (on-top-of (upper ?block2)(lower ?block1))
   (block ?block2)
  =>
   (assert (goal (move ?block2)
                 (on-top-of floor)))
)
