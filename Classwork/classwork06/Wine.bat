;;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;;  File name  : Wine.bat
;;;  Purpose    : This CLIPS source file will run the CLIPS source file
;;;                "Wine.clp" and capture the output to a dribble file.
;;;  Project    : CMSI 682
;;;  Date       : 11-Feb-2003
;;;  Author     : B.J. Johnson
;;;  Description: Rules and facts are in "Wine.clp" and results are
;;;              written to dribble file "Wine.drb".  This output
;;;              file may then be copied and edited to produce the
;;;              annotated dribble file "Wine.adrb" to submit for
;;;              grade.
;;;
;;;  Operation  : This source file is intended to be run from the batch
;;;                file with the corresponding name.  To do this, in
;;;                the CLIPS environment, use the command:
;;;
;;;                   (batch Wine.bat)
;;;
;;;                or the source file can be run stand-alone from the
;;;                CLIPS environment with the (load) command.
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
(dribble-on Wine.drb)

(clear)
(unwatch all)
(load Wine.clp)
(reset)
(run)

(dribble-off)

