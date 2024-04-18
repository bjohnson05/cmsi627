;;; CLIPS Website
;;; clipsrules.net

;;; CLIPS on SourceForge
;;; sourceforge.net/projects/clipsrules/

;;; Adventures in Rule-Based Programming: A CLIPS Tutorial
;;; clipsrules.net/airbp

;;; This CLIPS program demonstrates general techniques for implementing 
;;; RPG character generation using a rule-based programming language. 
;;; This uses an alternate approach to that of engarde.clp in implementing
;;; the character generation of the En Garde! RPG. In this version, the 
;;; tables are incorporated as part of the rules rather than stored within
;;; facts.
;;;
;;; En Garde! Rules
;;; Copyright 1975 Game Designers' Workshop

;;; Sample Run 
;;;
;;; CLIPS> (load engarde.clp)
;;; :::!!!%%%%%$$************************$
;;; TRUE
;;; CLIPS> (reset)
;;; CLIPS> (run)
;;; Strength: 15
;;; Expertise: 14
;;; Constitution: 11
;;; Endurance: 165
;;; Class: Nobleman
;;; Sibling Rank: Second Son
;;; Father's Position: Wealthy
;;; Father's Title: Baron
;;; Orphan: No
;;; Initial Funds: 500
;;; Allowance: 100
;;; Social Status: 7
;;; CLIPS> 

;;;
;;; Defglobals
;;;

(defglobal ?*verbose* = FALSE 
           ?*high* = 10
           ?*low* = -10)

;;;
;;; Deffunctions
;;;

(deffunction roll-die (?sides)
   (+ 1 (mod (random) ?sides))) 

(deffunction roll-#D# (?number ?sides)
   (bind ?sum 0)
   (loop-for-count ?number
      (bind ?sum (+ ?sum (roll-die ?sides))))
   ?sum)
   
(deffunction verbose ($?args)
   (if ?*verbose*
      then
      (println (expand$ ?args))))
            
;;;
;;; Deftemplates
;;;

(deftemplate attribute
   (slot name)
   (slot type (default unspecified))
   (slot value))
   
(deftemplate list
   (slot name)
   (multislot values))
    
(deftemplate roll
   (multislot name)
   (slot type (default unspecified))
   (slot # (default 1))
   (slot sides (default 6))
   (slot roll (default TBD))
   (slot modifier (default 0)))
   
(deftemplate test-roll
   (multislot name)
   (multislot rolls))
   
(deftemplate modifier
   (slot name)
   (slot operator)
   (slot value))

;;;
;;; Deffacts
;;;

(deffacts rolls
   (roll (name "Strength") (type ability) (# 3) (sides 6))
   (roll (name "Expertise") (type ability) (# 3) (sides 6))
   (roll (name "Constitution") (type ability) (# 3) (sides 6))
   (roll (name "Birth Table A") (type table) (# 1) (sides 6))
   (roll (name "Birth Table B") (type table) (# 1) (sides 6))
   (roll (name "Birth Table C") (type table) (# 1) (sides 6)))

(deffacts lists
   (list (name "Display")
         (values "Strength" "Expertise" "Constitution" "Endurance" "Class" "Sibling Rank" 
                 "Father's Position" "Father's Title" "Orphan" "Initial Funds"
                 "Allowance" "Inheritance" "Social Level" "Title")))

;;;
;;; Dice Rolling
;;;

(defrule do-roll "using random numbers"
   ?r <- (roll (name ?name) (# ?n) (sides ?s) (roll TBD))
   (not (test-roll (name ?name) (rolls ? $?)))
   =>
   (bind ?roll (roll-#D# ?n ?s))
   (verbose "Rolling " (sym-cat ?n D ?s) " for " ?name ": " ?roll ".")
   (modify ?r (roll ?roll)))

(defrule do-roll-test "using predefined roll for testing"
   ?r <- (roll (name ?name) (# ?n) (sides ?s) (roll TBD))
   ?tr <- (test-roll (name ?name) (rolls ?roll $?rest))
   =>
   (verbose "Rolling " (sym-cat ?n D ?s) " for " ?name ": " ?roll ".")
   (modify ?r (roll ?roll))
   (modify ?tr (rolls ?rest)))

;;;
;;; Attributes
;;;

(defrule ability-got-roll
   ?r <- (roll (name ?attribute) (type ability) (roll ?roll&~TBD))
   =>
   (retract ?r)
   (assert (attribute (name ?attribute)
                      (type ability)
                      (value ?roll))))

(defrule compute-endurance
   (attribute (name "Strength") (value ?str))
   (attribute (name "Constitution") (value ?con))
   =>
   (assert (attribute (name "Endurance")
                      (type ability)
                      (value (* ?str ?con)))))

;;;
;;; Birth Tables
;;;

(defrule birth-table-A
   ?r <- (roll (name "Birth Table A") (roll ?roll&~TBD))
   =>
   (retract ?r)
   (bind ?values (create$ "Commoner" "Commoner" "Gentleman" "Gentleman" "Nobleman" "Nobleman"))
   (assert (attribute (name "Class") (type status) (value (nth$ ?roll ?values)))))

(defrule birth-table-B
   ?r <- (roll (name "Birth Table B") (roll ?roll&~TBD))
   =>
   (retract ?r)
   (bind ?values (create$ "First Son" "Second Son" "Second Son" "Second Son" "Bastard" "Bastard"))
   (assert (attribute (name "Sibling Rank") (type status) (value (nth$ ?roll ?values)))))
   
(defrule is-orphan-check-needed
   (attribute (name "Sibling Rank") (value ?value))
   =>
   (if (eq ?value "First Son")
      then (assert (roll (name "Orphan") (type table) (# 1) (sides 6)))
      else (assert (attribute (name "Orphan") (type status) (value No)))))
   
(defrule first-son-check-orphan-roll
   ?r <- (roll (name "Orphan") (roll ?roll&~TBD))
   =>
   (retract ?r)
   (bind ?values (create$ Yes No No No No No))
   (assert (attribute (name "Orphan") (type status) (value (nth$ ?roll ?values)))))

(defrule is-title-check-needed
   (attribute (name "Class") (value "Nobleman"))
   =>
   (assert (roll (name "Birth Table D") (type table) (# 1) (sides 6))))

(defrule birth-table-C-commoner
   (attribute (name "Class") (value "Commoner"))
   =>
   (assert (list (name "Father's Position")
                 (values "Peasant" "Peasant" "Small Merchant" 
                         "Merchant" "Wealthy Merchant" "Very Wealthy Merchant")))
   (assert (list (name "Initial Funds") (values 10  10   25  150   250   500))
           (list (name "Allowance")     (values  0   0    5   20    50   100))
           (list (name "Inheritance")   (values  0   0  100  750  1000  4000))))
      
(defrule birth-table-C-gentleman
   (attribute (name "Class") (value "Gentleman"))
   =>
   (assert (list (name "Father's Position")
                 (values "Impoverished" "Impoverished" "Well-to-do" 
                         "Well-to-do" "Wealthy" "Very Wealthy")))
   (assert (list (name "Initial Funds") (values  40   40   250   250   500   750))
           (list (name "Allowance")     (values   0    0    50    50   100   125))
           (list (name "Inheritance")   (values 100  100  1500  1500  4000  5000))))

(defrule birth-table-C-nobleman
   (attribute (name "Class") (value "Nobleman"))
   =>
   (assert (list (name "Father's Position")
                 (values "Impoverished" "Impoverished" "Well-to-do" 
                         "Wealthy" "Very Wealthy" "Very Wealthy")))
   (assert (list (name "Initial Funds") (values  40   40   250   500   750   750))
           (list (name "Allowance")     (values   0    0    50   100   125   125))
           (list (name "Inheritance")   (values 100  100  1500  4000  5000  5000))))

(defrule birth-table-C-apply
   (list (name "Father's Position") (values $?position))
   (list (name "Initial Funds") (values $?initial))
   (list (name "Allowance") (values $?allow))
   (list (name "Inheritance") (values $?inherit))
   ?r <- (roll (name "Birth Table C") (roll ?roll&~TBD))
   (attribute (name "Orphan") (value ?orphan))
   =>
   (retract ?r)
   (assert (attribute (name "Father's Position") (type status) (value (nth$ ?roll ?position))))
   (switch ?orphan
      (case Yes then
         (assert (attribute (name "Inheritance") (type funds) (value (nth$ ?roll ?inherit)))))
      (case No then
         (assert (attribute (name "Initial Funds") (type funds) (value (nth$ ?roll ?initial))))
         (assert (attribute (name "Allowance") (type funds) (value (nth$ ?roll ?allow)))))))

(defrule birth-table-D
   ?r <- (roll (name "Birth Table D") (roll ?roll&~TBD))
   =>
   (retract ?r)
   (bind ?titles (create$ "Knight" "Baron" "Marquis" "Earl" "Viscount" "Count"))
   (bind ?social-levels (create$ 6 7 8 9 10 11))
   (assert (attribute (name "Father's Title") (type status) (value (nth$ ?roll ?titles)))
           (attribute (name "Social Level") (type status) (value (nth$ ?roll ?social-levels)))))

;;;
;;; Social Levels
;;;

(defrule initial-social-level-commoner-peasant
   (attribute (name "Class") (value "Commoner"))
   (attribute (name "Father's Position") (value "Peasant"))
   =>
   (assert (attribute (name "Social Level") (type status) (value 2))))

(defrule initial-social-level-commoner-merchant
   (attribute (name "Class") (value "Commoner"))
   (attribute (name "Father's Position") (value ~"Peasant"))
   =>
   (assert (attribute (name "Social Level") (type status) (value 3))))

(defrule initial-social-level-gentleman-not-very-wealthy
   (attribute (name "Class") (value "Gentleman"))
   (attribute (name "Father's Position") (value ~"Very Wealthy"))
   =>
   (assert (attribute (name "Social Level") (type status) (value 4))))

(defrule initial-social-level-gentleman-very-wealthy
   (attribute (name "Class") (value "Gentleman"))
   (attribute (name "Father's Position") (value "Very Wealthy"))
   =>
   (assert (attribute (name "Social Level") (type status) (value 5))))

;;;
;;; Determine Modifiers
;;;

(defrule title-inheritance
   (attribute (name "Orphan") (value Yes))
   (attribute (name "Father's Title") (value ?title))
   =>
   (assert (attribute (name "Title") (type status) (value ?title)))
   (assert (modifier (name "Social Level") (operator +) (value 3))))
   
(defrule social-status-first-son
   (attribute (name "Sibling Rank") (value "First Son"))
   =>
   (assert (modifier (name "Initial Funds") (operator *) (value 1.1))
           (modifier (name "Allowance") (operator *) (value 1.1))
           (modifier (name "Social Level") (operator +) (value 1))))

(defrule social-status-bastard
   (attribute (name "Sibling Rank") (value "Bastard"))
   =>
   (assert (modifier (name "Initial Funds") (operator *) (value 0.9))
           (modifier (name "Allowance") (operator *) (value 0.9))
           (modifier (name "Social Level") (operator +) (value -1))))

;;;            
;;; Apply Modifiers
;;;

(defrule modifier-apply
   ?m <- (modifier (name ?attribute)
                   (operator ?op)
                   (value ?mod))
   ?a <- (attribute (name ?attribute)
                    (value ?value))
   =>
   (retract ?m)
   (modify ?a (value (round (funcall ?op ?value ?mod)))))

;;;
;;; Display
;;;

(defrule display-attribute-found
   (declare (salience ?*low*))
   ?l <- (list (name "Display")
               (values ?attribute $?rest))
   (attribute (name ?attribute)
              (value ?value))
   =>
   (modify ?l (values ?rest))
   (println ?attribute ": " ?value))
   
(defrule display-attribute-not-found
   (declare (salience ?*low*))
   ?l <- (list (name "Display")
               (values ?attribute $?rest))
   (not (attribute (name ?attribute)))
   =>
   (modify ?l (values ?rest)))
         
;;; 
;;; Testing Data
;;;

(deffacts test-rolls
;;;    (test-roll (name "Strength")
;;;               (rolls 15))
;;;    (test-roll (name "Expertise")
;;;               (rolls 14))
;;;    (test-roll (name "Constitution")
;;;               (rolls 11))
;;;    (test-roll (name "Birth Table A")
;;;               (rolls 5))
;;;    (test-roll (name "Birth Table B")
;;;               (rolls 3))
;;;    (test-roll (name "Orphan")
;;;               (rolls 2))
;;;    (test-roll (name "Birth Table C")
;;;               (rolls 4))
;;;    (test-roll (name "Birth Table D")
;;;               (rolls 2))
)
