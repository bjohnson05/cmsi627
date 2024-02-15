;;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;;  File name  : Sundae.bat
;;;  Purpose    : This CLIPS batch file loads and runs the "Sundae.clp"
;;;                program
;;;  Project    : CMSI 682
;;;  Date       : 13-Feb-2003
;;;  Author     : B.J. Johnson
;;;  Description: Rules and facts are in "Sundae.clp" and results are
;;;              written to dribble file "Sundae.drb".  This output
;;;              file may then be copied and edited to produce the
;;;              annotated dribble file "Sundae.adrb" to submit for
;;;              grade.
;;;
;;;  Operation  : This source file is intended to be run from the batch
;;;                file with the corresponding name.  To do this, in
;;;                the CLIPS environment, use the command:
;;;
;;;                   (batch Sundae.bat)
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
;;;  Turn on the dribble output, clear the CLIPS environment and load
;;;   the file
;;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(dribble-on Sundae.drb)
(clear)
(load Sundae.clp)

;;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;;  Reset, then assert the ingredients for the sundae and run it.
;;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(reset)
(assert (have-some banana))
(assert (have-some icecream))
(assert (have-some hotfudge))
(assert (have-some whippedcream))
(assert (have-some nuts))
(assert (have-some dish))
(run)

(dribble-off)

