;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;;  File name  : Queue.clp
;;;  Purpose    : This CLIPS source file runs the "Queue.clp" program to
;;;                push to and pop from a named queue.
;;;  Project    : CMSI 682
;;;  Date       : 14-Feb-2003
;;;  Author     : B.J. Johnson
;;;  Description: See purpose.  It's that simple.  Note the blatant rip-off
;;;                of Dr. August's stack.clp program, but that's because
;;;                a queue is just a stack that pops from the bottom.
;;;
;;;  Operation  : This source file is intended to be run from the batch
;;;                file with the corresponding name.  To do this, in
;;;                the CLIPS environment, use the command:
;;;
;;;                   (batch Queue.bat)
;;;
;;;               It is assumed that all files to be tested will be in
;;;                a folder called "SourceCode".  This will be on the
;;;                current logged drive for the environment.
;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;;  Revision History:
;;;  -----------------
;;;
;;;   Ver      Date      Modified by:  Description
;;;  -----  -----------  ------------  ---------------------------------
;;;  1.0.0  14-Feb-2003  B.J. Johnson  Initial release
;;;
;;;
;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;;  Define a rule for pushing a value
;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   (defrule push-value "Push onto front of named queue"
       ?push-value <- (push-value ?queue-name ?value)
       ?queue <- (queue ?queue-name $?rest)
      =>
       (retract ?push-value)
       (retract ?queue)
       (assert (queue ?queue-name ?value $?rest))
       (printout t "Pushing value " ?value " on to queue " ?queue-name crlf)
   )

;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;;  Define a rule for popping a value
;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   (defrule pop-value-valid "Pop off from back of named queue"
       ?pop-value <- (pop-value ?queue-name)
       ?queue <- (queue ?queue-name $?rest ?value )
      =>
       (retract ?pop-value)
       (retract ?queue)
       (assert (queue ?queue-name $?rest))
       (assert (popped-value ?queue-name ?value))
       (printout t "Popping value " ?value " from queue " ?queue-name crlf)
   )

;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;;  Define a rule for popping a value
;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   (defrule pop-value-invalid "Check for an empty queue"
       ?pop-value <- (pop-value)
       (queue ?queue-name)
     =>
       (retract ?pop-value)
       (printout t "ERROR: Queue " ?queue-name " is empty" crlf)
   )

;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;;  Define a rule for displaying the queue
;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   (defrule display-queue "Show what is in the queue"
       ?queue <- (queue ?queue-name $?rest)
      =>
       (printout t "Queue contents are: " ?queue crlf)
   )