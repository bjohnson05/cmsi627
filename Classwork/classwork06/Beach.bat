;;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;;  File name  : Beach.bat
;;;  Purpose    : This CLIPS batch file loads and executes the "Beach.clp"
;;;                source file
;;;  Project    : CMSI 682
;;;  Date       : 13-Feb-2003
;;;  Author     : B.J. Johnson
;;;  Description: Rules and facts are in "Beach.clp and results are
;;;                written to dribble file "Beach.drb".  This output
;;;                file may then be copied and edited to produce the
;;;                annotated dribble file "Beach.adrb" to submit for
;;;                grade.
;;;
;;;               Rules are tested with working assertions, then are re-
;;;                tested with non-working assertions.
;;;
;;;  Operation  : This source file is intended to be run from the batch
;;;                file with the corresponding name.  To do this, in
;;;                the CLIPS environment, use the command:
;;;
;;;                   (batch Beach.bat)
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
(dribble-on Beach.drb)

(clear)
(unwatch all)
(watch facts)
(watch rules)

;;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;;  Load the file, then test with working assertions
;;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(load Beach.clp)
(reset)
(assert (weather-is warm))
(assert (sky-is blue))
(run)

;;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;;  Reset, then test with non-working assertions
;;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(reset)
(assert (weather-is chilly))
(assert (sky-is blue))
(run)

(reset)
(assert (weather-is warm))
(assert (sky-is overcast))
(run)

(reset)
(assert (weather-is chilly))
(assert (sky-is overcast))
(run)

;;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;;  Kill the dribble
;;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(dribble-off)

