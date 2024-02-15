;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;;  File name  : QueueTest.clp
;;;  Purpose    : This CLIPS source file tests the "Queue.clp" program to
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
;;;  Define the facts for the queue
;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   (deffacts test-queue "Test the queue functions" 
     (queue myQueue X Y)
     (push-value myQueue A)
     (pop-value myQueue)
     (push-value myQueue B)
     (pop-value myQueue)
     (push-value myQueue C)
     (push-value myQueue D)
     (pop-value myQueue)
   )
