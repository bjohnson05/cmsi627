;;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;;  File name  : Stack.bat
;;;  Purpose    : This CLIPS batch file  runs the "StackTest.clp"
;;;                program
;;;  Project    : CMSI 627
;;;  Date       : 2024-03-03
;;;  Author     : Dr. Johnson
;;;  Description: Rules and facts are in "Stack.clp" and results are
;;;                written to dribble file "Stack.drb".
;;;
;;;  Operation  : This source file is intended to be run from the batch
;;;                file with the corresponding name.  To do this, in
;;;                the CLIPS environment, use the command:
;;;
;;;                   (batch Stack.bat)
;;;
;;;               It is assumed that all files to be tested will be in
;;;                on the current drive in the current logged folder.
;;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

;;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;;  Turn on the dribble output, clear the CLIPS environment and load
;;;   the file
;;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   (dribble-on Stack.drb)
   (clear)
   (load Stack.clp)
   (load StackTest.clp)

;;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;;  Reset, then run it.
;;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   (reset)
   (assert (start))
   (facts)
   (rules)
   (agenda)
   (run)

;;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;;  Turn off the dribble output
;;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   (facts)
   (rules)
   (agenda)
   (dribble-off)

