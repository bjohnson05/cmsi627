;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;;  File name  : Plants.bat
;;;  Author     : B.J. Johnson
;;;  Class      : CMSI 682
;;;  Date       : 11-Feb-2003
;;;  Purpose    : This CLIPS batch file contains commands needed to
;;;                test "plants.clp" function for G&R book problem 7.9
;;;
;;;  Description: Rules and facts are in Plants.clp and results are
;;;                written to dribble file Plants.drb.  This output
;;;                file will then be copied and edited to produce the
;;;                annotated dribble file "Plants.adrb" to submit for
;;;                grade.
;;;
;;;  Operation  : It is assumed that all files to be tested will be
;;;                on the A: drive (floppy) in the root directory.     
;;;                The program must be run from the CLIPS environment.
;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;;  Revision History:
;;;  -----------------
;;;
;;;   Ver      Date      Modified by:  Description
;;;  -----  -----------  ------------  ---------------------------------
;;;  1.0.0  11-Feb-2003  B.J. Johnson  Initial release
;;;
;;;
;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;;  Turn on the dribble output
;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(dribble-on Plants.drb)

;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;;  Clear the environment, then load and test the program with valid
;;;   values for "nitrogen"
;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(clear)
(load Plants.clp)
(reset)
(assert (growth stunted))
(assert (color pale-yellow))
(assert (leafEdges reddish-brown))
(run)

;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;;  Clear the environment, then re-load and test the program with
;;;   valid values for "phosphorus"
;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(clear)
(load Plants.clp)
(reset)
(assert (root-growth stunted))
(assert (color purplish))
(assert (stalk spindly))
(assert (maturing delayed))
(run)

;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;;  Clear the environment, then re-load and test the program with
;;;   valid values for "potassium"
;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(clear)
(load Plants.clp)
(reset)
(assert (leaf-edges scorched))
(assert (color purplish))
(assert (seeds shriveled))
(assert (fruit shriveled))
(run)

;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;;  Clear the environment, then re-load and test the program with
;;;   invalid values to show that it rejects them
;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(clear)
(load Plants.clp)
(reset)
(assert (leaf-edges normal))
(assert (color green))
(assert (seeds solid))
(assert (fruit plump-and-juicy))
(run)

;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;;  Turn off the dribble output
;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(dribble-off)

