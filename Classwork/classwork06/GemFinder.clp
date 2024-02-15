;;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;;  File name  : GemFinder.clp
;;;  Purpose    : This CLIPS source file runs a program to determine if
;;;                the parameters entered by the operator are those of
;;;                the gem chyrsoberyl.
;;;  Project    : CMSI 682
;;;  Date       : 14-Feb-2003
;;;  Author     : B.J. Johnson
;;;  Description: This program is just a simple question-and-answer
;;;                session, which will tell the type of gem based on the
;;;                three parameters entered.  See the G&R text, problem
;;;                7.14, page 364 for values.  The problem is looking for
;;;                the gem "chyrsoberyl", which has a hardness of 8.5, a
;;;                density of 3.6, and possible colors of yellow, brown,
;;;                or green.
;;;
;;;  Operation  : This source file is intended to be run from the batch
;;;                file with the corresponding name.  To do this, in
;;;                the CLIPS environment, use the command:
;;;
;;;                   (batch GemFinder.bat)
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
;;;  1.0.0  14-Feb-2003  B.J. Johnson  Initial release
;;;
;;;
;;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

;;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;;  Define a template for a gem, containing slots for its hardness,
;;;   density, and color attributes.
;;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   (deftemplate gemStone "A template for a gem stone"
      (slot name)
      (slot hardness)
      (slot density)
      (multislot colors)
   )

;;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;;  Define a list of gems, containing the appropriate attribute data
;;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   (deffacts table-of-gems "A table of gem stones and their attributes"
      (gemStone (name     diamond)
                (hardness 10.0)
                (density   3.52)
                (colors   yellow brown green blue white colorless)
      )
      (gemStone (name     corundum)
                (hardness 9.0)
                (density  4.0)
                (colors   red pink yellow brown green blue
                           violet black white colorless)
      )
      (gemStone (name     chrysoberyl)
                (hardness 8.5)
                (density  3.72)
                (colors   yellow brown green)
      )
      (gemStone (name     spinel)
                (hardness 8.0)
                (density  3.6)
                (colors   red pink yellow brown green blue
                           violet white colorless)
      )
      (gemStone (name     topaz)
                (hardness 8.0)
                (density  3.52)
                (colors   red pink yellow brown blue
                           violet white colorless)
      )
      (gemStone (name     beryl)
                (hardness 7.5)
                (density  2.7)
                (colors   red pink yellow brown blue
                           violet white colorless)
      )
      (gemStone (name     zircon)
                (hardness 7.0)
                (density  4.7)
                (colors   yellow brown green violet white colorless)
      )
      (gemStone (name     quartz)
                (hardness 7.0)
                (density  2.65)
                (colors   red pink green blue violet
                           white black colorless)
      )
      (gemStone (name     tourmaline)
                (hardness 7.0)
                (density  3.1)
                (colors   red pink yellow brown green
                           blue white black colorless)
      )
      (gemStone (name     peridot)
                (hardness 6.5)
                (density  3.3)
                (colors   yellow brown green)
      )
      (gemStone (name     jadeite)
                (hardness 7.5)
                (density  2.7)
                (colors   red pink yellow brown green blue
                           violet white black colorless)
      )
      (gemStone (name     opal)
                (hardness 5.5)
                (density  2.1)
                (colors   red pink yellow brown white black colorless)
      )
      (gemStone (name     nephrite)
                (hardness 6.0)
                (density  2.9)
                (colors   green white black colorless)
      )
      (gemStone (name     turquoise)
                (hardness 6.0)
                (density  2.7)
                (colors   blue)
      )
   )

;;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;;  Define a rule to determine the color requirement from the user
;;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   (defrule get-color "Ask the user for the gem color value"
       (not (color ?))
      =>
       (printout t "What color is the gem? " crlf
                  "(red, pink, yellow, brown, green, blue" crlf
                  "  violet, white, black, or colorless)" crlf
                  "  [Enter] =>")
       (assert (color (read)))
   )

;;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;;  Define a rule to determine the hardness requirement from the user
;;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   (defrule get-hardness "Ask the user for the gem hardness value"
      =>
       (printout t "What is the hardness of the gem being considered? ")
       (assert (hardness (read)))
   )

;;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;;  Define a rule to determine the density requirement from the user
;;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   (defrule get-density "Ask the user for the gem density value"
      =>
       (printout t "What is the density of the gem being considered? ")
       (assert (density (read)))
   )

;;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;;  Define a rule to throw out colors that aren't in the list, so the
;;;   user will have to enter something valid
;;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   (defrule bad-color-entry "Ditch bogus color entries"
       ?f <- (color ~red & ~pink & ~yellow & ~brown & ~green &
                    ~blue & ~violet & ~white & ~black & ~colorless)
      =>
       (retract ?f)
   )

;;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;;  Define a rule to output the result of the search
;;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   (defrule print-results "Output the selected gem"
       (hardness ?hardness)
       (density  ?density)
       (color    ?color)
       (gemStone (name     ?name)
                 (hardness ?hardness)
                 (density  ?density)
                 (colors   $? ?color $?)
       )
      =>
       (printout t crlf crlf)
       (printout t "The gem is a " ?name " stone.")
       (printout t crlf crlf crlf)
   )
