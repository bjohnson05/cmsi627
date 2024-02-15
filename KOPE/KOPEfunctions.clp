;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;;  File name  : KOPEfunctions.clp
;;;  Purpose    : This CLIPS source file contains functions for the
;;;                Knowledge-based On-line Psychological Evaluator
;;;                program.
;;;  Project    : CMSI 682
;;;  Date       : 14-Feb-2003
;;;  Author     : B.J. Johnson
;;;  Description: This file contains functions to be used in the KOPE
;;;                project.  These functions will be available to the
;;;                other parts of the project by loading this file in
;;;                the CLIPS environment.
;;;
;;;  Operation  : This source file is intended to be loaded by a batch
;;;                file named "KOPE.bat".  To run this program, from
;;;                the CLIPS environment, use the command:
;;;
;;;                   (batch kope.bat)
;;;
;;;               Alternatively, the user may run the single file, by
;;;                using the "load" command in CLIPS.  However, since
;;;                the program is only completely functional if all
;;;                modules are loaded, this method is not recommended
;;;                unless specific module testing is being performed.
;;;
;;;               It is assumed that all files will be in a directory
;;;                folder called "SourceCode".  This will be on the
;;;                current logged drive for the environment.
;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;;  Revision History:
;;;  -----------------
;;;
;;;   Ver      Date      Modified by:  Description
;;;  -----  -----------  ------------  ---------------------------------
;;;  1.0.0  23-Feb-2003  B.J. Johnson  Initial release
;;;
;;;
;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;;  TEMPLATE DEFINITION AREA
;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;;   None

;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;;  FACTS DEFINITION AREA
;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;;   None

;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;;  FUNCTION DEFINITION AREA
;;;  Define a function to ask a question and return the response.  The
;;;   question is passed in as a parameter, along with a list of legal
;;;   values to choose from.  Only the valid responses are allowed.
;;;   Invalid responses are responded to by repeating the question,
;;;   ignoring the invalid response.
;;;  NOTE: a side-effect of this function is that the response is
;;;   converted to lower case.  This is good for KOPE processing, but
;;;   may cause problems with re-use, due to the strict CLIPS case
;;;   sensitivity.
;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   (deffunction askQuestion (?question $?allowed-values)
      (printout t  crlf ?question)
      (bind ?answer (read))
      (if (lexemep ?answer)
         then (bind ?answer (lowcase ?answer))
      )
      (while (not (member ?answer ?allowed-values)) do
         (printout t crlf ?question)
         (bind ?answer (read))
         (if (lexemep ?answer)
            then (bind ?answer (lowcase ?answer))
         )
      )
      ?answer
   )

;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;;  RULES DEFINITION AREA
;;;  Define a rule to output the "hello" message
;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;;   None

;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;;  End of file
;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
