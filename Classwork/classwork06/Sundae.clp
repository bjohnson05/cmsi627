;;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;;  File name  : Sundae.clp
;;;  Purpose    : This CLIPS source file builds a banana split and says
;;;                it's time for dessert.
;;;  Project    : CMSI 682
;;;  Date       : 13-Feb-2003
;;;  Author     : B.J. Johnson
;;;  Description: This file is an exercise in rule building and firing with
;;;                assertions.
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
;;;  Define a rule to build the banana split and output the message
;;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(defrule treat "Say if dessert is built"
    (have-some banana)
    (have-some icecream)
    (have-some hotfudge)
    (have-some whippedcream)
    (have-some nuts)
    (have-some dish)
   =>
    (retract *)
    (assert (have-some slicedbanana))
    (assert (dish-contains slicedbanana
             icecream hotfudge whippedcream nuts))
    (printout t "\"Time for dessert!\" I say." crlf)
)
