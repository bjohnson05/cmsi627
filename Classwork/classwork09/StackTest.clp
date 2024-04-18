;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;;  File name  : StackTest.clp
;;;  Purpose    : This CLIPS source file tests the "Stack.clp" program to
;;;                push to and pop from a named stack, as well as peek at
;;;                what is on top of the stack.
;;;  Project    : CMSI 627
;;;  Date       : 2024-03-03
;;;  Author     : Dr. Johnson
;;;
;;;  Operation  : This source file is intended to be run from the batch
;;;                file with the corresponding name.  To do this, in
;;;                the CLIPS environment, use the command:
;;;
;;;                   (batch Stack.bat)
;;;
;;;               It is assumed that all files to be tested will be in
;;;                on the current drive in the current logged folder.
;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;;  Define a rule to say the stack test is starting
;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   (defrule start-the-test "start the test"
       (start)
      =>
       (assert (running))
       (printout t crlf "...stack test started crlf crlf)
   )

;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;;  Define a rule to say the stack test is over
;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   (defrule end-the-test "end the test"
       ?running <- (running)
      =>
       (retract ?running)
       (printout t crlf "debugging: running is ?running" crlf)
       (printout t crlf "stack test completed crlf crlf)
   )

;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;;  Define the facts for the stack
;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   (deffacts test-stack "Test the stack functions"
   (assert (stack myStack X Y))
;;;   (assert (push-value myStack A))
;;;   (assert (push-value myStack B))
;;;   (assert (push-value myStack C))
;;;   (assert (push-value myStack D))
;;;   (assert (pop-value myStack))
;;;   (assert (pop-value myStack))
;;;   (assert (pop-value myStack))
;;;   (assert (peek-stack myStack))
;;;   (assert (pop-value myStack))
;;;   (assert (pop-value myStack))
;;;   (assert (pop-value myStack))
;;;   (assert (pop-value myStack))
   )

