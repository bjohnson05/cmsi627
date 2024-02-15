;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;;  File name  : Plants.clp
;;;  Purpose    : This CLIPS source file will determine what type of
;;;                fertilizer is needed for a plant, given specific
;;;                symptoms.
;;;  Project    : CMSI 682
;;;  Date       : 13-Feb-2003
;;;  Author     : B.J. Johnson
;;;  Description: This program contains a set of rules to determine if a
;;;                plant needs nitrogen, potassium, or phosphorus.  The
;;;                decision is based on the followint criteria:
;;;
;;;      Stunted growth may mean a nitrogen deficiency.
;;;      Pale yellow in color may mean a nitrogen deficiency.
;;;      Reddish-brown leaf edges may mean a nitrogen deficiency.
;;;      Stunted root growth ay mean a phosphorus deficiency.
;;;      A spindly stalk may mean a phosphorus deficiency.
;;;      Purplish in color may mean a phosphorus deficiency.
;;;      Delayed in maturing may mean a phosphorus deficiency.
;;;      Leaf edges that appear scorched may mean a potassium deficiency.
;;;      Weakened stems may mean a potassium deficiency.
;;;      Shriveled seeds or fruits may mean a potassium deficiency.
;;;
;;;  Operation  : This source file is intended to be run from the batch
;;;                file with the corresponding name.  To do this, in
;;;                the CLIPS environment, use the command:
;;;
;;;                   (batch plants.bat)
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
;;;  1.0.0  13-Feb-2003  B.J. Johnson  Initial release
;;;
;;;
;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;;  Define a rule to check for nitrogen deficiency
;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(defrule check-nitrogen "Check for nitrogen deficiency"
    (and (growth stunted)
         (color pale-yellow)
         (leafEdges reddish-brown)
    )
   =>
    (assert (remedy nitrogen))
)

;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;;  Define a rule to check for phosphorus deficiency
;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(defrule check-phosphorus "Check for phosphorus deficiency"
    (and (root-growth stunted)
         (color purplish)
         (stalk spindly)
         (maturing delayed)
    )
   =>
    (assert (remedy phosphorus))
)

;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;;  Define a rule to check for potassium deficiency
;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(defrule check-potassium "Check for potassium deficiency"
    (and (leaf-edges scorched)
         (color purplish)
         (seeds shriveled)
         (fruit shriveled)
    )
   =>
    (assert (remedy potassium))
)

;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;;  Define a rule to print the result
;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(defrule print-remedy "Output the remedy for the plant"
    (remedy ?remedy)
   =>
    (printout t crlf crlf "Your plant needs some " ?remedy crlf crlf crlf)
)