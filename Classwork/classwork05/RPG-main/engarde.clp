;;; CLIPS Website
;;; clipsrules.net

;;; CLIPS on SourceForge
;;; sourceforge.net/projects/clipsrules/

;;; Adventures in Rule-Based Programming: A CLIPS Tutorial
;;; clipsrules.net/airbp

;;; This CLIPS program demonstrates general techniques for implementing 
;;; RPG character generation using a rule-based programming language. 
;;; The first half of the code is a general framework for attribute 
;;; generation while the second half of the code implements tables and
;;; rules specific to the En Garde! RPG.
;;;
;;; En Garde! Rules
;;; Copyright 1975 Game Designers' Workshop

;;; Sample Run 
;;;
;;; CLIPS> (load engarde.clp)
;;; :::!!!!!%%%%%%%%$**************$$$$$****
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
 
(deffunction expand-roll (?roll)
   (bind ?roll (upcase (str-cat ?roll)))
   (bind ?roll (str-replace ?roll "D" " D "))
   (bind ?roll (explode$ ?roll))
   ?roll)
   
(deffunction row$ ($?args)
   (implode$ ?args))

(deffunction verbose ($?args)
   (if ?*verbose*
      then
      (println (expand$ ?args))))
      
;;;
;;; Deftemplates
;;;

(deftemplate attribute
   (slot name)
   (slot value))
   
(deftemplate list
   (slot name)
   (multislot values))
   
(deftemplate table
   (slot name)
   (multislot prerequisite-attribute)
   (multislot prerequisite-value)
   (slot dice)
   (slot columns)
   (multislot rows))
 
(deftemplate roll
   (multislot name)
   (multislot roll))
   
(deftemplate test-roll
   (multislot name)
   (multislot rolls))

(deftemplate modifier
   (multislot prerequisite-attribute)
   (multislot prerequisite-value)
   (multislot target-attribute)
   (slot operation (allowed-values * +))
   (slot value))

(deftemplate roll-attribute 
   (slot name)
   (slot dice))
   
(deftemplate compute
   (slot name)
   (multislot expression))

;;;
;;; Deffacts
;;;

(deffacts operators
   (list (name "Operators")
         (values + - * / div)))

;;;            
;;; Modifiers
;;;

(defrule modifier-apply
   ?m <- (modifier (operation ?op)
                   (target-attribute ?target $?rest)
                   (value ?mod)
                   (prerequisite-attribute)
                   (prerequisite-value))
   ?a <- (attribute (name ?target)
                    (value ?value))
   =>
   (modify ?a (value (round (funcall ?op ?value ?mod))))
   (modify ?m (target-attribute ?rest)))

(defrule modifier-prerequisite-satisfied
   ?m <- (modifier (prerequisite-attribute ?a $?arest)
                   (prerequisite-value ?v $?vrest))
   (attribute (name ?a)
              (value ?v))
   =>
   (modify ?m (prerequisite-attribute ?arest)
              (prerequisite-value ?vrest)))

;;;            
;;; Tables
;;;

(defrule table-need-roll
   (table (name ?table)
          (prerequisite-attribute)
          (prerequisite-value)
          (dice ?roll))
   =>
   (assert (roll (name ?table) 
                 (roll (expand-roll ?roll)))))

(defrule table-got-roll
   (table (name ?table)
          (prerequisite-attribute)
          (prerequisite-value)
          (columns ?columns)
          (rows $?rows))
   ?r <- (roll (name ?table) (roll ?roll))
   =>
   (retract ?r)
   (bind ?columns (explode$ ?columns))
   (bind ?row (explode$ (nth$ ?roll ?rows)))
   (foreach ?c ?columns
      (assert (attribute (name ?c)
                         (value (nth$ ?c-index ?row))))))

(defrule table-prerequisite-satisfied
   ?t <- (table (prerequisite-attribute ?a $?arest)
                (prerequisite-value ?v $?vrest))
   (attribute (name ?a)
              (value ?v))
   =>
   (modify ?t (prerequisite-attribute ?arest)
              (prerequisite-value ?vrest)))

;;;
;;; Dice Rolling
;;;

(defrule do-roll "using random numbers"
   ?r <- (roll (name ?name) (roll ?n D ?s))
   (not (test-roll (name ?name) (rolls ? $?)))
   =>
   (bind ?roll (roll-#D# ?n ?s))
   (verbose "Rolling " (sym-cat ?n D ?s) " for " ?name ": " ?roll ".")
   (modify ?r (roll ?roll)))

(defrule do-roll-test "using predefined roll for testing"
   ?r <- (roll (name ?name) (roll ?n D ?s))
   ?tr <- (test-roll (name ?name) (rolls ?roll $?rest))
   =>
   (verbose "Rolling " (sym-cat ?n D ?s) " for " ?name ": " ?roll ".")
   (modify ?r (roll ?roll))
   (modify ?tr (rolls ?rest)))

;;;
;;; Roll Attributes
;;;

(defrule attribute-need-roll
   (roll-attribute (name ?attribute)
                   (dice ?roll))
   =>
   (assert (roll (name ?attribute) 
                 (roll (expand-roll ?roll)))))

(defrule attribute-got-roll
   (roll-attribute (name ?attribute))
   ?r <- (roll (name ?attribute) (roll ?roll))
   =>
   (retract ?r)
   (assert (attribute (name ?attribute)
                      (value ?roll))))
                      
;;;
;;; Compute
;;;
            
(defrule compute-substitute
   ?c <- (compute (expression $?b ?attribute $?e))
   (attribute (name ?attribute) (value ?value))
   =>
   (modify ?c (expression ?b ?value ?e)))
   
(defrule compute-evaluate "Reverse Polish Notation"
   ?c <- (compute (expression $?b ?n1&:(numberp ?n1) ?n2&:(numberp ?n2) ?operator $?e))
   (list (name "Operators") (values $? ?operator $?)) 
   =>
   (modify ?c (expression ?b (funcall ?operator ?n1 ?n2) ?e)))

(defrule compute-assign
   (compute (name ?name)
            (expression ?value))
   =>
   (assert (attribute (name ?name) (value ?value))))

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
;;; En Garde! Deffacts
;;;

(deffacts attribute-rolls
   (roll-attribute (name "Strength") (dice 3D6))
   (roll-attribute (name "Expertise") (dice 3D6))
   (roll-attribute (name "Constitution") (dice 3D6)))

(deffacts computations
   (compute (name "Endurance")
            (expression "Strength" "Constitution" *)))

(deffacts tables
   (table 
      (name "Birth Table A")
      (dice 1D6)
      (columns (row$ "Class"))
               ;--------------
      (rows    (row$ "Commoner")
               (row$ "Commoner")
               (row$ "Gentleman")
               (row$ "Gentleman")
               (row$ "Nobleman")            
               (row$ "Nobleman")))  
   (table 
      (name "Birth Table B")
      (dice 1D6)
      (columns (row$ "Sibling Rank"))
               ;---------------------
      (rows    (row$ "First Son")
               (row$ "Second Son")
               (row$ "Second Son")
               (row$ "Second Son")
               (row$ "Bastard")            
               (row$ "Bastard")))             
   (table 
      (name "Birth Table C")
      (prerequisite-attribute "Class")
      (prerequisite-value "Commoner")
      (dice 1D6)
      (columns (row$ "Father's Position" "Initial Funds" "Allowance" "Inheritance" "Social Status"))
               ;------------------------------------------------------------------------------------
      (rows    (row$ "Peasant"                 10    0     0  2)
               (row$ "Peasant"                 10    0     0  2)
               (row$ "Small Merchant"          25    5   100  3)
               (row$ "Merchant"               150   20   750  3)
               (row$ "Wealthy Merchant"       250   50  1500  3)
               (row$ "Very Wealthy Merchant"  500  100  4000  3)))              
   (table 
      (name "Birth Table C")
      (prerequisite-attribute "Class")
      (prerequisite-value "Gentleman")
      (dice 1D6)
      (columns (row$ "Father's Position" "Initial Funds" "Allowance" "Inheritance" "Social Status"))
               ;------------------------------------------------------------------------------------
      (rows    (row$ "Impoverished"            40    0   100  4)
               (row$ "Impoverished"            40    0   100  4)
               (row$ "Well-to-do"             250   50  1500  4)
               (row$ "Well-to-do"             250   50  1500  4)
               (row$ "Wealthy"                500  100  4000  4)
               (row$ "Very Wealthy"           750  125  5000  5)))                 
   (table 
      (name "Birth Table C")
      (prerequisite-attribute "Class")
      (prerequisite-value "Nobleman")
      (dice 1D6)
      (columns (row$ "Father's Position" "Initial Funds" "Allowance" "Inheritance"))
               ;--------------------------------------------------------------------
      (rows    (row$ "Impoverished"            40    0   100)
               (row$ "Impoverished"            40    0   100)
               (row$ "Well-to-do"             250   50  1500)
               (row$ "Wealthy"                500  100  4000)
               (row$ "Very Wealthy"           750  125  5000)            
               (row$ "Very Wealthy"           750  125  5000)))              
   (table 
      (name "Birth Table D")
      (prerequisite-attribute "Class")
      (prerequisite-value "Nobleman")
      (dice 1D6)
      (columns (row$ "Father's Title" "Social Status"))
               ;---------------------------------------
      (rows    (row$ "Knight"     6)
               (row$ "Baron"      7)
               (row$ "Marquis"    8)
               (row$ "Earl"       9)
               (row$ "Viscount"  10)            
               (row$ "Count"     11)))
                            
   (table 
      (name "Birth Table E")
      (prerequisite-attribute "Sibling Rank")
      (prerequisite-value "First Son")
      (dice 1D6)
      (columns (row$ "Orphan"))
               ;---------------------------------------
      (rows    (row$ "Yes")
               (row$ "No")
               (row$ "No")
               (row$ "No")
               (row$ "No")            
               (row$ "No"))))  
       
(deffacts modifiers
   (modifier (prerequisite-attribute "Sibling Rank")
             (prerequisite-value "First Son")
             (target-attribute "Initial Funds" "Allowance")
             (operation *)
             (value 1.1))
   (modifier (prerequisite-attribute "Sibling Rank")
             (prerequisite-value "First Son")
             (target-attribute "Social Status")
             (operation +)
             (value 1))
   (modifier (prerequisite-attribute "Class" "Sibling Rank" "Orphan")
             (prerequisite-value "Nobleman" "First Son" "Yes")
             (target-attribute "Social Status")
             (operation +)
             (value 3))
   (modifier (prerequisite-attribute "Sibling Rank")
             (prerequisite-value "Bastard")
             (target-attribute "Initial Funds" "Allowance")
             (operation *)
             (value 0.9))
   (modifier (prerequisite-attribute "Sibling Rank")
             (prerequisite-value "Bastard")
             (target-attribute "Social Status")
             (operation +)
             (value -1)))

(deffacts lists
   (list (name "Display")
         (values "Strength" "Expertise" "Constitution" "Endurance" "Class" "Sibling Rank" 
                 "Father's Position" "Father's Title" "Orphan" "Initial Funds"
                 "Allowance" "Inheritance" "Social Status" "Title")))

;;;
;;; Orphan Rules
;;;

(defrule default-orphan
   (attribute (name "Sibling Rank") (value ~"First Son"))
   =>
   (assert (attribute (name "Orphan") (value "No"))))
   
(defrule inheritance-no
   (attribute (name "Orphan") (value "No"))
   ?a <- (attribute (name "Inheritance"))
   =>
   (retract ?a))

(defrule inheritance-yes
   (attribute (name "Orphan") (value "Yes"))
   ?a1 <- (attribute (name "Initial Funds"))
   ?a2 <- (attribute (name "Allowance"))
   =>
   (retract ?a1 ?a2))

(defrule title-inheritance
   (attribute (name "Orphan") (value "Yes"))
   (attribute (name "Father's Title") (value ?title))
   =>
   (assert (attribute (name "Title") (value ?title))))

;;; 
;;; Testing Data
;;;

;;; (deffacts test-rolls
;;;    (test-roll (name "Birth Table B")
;;;               (rolls 1))
;;;    (test-roll (name "Birth Table E")
;;;               (rolls 1)))
