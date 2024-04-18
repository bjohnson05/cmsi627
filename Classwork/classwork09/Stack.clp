 	;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;;  File name  : Stack.clp
;;;  Purpose    : This CLIPS source file runs the "Stack.clp" program to
;;;                push to and pop from a named stack.
;;;  Date       : 2024-03-03
;;;  Author     : Dr. Johnson
;;;  Description: This file creates a stack structure and includes the
;;;                rules to push, pop, and peek.
;;;
;;;  Operation  : This source file is intended to be run from the batch
;;;                file with the corresponding name for testing purposes.
;;;                To do this, in the CLIPS environment, use the command:
;;;
;;;                   (batch Stack.bat)
;;;
;;;               It is assumed that all files to be tested will be in
;;;                on the current drive in the current logged folder.
;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;;  Define a rule for pushing a value
;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   (defrule push-a-value "Push onto top of named stack"
       ?push-value <- (push-value ?stack-name ?value)
       ?stack <- (stack ?stack-name $?rest)
      =>
       (retract ?push-value)
       (retract ?stack)
       (assert (stack ?stack-name ?value $?rest))
       (printout t "Pushed value " ?value " on to stack " ?stack-name crlf)
   )

;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;;  Define a rule for popping a value
;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   (defrule pop-a-value-valid "Pop off from top of named stack"
       ?pop-value <- (pop-value ?stack-name)
       ?stack <- (stack ?stack-name ?value $?rest )
      =>
       (retract ?pop-value)
       (retract ?stack)
       (assert (stack ?stack-name $?rest))
       (assert (popped-value ?stack-name ?value))
       (printout t "Popping value " ?value " from stack " ?stack-name crlf)
   )

;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;;  Define a rule for popping a value
;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   (defrule pop-a-value-invalid "Check for an empty stack"
       ?pop-value <- (pop-value)
       (stack ?stack-name)
     =>
       (retract ?pop-value)
       (printout t "ERROR: Queue " ?stack-name " is empty" crlf)
   )

;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;;  Define a rule for displaying the stack
;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   (defrule display-the-stack "Show what is in the stack"
       ?stack <- (stack ?stack-name $?rest)
      =>
       (assert (stack ?stack-name $?rest))
       (printout t "Stack contents are: " (implode$(?stack)) crlf crlf)
   )

;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;;  Define a rule for peeking at the stack
;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   (defrule peek-at-stack "Show what is on top of the stack"
       ?stack <- (stack ?stack-name ?value $?rest)
      =>
       (assert (stack ?stack-name ?value $?rest))
       (printout t "Top value on stack is: " ?value crlf)
   )
