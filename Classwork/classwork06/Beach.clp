;;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;;  File name  : Beach.clp
;;;  Purpose    : This CLIPS source file contains a rule to say if it is
;;;                a good day for the beach.  The weather must be warm,
;;;                and the sky must be blue.
;;;  Project    : CMSI 682
;;;  Date       : 13-Feb-2003
;;;  Author     : B.J. Johnson
;;;  Description: See the purpose
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
;;;  Define a rule to output the "beach" message
;;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   (defrule beach-day "Say if it's a good beach day"
       (weather-is warm)
       (sky-is blue)
      =>
       (printout t "It's a good day for the beach!" crlf)
   )
   (defrule beach-day2 "Say if it's OK for the beach"
      (weather-is chilly)
      (sky-is overcast)
     =>
      (printout t "Wear a sweater to the beach!" crlf)
   )
