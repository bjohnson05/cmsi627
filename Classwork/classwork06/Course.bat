;;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;;  File name  : Course.bat
;;;  Purpose    : This CLIPS source file loads the program file named
;;;                "Course.clp" and executes it.
;;;  Project    : CMSI 682
;;;  Date       : 11-Feb-2003
;;;  Author     : B.J. Johnson
;;;  Description: Rules and facts are in "Course.clp" and results are
;;;              written to dribble file "Course.drb".  This output
;;;              file may then be copied and edited to produce the
;;;              annotated dribble file "Course.adrb" to submit for
;;;              grade.
;;;
;;;  Operation  : The source file is intended to be run from the batch
;;;                file with the corresponding name.  To do this, in
;;;                the CLIPS environment, use the command:
;;;
;;;                   (batch Course.bat)
;;;
;;;               It is assumed that all files to be tested will be in
;;;                a folder called "SourceCode".  This will be on the
;;;                current logged drive for the environment.
;;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;;  Revision History:
;;;  -----------------
;;;
;;;   Ver      Date      Modified by:  Description
;;;  -----  -----------  ------------  ---------------------------------
;;;  1.0.0  13-Feb-2003  B.J. Johnson  Initial release
;;;
;;;
;;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

;;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;;  Turn on the dribble output
;;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(dribble-on Course.drb)

(clear)
(load Course.clp)
(reset)
(assert (course cmsi 682))
(facts)
(run)
(reset)
(retract *)
(assert (course cmsi 587))
(run)

(dribble-off)

