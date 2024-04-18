;;; CLIPS Website
;;; clipsrules.net

;;; CLIPS on SourceForge
;;; sourceforge.net/projects/clipsrules/

;;; Adventures in Rule-Based Programming: A CLIPS Tutorial
;;; clipsrules.net/airbp

;;; This CLIPS program demonstrates general techniques for implementing 
;;; RPG character generation using a rule-based programming language. 
;;; For this example, some of the dice rolling and table results used in 
;;; character generation for the Traveller RPG have been automated.
;;;
;;; Traveller, Volume 1, Book 1 Characters and Combat Rules
;;; Copyright 1977 Game Designers' Workshop

;;; Sample Run 
;;;
;;; CLIPS> (load traveller.clp)
;;; :::!!!!!!!!!!!%%%%%%%%%!%!%%%%%$********$****$$$*****************%$************%$**$******:%$***********$***********$*$
;;; TRUE
;;; CLIPS> (reset)
;;; CLIPS> (run)
;;; 
;;; Characteristics
;;; Age: 38
;;; Dexterity: 7
;;; Education: 14
;;; Endurance: 5
;;; Intelligence: 12
;;; Social Standing: 11
;;; Strength: 9
;;; 
;;; Service
;;; Annual Retirement Pay: 4000
;;; Branch: Navy
;;; Rank: Lieutenant
;;; Terms: 5
;;; 
;;; Skills
;;; Admin: 1
;;; Blade Cbt: 1
;;; Engnrng: 2
;;; Ship's Boat: 1
;;; 
;;; Possessions
;;; Cash: 35000
;;; High Psg: 1
;;; Travellers': 1
;;; 
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

(deffunction pack$ ($?args)
   (implode$ ?args))
   
(deffunction unpack$ (?args ?pos)
   (nth$ ?pos (explode$ ?args)))
     
(deffunction to-attr (?sym)
   (sym-cat (sub-string 1 3 ?sym)))

(deffunction to-roll (?sym)
   (bind ?sym (str-replace ?sym "+" ""))
   (bind ?sym (sub-string 4 (str-length ?sym) ?sym))
   (string-to-field ?sym))
   
(deffunction verbose ($?args)
   (if ?*verbose*
      then
      (println (expand$ ?args))))

(deffunction column-index (?name ?columns)
   (bind ?columns (explode$ ?columns))
   (member$ ?name ?columns))

(deffunction attribute-> (?f1 ?f2)
   (> (str-compare (fact-slot-value ?f1 name) (fact-slot-value ?f2 name)) 0))

;;;
;;; Deftemplates
;;;

(deftemplate attribute
   (slot name)
   (slot type)
   (slot value))
   
(deftemplate attribute-type
   (slot name)
   (slot type)
   (slot duplicates (allowed-values yes no)))
      
(deftemplate list
   (slot name)
   (multislot values))
   
(deftemplate roll
   (multislot name)
   (multislot roll))
   
(deftemplate test-roll
   (multislot name)
   (multislot rolls))

(deftemplate roll-attribute 
   (slot name)
   (slot dice))

(deftemplate event-roll
   (slot name) 
   (multislot prerequisite-attribute)
   (multislot prerequisite-value)
   (slot <=))

(deftemplate events
   (multislot branches)
   (multislot draft)
   (multislot enlistment)
   (multislot e+1)
   (multislot e+2)
   (multislot survival)
   (multislot s+2)
   (multislot commission)
   (multislot c+1)
   (multislot promotion)
   (multislot p+1)
   (multislot reenlist))

(deftemplate modifier
   (slot id (default-dynamic (gensym*)))
   (slot branch)
   (slot event)
   (slot bonus)
   (slot attribute)
   (slot >=))
   
(deffunction create-modifier (?branch ?event ?bonus ?attr-roll)
   (if (eq ?attr-roll -)
      then (return))
   (assert (modifier (branch ?branch)
                     (event ?event)
                     (bonus ?bonus)
                     (attribute (to-attr ?attr-roll))
                     (>= (to-roll ?attr-roll)))))
   
(deftemplate event
   (slot branch)
   (slot type)
   (slot >=))

(deffunction create-event (?branch ?event ?roll)
   (if (eq ?roll -)
      then (return))
   (bind ?roll (string-to-field (str-replace ?roll "+" "")))
   (assert (event (branch ?branch)
                  (type ?event)
                  (>= ?roll))))
   
(deftemplate abbreviation
   (slot name)
   (slot abbr))
  
(deftemplate bonus
   (slot event)
   (slot name)
   (slot value (default 0))
   (multislot add-ids)
   (multislot add-attr))
   
(deftemplate skill-points
   (slot amount)
   (slot source))

(deftemplate table
   (slot name)
   (slot dice)
   (slot columns)
   (multislot rows))
   
(deftemplate add
   (multislot entry)
   (slot raw-entry)
   (slot to (default TBD))
   (slot value (default TBD)))
   
;;;
;;; Deffacts
;;;

(deffacts attribute-types
   (attribute-type (name "Admin") (type skill))
   (attribute-type (name "Air/Raft") (type skill))
   (attribute-type (name "ATV") (type skill))
   (attribute-type (name "Blade Cbt") (type skill))
   (attribute-type (name "Brawling") (type skill))
   (attribute-type (name "Bribery") (type skill))
   (attribute-type (name "Computer") (type skill))
   (attribute-type (name "Cutlass") (type skill))
   (attribute-type (name "Electronic") (type skill))
   (attribute-type (name "Engnrng") (type skill))
   (attribute-type (name "Forgery") (type skill))
   (attribute-type (name "Fwd Obsv") (type skill))
   (attribute-type (name "Gambling") (type skill))
   (attribute-type (name "Gunnery") (type skill))
   (attribute-type (name "Gun Cbt") (type skill))
   (attribute-type (name "Jack-o-T") (type skill))
   (attribute-type (name "Leader") (type skill))
   (attribute-type (name "Mechanical") (type skill))
   (attribute-type (name "Medical") (type skill))
   (attribute-type (name "Navigation") (type skill))
   (attribute-type (name "Pilot") (type skill))
   (attribute-type (name "Revolver") (type skill))
   (attribute-type (name "Rifle") (type skill))
   (attribute-type (name "Ship's Boat") (type skill))
   (attribute-type (name "SMG") (type skill))
   (attribute-type (name "Steward") (type skill))
   (attribute-type (name "Streetwise") (type skill))
   (attribute-type (name "Tactics") (type skill))
   (attribute-type (name "Vacc Suit") (type skill))
   (attribute-type (name "Blade") (type muster))
   (attribute-type (name "Cash") (type muster))
   (attribute-type (name "Gun") (type muster))
   (attribute-type (name "High Psg") (type muster))
   (attribute-type (name "Low Psg") (type muster))
   (attribute-type (name "Merchant") (type muster))
   (attribute-type (name "Mid Psg") (type muster))
   (attribute-type (name "Scout") (type muster) (duplicates no))
   (attribute-type (name "Travellers'") (type muster) (duplicates no))
   (attribute-type (name "Muster Points") (type bookkeeping)))

;;;
;;; Add
;;;

(defrule do-add
   (declare (salience ?*high*))
   (logical (traveller))
   ?a <- (add (to ?attribute) (value ?add))
   ?at <- (attribute (name ?attribute) (value ?value))
   =>
   (retract ?a)
   (modify ?at (value (+ ?value ?add))))

(defrule do-add-new
   (declare (salience ?*high*))
   (logical (traveller))
   ?a <- (add (to ?attribute) (value ?add))
   (not (attribute (name ?attribute)))
   (attribute-type (name ?attribute) (type ?type))
   =>
   (retract ?a)
   (assert (attribute (name ?attribute) (type ?type) (value ?add))))
   
(defrule add-skill-from-raw-entry
   (declare (salience ?*high*))
   ?a <- (add (raw-entry ?raw-entry)
              (to TBD)
              (value TBD))
   (attribute-type (name ?raw-entry))
   =>
   (modify ?a (to ?raw-entry)
              (value 1)))

(defrule add-trait-from-raw-entry
   (declare (salience ?*high*))
   ?a <- (add (entry ?inc&:(integerp ?inc) ?abbr)
              (to TBD)
              (value TBD))
   (abbreviation (abbr ?abbr)
                 (name ?attribute))
   =>
   (modify ?a (to ?attribute)
              (value ?inc)))

(defrule duplicates-not-allowed
   (declare (salience ?*high*))
   (logical (traveller))
   ?a <- (attribute (name ?name) (type muster) (value ?value&:(> ?value 1)))
   (attribute-type (name ?name) (duplicates no))
   =>
   (verbose "Duplicate " ?name " material discarded.")
   (modify ?a (value 1)))

;;;
;;; Dice Rolling
;;;

(defrule do-roll "using random numbers"
   ?r <- (roll (name $?name) (roll ?n D ?s))
   (not (test-roll (name $?name) (rolls ? $?)))
   =>
   (bind ?roll (roll-#D# ?n ?s))
   (modify ?r (roll ?roll)))

(defrule do-roll-test "using predefined roll for testing"
   ?r <- (roll (name $?name) (roll ?n D ?s))
   ?tr <- (test-roll (name $?name) (rolls ?roll $?rest))
   =>
   (modify ?r (roll ?roll))
   (modify ?tr (rolls ?rest)))

;;;        
;;; Bonus Computations
;;;

(defrule add-bonus
   (declare (salience ?*high*))
   (logical (create-bonuses))
   (modifier (id ?id)
             (event ?event)
             (branch ?branch)
             (bonus ?add)
             (attribute ?attribute)
             (>= ?minimum))
   ?b <- (bonus (event ?event | all)
                (name ?branch)
                (value ?bonus)
                (add-ids $?ids&:(not (member$ ?id ?ids)))
                (add-attr $?add-attr))
   (abbreviation (abbr ?abbr)
                 (name ?attribute))
   (attribute (name ?attribute) (value ?value&:(>= ?value ?minimum)))
   =>
   (modify ?b (value (+ ?bonus ?add))
              (add-ids ?ids ?id)
              (add-attr ?add-attr ?abbr)))

;;;
;;; Init task
;;;

(deffacts start
   (task initialize))
   
(defrule finished-initialization
   (declare (salience ?*low*))
   ?t <- (task initialize)
   =>
   (retract ?t)
   (assert (task attributes)))

(defrule replace-modifier-abbreviation
   (task initialize)
   ?m <- (modifier (attribute ?abbr))
   (abbreviation (abbr ?abbr)
                 (name ?name))
   =>
   (modify ?m (attribute ?name)))
   
(defrule create-modifiers
   (task initialize)
   (events (branches $?branches)
           (e+1 $?e+1)
           (e+2 $?e+2)
           (s+2 $?s+2)
           (c+1 $?c+1)
           (p+1 $?p+1))
   =>
   (foreach ?b ?branches
      (bind ?n ?b-index)
      (create-modifier ?b enlistment 1 (nth$ ?n ?e+1))
      (create-modifier ?b enlistment 2 (nth$ ?n ?e+2))
      (create-modifier ?b survival 2 (nth$ ?n ?s+2))
      (create-modifier ?b commission 1 (nth$ ?n ?c+1))
      (create-modifier ?b promotion 1 (nth$ ?n ?p+1))))

(defrule create-events
   (task initialize)
   (events (branches $?branches)
           (enlistment $?enlistment)
           (survival $?survival)
           (commission $?commission)
           (promotion $?promotion)
           (reenlist $?reenlist))
   =>
   (foreach ?b ?branches
      (bind ?n ?b-index)
      (create-event ?b enlistment (nth$ ?n ?enlistment))
      (create-event ?b survival (nth$ ?n ?survival))
      (create-event ?b commission (nth$ ?n ?commission))
      (create-event ?b promotion (nth$ ?n ?promotion))
      (create-event ?b reenlist (nth$ ?n ?reenlist))))
   
(deffacts events
   (events (branches   "Navy" "Marines" "Army" "Scouts" "Merchant" "Other")
           (draft        1        2       3       4         5         6   )
           (enlistment   8+       9+      5+      7+        7+        3+  )
                  (e+1  INT8+   INT8+   DEX6+    INT6+     STR7+      -   )
                  (e+2  EDU9+   STR8+   END5+    STR8+     INT6+      -   )
           (survival     5+       6+      5+      7+        5+        5+  )
                  (s+2  INT7+   END8+   EDU6+    END9+     INT7+    INT9+ )
           (commission   10+      9+      5+      -         4+        -   )
                  (c+1  SOC9+   EDU7+   END7+     -        INT6+      -   )
           (promotion    8+       9+      6+      -        10+        -   )
                  (p+1  EDU8+   SOC8+   EDU7+     -        INT9+      -   )
           (reenlist     6+       6+      7+      3+        4+        5+  )))

;;;              
;;; Attributes Task
;;;
      
(deffacts attribute-rolls
   (roll-attribute (name "Strength") (dice 2D6))
   (roll-attribute (name "Dexterity") (dice 2D6))
   (roll-attribute (name "Endurance") (dice 2D6))
   (roll-attribute (name "Intelligence") (dice 2D6))
   (roll-attribute (name "Education") (dice 2D6))
   (roll-attribute (name "Social Standing") (dice 2D6)))

(deffacts abbreviations
   (abbreviation (name "Strength") (abbr STR))
   (abbreviation (name "Dexterity") (abbr DEX))
   (abbreviation (name "Endurance") (abbr END))
   (abbreviation (name "Intelligence") (abbr INT))
   (abbreviation (name "Education") (abbr EDU))
   (abbreviation (name "Social Standing") (abbr SOC)))
   
(defrule birth
   (task attributes)
   (not (traveller))
   =>
   (verbose "Spawning traveller...")
   (assert (traveller)))
   
(defrule age
   (logical (traveller))
   (task attributes)
   =>
   (assert (attribute (name "Age") (type character) (value 18))))

(defrule attribute-need-roll
   (task attributes)
   (roll-attribute (name ?attribute)
                   (dice ?roll))
   =>
   (assert (roll (name ?attribute) 
                 (roll (expand-roll ?roll)))))

(defrule attribute-got-roll
   (logical (traveller))
   (task attributes)
   (roll-attribute (name ?attribute))
   ?r <- (roll (name ?attribute) (roll ?roll))
   =>
   (retract ?r)
   (assert (attribute (name ?attribute)
                      (type character)
                      (value ?roll))))
                      
(defrule do-enlistment
   (declare (salience ?*low*))
   ?t <- (task attributes)
   (forall (roll-attribute (name ?name))
           (attribute (name ?name)))
   => 
   (bind ?facts (find-all-facts ((?a attribute)) (eq ?a:type character)))
   (bind ?facts (sort attribute-> ?facts))
   (foreach ?f ?facts
      (verbose (fact-slot-value ?f name) ": " (fact-slot-value ?f value)))
   (retract ?t)
   (assert (task enlistment)))
   
;;;   
;;; Enlistment Task
;;;
   
(defrule create-bonus-enlistment
   (declare (salience ?*high*))
   (logical (task enlistment))
   (event (branch ?branch) 
          (type enlistment))
   =>
   (assert (create-bonuses))
   (assert (bonus (event enlistment)
                  (name ?branch))
           (bonus (event survival)
                  (name ?branch))))
   
(defrule recommend-branch
   (declare (salience ?*low*))
   (task enlistment)
   (bonus (name ?branch) (event survival) (value ?sv))
   (bonus (name ?branch) (event enlistment) (value ?ev))
   (event (branch ?branch) (type enlistment) (>= ?er))
   (not (and (bonus (name ?branch2&~?branch) (event survival) (value ?sv2))
             (bonus (name ?branch2) (event enlistment) (value ?ev2)) 
             (event (branch ?branch2) (type enlistment) (>= ?er2))
             (test (or (> ?sv2 ?sv)
                       (and (= ?sv2 ?sv)
                            (> ?ev2 ?ev))
                       (and (= ?sv2 ?sv)
                            (= ?ev2 ?ev)
                            (> ?er2 ?er))))))
   =>
   (assert (enlist ?branch)))

(defrule need-enlistment-roll
   (task enlistment)
   (enlist ?branch)
   =>
   (assert (roll (name enlistment) 
                 (roll (expand-roll 2D6)))))

(defrule got-enlistment-roll-pass
   (logical (traveller))
   ?t <- (task enlistment)
   ?r <- (roll (name enlistment)
         (roll ?roll))
   ?e <- (enlist ?branch)
   (event (branch ?branch) (type enlistment) (>= ?er))
   (bonus (name ?branch) (event enlistment) (value ?b))
   (test (>= (+ ?roll ?b) ?er))
   =>
   (retract ?t ?r ?e)
   (verbose "Enlistment in " ?branch " succeeded with roll " ?roll " + " ?b " >= " ?er ".")
   (assert (attribute (name "Entry") (type bookkeeping) (value enlisted)))
   (assert (attribute (name "Branch") (type service) (value ?branch)))
   (assert (attribute (name "Terms") (type service) (value 1)))
   (assert (task survival)))

(defrule got-enlistment-roll-fail
   ?t <- (task enlistment)
   ?r <- (roll (name enlistment)
         (roll ?roll))
   ?e <- (enlist ?branch)
   (event (branch ?branch) (type enlistment) (>= ?er))
   (bonus (name ?branch) (event enlistment) (value ?b))
   (test (< (+ ?roll ?b) ?er))
   =>
   (retract ?t ?r ?e)
   (verbose "Enlistment in " ?branch " failed with roll " ?roll " + " ?b " < " ?er ".")
   (assert (task draft)))

;;;   
;;; Draft Task
;;;

(defrule draft-need-roll
   (task draft)
   =>
   (assert (roll (name draft) 
                 (roll (expand-roll 1D6)))))

(defrule draft-got-roll
   (logical (traveller))
   ?t <- (task draft)
   ?r <- (roll (name draft)
               (roll ?roll))
   (events (branches $?branches))
   =>
   (retract ?t ?r)
   (bind ?branch (nth$ ?roll ?branches))
   (verbose "Drafted into " ?branch " with roll " ?roll ".")
   (assert (attribute (name "Branch") (type service) (value ?branch)))
   (assert (attribute (name "Terms") (type service) (value 1)))
   (assert (attribute (name "Entry") (type bookkeeping) (value drafted)))
   (assert (task survival)))

;;;
;;; Survival Task
;;;

(defrule create-bonus-survival
   (declare (salience ?*high*))
   (logical (task survival))
   (attribute (name "Branch") (value ?branch))
   =>
   (assert (create-bonuses))
   (assert (bonus (event survival)
                  (name ?branch))))

(defrule survival-need-roll
   (task survival)
   =>
   (assert (roll (name survival) 
                 (roll (expand-roll 2D6)))))

(defrule got-survival-roll-pass
   ?t <- (task survival)
   ?r <- (roll (name survival)
         (roll ?roll))
   (attribute (name "Branch") (value ?branch))
   (attribute (name "Terms") (value ?term))
   (event (branch ?branch) (type survival) (>= ?sr))
   (bonus (name ?branch) (event survival) (value ?b))
   (test (>= (+ ?roll ?b) ?sr))
   =>
   (verbose "Term " ?term " survived with roll " ?roll " + " ?b " >= " ?sr ".")
   (retract ?t ?r)
   (if (= ?term 1)
      then (assert (skill-points (amount 2) (source survival)))
      else (assert (skill-points (amount 1) (source survival))))
   (assert (task commission)))

(defrule got-survival-roll-fail
   ?t <- (task survival)
   ?r <- (roll (name survival)
         (roll ?roll))
   (attribute (name "Branch") (value ?branch))
   (attribute (name "Terms") (value ?term))
   (event (branch ?branch) (type survival) (>= ?sr))
   (bonus (name ?branch) (event survival) (value ?b))
   (test (< (+ ?roll ?b) ?sr))
   =>
   (verbose "Term " ?term " not survived with roll " ?roll " + " ?b " < " ?sr ".")
   (retract ?t ?r)
   (assert (task death)))
   
;;;
;;; Death Task
;;;

(defrule do-death
   ?ta <- (task death)
   ?tr <- (traveller)
   =>
   (retract ?ta ?tr)
   (assert (task attributes)))
   
;;;
;;; Commission Task
;;;

(deftemplate ranks
   (slot branch)
   (multislot list))
   
(deffacts branch-ranks
   (ranks (branch "Navy") (list "Ensign" "Lieutenant" "Lt Cmdr" "Commander" "Captain" "Admiral"))
   (ranks (branch "Marines") (list "Lieutenant" "Captain" "Force Cmdr" "Lt Colonel" "Colonel" "Brigadier"))
   (ranks (branch "Army") (list "Lieutenant" "Captain" "Major" "Lt Colonel" "Colonel" "General"))
   (ranks (branch "Merchant") (list "4th Officer" "3rd Officer" "2nd Officer" "1st Officer" "Captain")))

(defrule create-bonus-commission
   (declare (salience ?*high*))
   (logical (task commission))
   (attribute (name "Branch") (value ?branch))
   =>
   (assert (create-bonuses))
   (assert (bonus (event commission)
                  (name ?branch))))

(defrule no-commissions-allowed
   (declare (salience ?*high*))
   ?t <- (task commission)
   (attribute (name "Branch") (value ?branch))
   (attribute (name "Terms") (value ?term))
   (not (event (branch ?branch) (type commission)))
   =>
   (if (= ?term 1)
      then
      (verbose "Skipping commission (not available for " ?branch ")."))
   (retract ?t)
   (assert (task skills)))
   
(defrule no-commissions-first-term-drafted
   (declare (salience ?*high*))
   ?t <- (task commission)
   (attribute (name "Branch") (value ?branch))
   (attribute (name "Terms") (value 1))
   (attribute (name "Entry") (value drafted))
   (event (branch ?branch) (type commission))
   =>
   (verbose "Skipping commission (draftees not eligible in 1st term).")
   (retract ?t)
   (assert (task skills)))

(defrule already-commissioned
   (declare (salience ?*high*))
   ?t <- (task commission)
   (attribute (name "Rank"))
   =>
   (retract ?t)
   (assert (task promotion)))

(defrule commission-need-roll
   (task commission)
   (attribute (name "Branch") (value ?branch))
   (not (and (attribute (name "Terms") (value 1))
             (attribute (name "Entry") (value drafted))))
   (event (branch ?branch) (type commission))
   (not (attribute (name "Rank")))
   =>
   (assert (roll (name commission) 
                 (roll (expand-roll 2D6)))))

(defrule got-commission-roll-pass
   (logical (traveller))
   ?t <- (task commission)
   ?r <- (roll (name commission)
         (roll ?roll))
   (attribute (name "Branch") (value ?branch))
   (event (branch ?branch) (type commission) (>= ?cr))
   (bonus (name ?branch) (event commission) (value ?b))
   (test (>= (+ ?roll ?b) ?cr))
   (ranks (branch ?branch) (list ?rank $?))
   =>
   (retract ?t ?r)
   (verbose "Commission received to " ?rank " with roll " ?roll " + " ?b " >= " ?cr ".")
   (assert (attribute (name "Rank") (type service) (value ?rank)))
   (assert (skill-points (amount 1) (source commission)))
   (assert (task promotion)))

(defrule got-commission-roll-fail
   ?t <- (task commission)
   ?r <- (roll (name commission)
         (roll ?roll))
   (attribute (name "Branch") (value ?branch))
   (event (branch ?branch) (type commission) (>= ?cr))
   (bonus (name ?branch) (event commission) (value ?b))
   (test (< (+ ?roll ?b) ?cr))
   =>
   (retract ?t ?r)
   (verbose "Commission denied with roll " ?roll " + " ?b " < " ?cr ".")
   (assert (task skills)))

;;;
;;; Promotion Task
;;;

(defrule create-bonus-promotion
   (declare (salience ?*high*))
   (logical (task promotion))
   (attribute (name "Branch") (value ?branch))
   =>
   (assert (create-bonuses))
   (assert (bonus (event promotion)
                  (name ?branch))))

(defrule promotion-no-higher-rank
   (declare (salience ?*high*))
   ?t <- (task promotion)
   (attribute (name "Branch") (value ?branch))
   (attribute (name "Rank") (value ?rank))
   (ranks (branch ?branch) (list $? ?rank))
   =>
   (verbose "Skipping promotion (no higher rank).")
   (retract ?t)
   (assert (task skills)))
   
(defrule promotion-need-roll
   (task promotion)
   (attribute (name "Branch") (value ?branch))
   (event (branch ?branch) (type promotion))
   =>
   (assert (roll (name promotion) 
                 (roll (expand-roll 2D6)))))

(defrule got-promotion-roll-pass
   (logical (traveller))
   ?t <- (task promotion)
   ?r <- (roll (name promotion)
         (roll ?roll))
   (attribute (name "Branch") (value ?branch))
   (event (branch ?branch) (type promotion) (>= ?pr))
   (bonus (name ?branch) (event promotion) (value ?b))
   (test (>= (+ ?roll ?b) ?pr))
   ?a <- (attribute (name "Rank") (value ?rank))
   (ranks (branch ?branch) (list $? ?rank ?new-rank $?))
   =>
   (verbose "Promotion to " ?new-rank " with roll " ?roll " + " ?b " >= " ?pr ".")
   (retract ?t ?r)
   (modify ?a (value ?new-rank))
   (assert (skill-points (amount 1) (source promotion)))
   (assert (task skills)))

(defrule got-promotion-roll-fail
   ?t <- (task promotion)
   ?r <- (roll (name promotion)
         (roll ?roll))
   (attribute (name "Branch") (value ?branch))
   (event (branch ?branch) (type promotion) (>= ?pr))
   (bonus (name ?branch) (event promotion) (value ?b))
   (test (< (+ ?roll ?b) ?pr))
   =>
   (verbose "Promotion denied with roll " ?roll " + " ?b " < " ?pr ".")
   (retract ?t ?r)
   (assert (task skills)))
   
;;;
;;; Skills Task
;;;

(deftemplate rss
   (slot branch)
   (slot rank (default any))
   (slot skill))
   
(deffacts rank-service-skills
   (rss (branch "Navy") (rank "Captain") (skill "+1 SOC"))
   (rss (branch "Navy") (rank "Admiral") (skill "+1 SOC"))
   (rss (branch "Marines") (skill "Cutlass"))
   (rss (branch "Marines") (rank "Lieutenant") (skill "Revolver"))
   (rss (branch "Army") (skill "Rifle"))
   (rss (branch "Army") (rank "Lieutenant") (skill "SMG"))
   (rss (branch "Merchant") (rank "1st Officer") (skill "Pilot"))
   (rss (branch "Scout") (skill "Pilot")))
   
(defrule assign-rss-service
   (declare (salience ?*high*))
   (logical (traveller))
   (task skills)
   (rss (branch ?branch) (rank any) (skill ?skill))
   (attribute (name "Branch") (value ?branch))
   (not (rss-received ?branch ?skill))
   =>
   (verbose "Adding service skill " ?skill " for " ?branch ".")
   (assert (add (entry (explode$ ?skill)) (raw-entry ?skill)))
   (assert (rss-received ?branch ?skill)))

(defrule assign-rss-service-rank
   (declare (salience ?*high*))
   (logical (traveller))
   (task skills)
   (rss (branch ?branch) (rank ?rank&~any) (skill ?skill))
   (attribute (name "Rank") (type service) (value ?prank))
   (attribute (name "Branch") (value ?branch))
   (or (test (eq ?rank ?prank))
       (ranks (branch ?branch) (list $? ?rank $? ?prank $?)))
   (not (rss-received ?branch ?rank ?skill))
   =>
   (verbose "Adding service skill " ?skill " for " ?branch " " ?rank ".")
   (assert (add (entry (explode$ ?skill)) (raw-entry ?skill)))
   (assert (rss-received ?branch ?rank ?skill)))

(deffacts skill-tables
   (table 
      (name "Personal Development Table")
      (dice 1D6)
      (columns (row$ "Navy"         "Marines"     "Army"        "Scouts"      "Merchant"    "Other"))
               ;-----------------------------------------------------------------------------------------
      (rows    (row$ "+1 STR"       "+1 STR"      "+1 STR"      "+1 STR"      "+1 STR"      "+1 STR"    )
               (row$ "+1 DEX"       "+1 DEX"      "+1 DEX"      "+1 DEX"      "+1 DEX"      "+1 DEX"    )
               (row$ "+1 END"       "+1 END"      "+1 END"      "+1 END"      "+1 END"      "+1 END"    )
               (row$ "+1 SOC"       "Gambling"    "Gambling"    "Gun Cbt"     "+1 STR"      "Blade Cbt" )
               (row$ "+1 INT"       "Brawling"    "Brawling"    "+1 INT"      "Blade Cbt"   "Brawling"  )
               (row$ "+1 EDU"       "Blade Cbt"   "+1 EDU"      "+1 EDU"      "Bribery"     "-1 SOC"    ))) 
   (table 
      (name "Services Skill Table")
      (dice 1D6)
      (columns (row$ "Navy"         "Marines"     "Army"        "Scouts"      "Merchant"    "Other"))
               ;-----------------------------------------------------------------------------------------
      (rows    (row$ "Ship's Boat"  "ATV"         "ATV"         "Air/Raft"    "Steward"     "Forgery"   )
               (row$ "Vacc Suit"    "Vacc Suit"   "Air/Raft"    "Vacc Suit"   "Vacc Suit"   "Gambling"  )
               (row$ "Fwd Obsv"     "Blade Cbt"   "Fwd Obsv"    "Navigation"  "+1 STR"      "Brawling"  )
               (row$ "Blade Cbt"    "Blade Cbt"   "Blade Cbt"   "Mechanical"  "Gun Cbt"     "Blade Cbt" )
               (row$ "Gun Cbt"      "Gun Cbt"     "Gun Cbt"     "Electronic"  "Electronic"  "Gun Cbt"   )
               (row$ "Gunnery"      "Gun Cbt"     "Gun Cbt"     "Jack-o-T"    "Jack-o-T"    "Bribery"   ))) 
   (table 
      (name "Advanced Education Table")
      (dice 1D6)
      (columns (row$ "Navy"         "Marines"     "Army"        "Scouts"      "Merchant"    "Other"))
               ;------------------------------------------------------------------------------------------
      (rows    (row$ "Vacc Suit"    "ATV"         "ATV"         "Air/Raft"    "Streetwise"  "Streetwise" )
               (row$ "Mechanical"   "Mechanical"  "Mechanical"  "Mechanical"  "Mechanical"  "Mechanical" )
               (row$ "Electronic"   "Electronic"  "Electronic"  "Electronic"  "Electronic"  "Electronic" )
               (row$ "Engnrng"      "Tactics"     "Tactics"     "Jack-o-T"    "Navigation"  "Gambling"   )
               (row$ "Gunnery"      "Blade Cbt"   "Blade Cbt"   "Gunnery"     "Gunnery"     "Brawling"   )
               (row$ "Jack-o-T"     "Gun Cbt"     "Gun Cbt"     "Medical"     "Medical"     "Forgery"    ))) 
   (table 
      (name "Advanced Education Table 8+")
      (dice 1D6)
      (columns (row$ "Navy"         "Marines"     "Army"        "Scouts"      "Merchant"    "Other"))
               ;------------------------------------------------------------------------------------------
      (rows    (row$ "Medical"      "Medical"     "Medical"     "Medical"     "Medical"     "Medical"    )
               (row$ "Navigation"   "Tactics"     "Tactics"     "Navigation"  "Navigation"  "Forgery"    )
               (row$ "Engnrng"      "Tactics"     "Tactics"     "Engnrng"     "Engnrng"     "Electronic" )
               (row$ "Computer"     "Computer"    "Computer"    "Computer"    "Computer"    "Computer"   )
               (row$ "Pilot"        "Leader"      "Leader"      "Pilot"       "Pilot"       "Streetwise" )
               (row$ "Admin"        "Admin"       "Admin"       "Jack-o-T"    "Admin"       "Jack-o-T"   ))))
   
(defrule skill-from-table
   (task skills)
   ?as <- (add-skill)
   ?st <- (skill-tables $?tables)
   ?r1 <- (roll (name skill-table)
                (roll ?roll1))
   (table (name ?name&=(nth$ ?roll1 ?tables))
          (columns ?columns)
          (rows $?rows))
   ?r2 <- (roll (name skill-row)
                (roll ?roll2))
   (attribute (name "Branch") (value ?branch))
   =>        
   (retract ?as ?st ?r1 ?r2) 
   (bind ?column (column-index ?branch ?columns))
   (bind ?row (explode$ (nth$ ?roll2 ?rows)))
   (bind ?skill (nth$ ?column ?row))
   (verbose "Adding skill " ?skill " from " ?name " with roll " ?roll2 ".")
   (assert (add (entry (explode$ ?skill)) (raw-entry ?skill))))
   
(defrule determine-tables-3
   (task skills)
   (add-skill)
   (attribute (name "Education") (value ?value&:(< ?value 8)))
   =>
   (assert (skill-tables "Personal Development Table" 
                         "Services Skill Table"
                         "Advanced Education Table")
           (roll (name skill-table) 
                 (roll (expand-roll 1D3)))
           (roll (name skill-row) 
                 (roll (expand-roll 1D6)))))

(defrule determine-tables-4
   (task skills)
   (add-skill)
   (attribute (name "Education") (value ?value&:(>= ?value 8)))
   =>
   (assert (skill-tables "Personal Development Table" 
                         "Services Skill Table"
                         "Advanced Education Table"
                         "Advanced Education Table 8+")
           (roll (name skill-table) 
                 (roll (expand-roll 1D4)))
           (roll (name skill-row) 
                 (roll (expand-roll 1D6)))))

(defrule add-skill-1
   (declare (salience ?*low*))
   (task skills)
   ?sp <- (skill-points (amount 1))
   =>
   (retract ?sp)
   (assert (add-skill)))

(defrule add-skill->-1
   (declare (salience ?*low*))
   (task skills)
   ?sp <- (skill-points (amount ?amount&:(> ?amount 1)))
   =>
   (modify ?sp (amount (- ?amount 1)))
   (assert (add-skill)))
   
(defrule skills-skip
   (declare (salience ?*low*))
   ?t <- (task skills)
   (not (skill-points))
   =>
   (retract ?t)
   (assert (task aging)))

;;;
;;; Aging Task
;;;

(defglobal ?*aging-saving-throw* = 8)

(deftemplate aging
   (slot bt)  ; begin-term
   (slot et)  ; end-term
   (slot at)  ; attribute
   (slot de)  ; decrement
   (slot sr)) ; saving roll
   
(deffacts aging-effects
   (aging-attributes "Strength" "Dexterity" "Endurance" "Intelligence")
   (aging (bt  4)  (et 7) (at "Strength")     (de -1) (sr 8))
   (aging (bt  8) (et 11) (at "Strength")     (de -1) (sr 9))
   (aging (bt 12) (et 99) (at "Strength")     (de -2) (sr 9))
   (aging (bt 4)   (et 7) (at "Dexterity")    (de -1) (sr 7))
   (aging (bt 8)  (et 11) (at "Dexterity")    (de -1) (sr 8))
   (aging (bt 12) (et 99) (at "Dexterity")    (de -2) (sr 9))
   (aging (bt 4)   (et 7) (at "Endurance")    (de -1) (sr 8))
   (aging (bt 8)  (et 11) (at "Endurance")    (de -1) (sr 9))
   (aging (bt 12) (et 99) (at "Endurance")    (de -2) (sr 9))
   (aging (bt 12) (et 99) (at "Intelligence") (de -1) (sr 9)))
   
(defrule need-aging-roll
   (task aging)
   (attribute (name "Terms") (value ?term))
   (aging (bt ?bt) (et ?et) (at ?attribute))
   (test (and (>= ?term ?bt)
              (<= ?term ?et)))
   =>
   (assert (roll (name aging ?attribute) 
                 (roll (expand-roll 2D6)))))

(defrule got-roll-aging
   (task aging)
   (attribute (name "Terms") (value ?term))
   (aging (bt ?bt) (et ?et) (at ?attribute) (de ?decrement) (sr ?sr))
   (test (and (>= ?term ?bt)
              (<= ?term ?et)))
   ?r <- (roll (name aging ?attribute)
         (roll ?roll))
   =>
   (retract ?r)
   (if (< ?roll ?sr)
      then
      (verbose "Reducing " ?attribute " by " ?decrement 
               " because of aging with roll " ?roll " < " ?sr ".")
      (assert (add (to ?attribute) (value ?decrement)))))
 
(defrule need-aging-save-throw
   (declare (salience ?*high*))
   (aging-attributes $? ?attribute $?) ;; Uses exists instead
   (attribute (name ?attribute)
              (value ?value))
   (test (< ?value 1))
   =>
   (verbose "Attribute " ?attribute " reduced to less than 1.")
   (assert (roll (name aging-saving-roll ?attribute) 
                 (roll (expand-roll 2D6)))))

(defrule got-aging-saving-throw-pass
   (declare (salience ?*high*))
   (aging-attributes $? ?attribute $?)
   ?a <- (attribute (name ?attribute)
                    (value ?value))
   (test (< ?value 1))
   ?r <- (roll (name aging-saving-roll ?attribute)
         (roll ?roll))
   (test (>= ?roll ?*aging-saving-throw*))
   =>
   (retract ?r)
   (verbose "Attribute " ?attribute " restored to 1 with aging saving roll of " ?roll 
            " >= " ?*aging-saving-throw* ".")
   (modify ?a (value 1)))

(defrule got-aging-saving-throw-fail
   (declare (salience ?*high*))
   ?t <- (task aging)
   (aging-attributes $? ?attribute $?)
   ?a <- (attribute (name ?attribute)
                    (value ?value))
   (test (< ?value 1))
   ?r <- (roll (name aging-saving-roll ?attribute)
         (roll ?roll))
   (test (< ?roll ?*aging-saving-throw*))
   =>
   (retract ?r ?t)
   (verbose "Character dies with aging saving roll of " ?roll " < " 
            ?*aging-saving-throw* ".")
   (assert (task death)))

(defrule done-aging
   (declare (salience ?*low*))
   ?t <- (task aging)
   =>
   (retract ?t)
   (assert (task reenlist)))

;;;
;;; Reenlist Task
;;;

(defrule reenlist-need-roll
   (task reenlist)
   (attribute (name "Branch") (value ?branch))
   (event (branch ?branch) (type reenlist))
   =>
   (assert (roll (name reenlist) 
                 (roll (expand-roll 2D6)))))

(defrule got-reenlist-roll-pass-term-lt-7
   (logical (traveller))
   ?t <- (task reenlist)
   ?r <- (roll (name reenlist)
         (roll ?roll))
   (attribute (name "Branch") (value ?branch))
   ?c <- (attribute (name "Terms") (value ?term&:(< ?term 7)))
   (event (branch ?branch) (type reenlist) (>= ?rr))
   (test (>= ?roll ?rr))
   =>
   (retract ?t ?r)
   (modify ?c (value (+ 1 ?term)))
   (verbose "Reenlisting in " ?branch " with roll " ?roll " >= " ?rr ".")
   (assert (task survival)))

(defrule got-reenlist-roll-fail-term-lt-7
   ?t <- (task reenlist)
   ?r <- (roll (name reenlist)
         (roll ?roll))
   (attribute (name "Branch") (value ?branch))
   (attribute (name "Terms") (value ?term&:(< ?term 7)))
   (event (branch ?branch) (type reenlist) (>= ?rr))
   (test (< ?roll ?rr))
   =>
   (retract ?t ?r)
   (verbose "Unable to reenlist in " ?branch " with roll " ?roll " < " ?rr ".")
   (assert (task mustering-out)))

(defrule got-reenlist-roll-pass-term-gte-7
   (logical (traveller))
   ?t <- (task reenlist)
   ?r <- (roll (name reenlist)
         (roll ?roll))
   (attribute (name "Branch") (value ?branch))
   ?c <- (attribute (name "Terms") (value ?term&:(>= ?term 7)))
   (test (>= ?roll 12))
   =>
   (retract ?t ?r)
   (modify ?c (value (+ 1 ?term)))
   (verbose "Mandatory retirement waved in " ?branch " with roll " ?roll ".")
   (assert (task survival)))

(defrule got-reenlist-roll-fail-term-gte-7
   ?t <- (task reenlist)
   ?r <- (roll (name reenlist)
         (roll ?roll))
   (attribute (name "Branch") (value ?branch))
   (attribute (name "Terms") (value ?term&:(>= ?term 7)))
   (test (< ?roll 12))
   =>
   (retract ?t ?r)
   (verbose "Mandatory retirement from " ?branch " with roll " ?roll ".")
   (assert (task mustering-out)))

;;;
;;; Mustering Out Task
;;;

(deffacts muster-tables
   (table 
      (name "Material Benefits")
      (dice 1D6)
      (columns (row$ "Navy"         "Marines"      "Army"      "Scouts"   "Merchant"  "Other"))
               ;-----------------------------------------------------------------------------------------
      (rows    (row$ "Low Psg"      "Low Psg"      "Low Psg"   "Low Psg"  "Low Psg"   "Low Psg"  )
               (row$ "+1 INT"       "+2 INT"       "+1 INT"    "+2 INT"   "+1 INT"    "+1 INT"   )
               (row$ "+2 EDU"       "+1 EDU"       "+2 EDU"    "+2 EDU"   "+1 EDU"    "+1 EDU"   )
               (row$ "Blade"        "Blade"        "Gun"       "Blade"    "Gun"       "Gun"      )
               (row$ "Travellers'"  "Travellers'"  "High Psg"  "Gun"      "Blade"     "High Psg" )
               (row$ "High Psg"     "High Psg"     "Mid Psg"   "Scout"    "Low Psg"      ""      )
               (row$ "+2 SOC"       "+2 SOC"       "+1 SOC"      ""       "Merchant"     ""      ))) 
   (table 
      (name "Cash Allowances")
      (dice 1D6)
      (columns (row$ "Navy"         "Marines"      "Army"      "Scouts"   "Merchant"  "Other"))
               ;-----------------------------------------------------------------------------------------
      (rows    (row$   1000           2000           2000       20000       1000         1000    )
               (row$   5000           5000           5000       20000       5000         5000    )
               (row$   5000           5000          10000       30000      10000        10000    )
               (row$  10000          10000          10000       30000      20000        10000    )
               (row$  20000          20000          10000       50000      20000        10000    )
               (row$  50000          30000          20000       50000      40000        50000    )
               (row$  50000          40000          30000       50000      40000       100000    )))
) 

(defrule update-age
   (logical (traveller))
   (task mustering-out)
   (attribute (name "Terms") (value ?term))
   =>
   (assert (add (to "Age") (value (* ?term 4)))))
   
(defrule retirement-pay
   (logical (traveller))
   (task mustering-out)
   (attribute (name "Terms") (value ?term&:(>= ?term 5)))
   =>
   (assert (attribute (name "Annual Retirement Pay")
                      (type service)
                      (value (+ 4000 (* 2000 (- ?term 5)))))))

(defrule term-muster-points-terms
   (declare (salience ?*high*))
   (logical (traveller))
   (task mustering-out)
   (attribute (name "Terms") (value ?terms))
   =>
   (assert (add (to "Muster Points") (value ?terms)))
   (assert (muster-bonus-material 0)  
           (muster-bonus-cash 0))) 

(defrule term-muster-points-rank
   (declare (salience ?*high*))
   (logical (traveller))
   (task mustering-out)
   (attribute (name "Branch") (value ?branch))
   (attribute (name "Rank") (value ?rank))
   (ranks (branch ?branch) (list $?ranks))
   ?mm <- (muster-bonus-material 0)
   =>
   (bind ?rank# (member$ ?rank ?ranks))
   (if (or (= ?rank# 5) (= ?rank# 6))
      then 
      (retract ?mm)
      (assert (muster-bonus-material 1)))
   (bind ?points (div (+ ?rank# 1) 2))
   (assert (add (to "Muster Points") (value ?points))))

(defrule muster-cash-bonus
   (declare (salience ?*high*))
   (logical (traveller))
   (task mustering-out)
   (attribute (name "Gambling") (type skill))
   ?m <- (muster-bonus-cash 0)
   =>
   (retract ?m)
   (assert (muster-bonus-cash 1)))
    
(defrule assign-muster-rolls
   (logical (traveller))
   (task mustering-out)
   (attribute (name "Muster Points") (value ?amount))
   =>
   (bind ?cash-rolls (min ?amount 3))
   (bind ?material-rolls (- ?amount ?cash-rolls))
   (assert (muster-rolls-cash ?cash-rolls))
   (assert (muster-rolls-material ?material-rolls)))
                          
(defrule need-cash-roll
   (declare (salience ?*low*))
   (muster-rolls-cash ?amount&:(> ?amount 0))
   =>
   (assert (roll (name muster-roll cash) 
                 (roll (expand-roll 1D6)))))

(defrule need-material-roll
   (declare (salience ?*low*))
   (muster-rolls-material ?amount&:(> ?amount 0))
   =>
   (assert (roll (name muster-roll material) 
                 (roll (expand-roll 1D6)))))

(defrule got-cash-roll
   (logical (traveller))
   ?m <- (muster-rolls-cash ?amount&:(> ?amount 0))
   ?r <- (roll (name muster-roll cash) (roll ?roll))
   (muster-bonus-cash ?b)
   (attribute (name "Branch") (value ?branch))
   (table (name "Cash Allowances")
          (columns ?columns)
          (rows $?rows))
   =>
   (bind ?column (column-index ?branch ?columns))
   (bind ?row (explode$ (nth$ (+ ?roll ?b) ?rows)))
   (bind ?cash (nth$ ?column ?row))
   (retract ?r ?m)
   (verbose "Adding cash " ?cash " with muster roll of " ?roll " + " ?b)
   (assert (add (to "Cash") (value ?cash)))
   (assert (muster-rolls-cash (- ?amount 1))))

(defrule got-material-roll
   (logical (traveller))
   ?m <- (muster-rolls-material ?amount&:(> ?amount 0))
   ?r  <- (roll (name muster-roll material) (roll ?roll))
   (muster-bonus-material ?b)
   (attribute (name "Branch") (value ?branch))
   (table (name "Material Benefits")
          (columns ?columns)
          (rows $?rows))
   =>
   (bind ?column (column-index ?branch ?columns))
   (bind ?row (explode$ (nth$ (+ ?roll ?b) ?rows)))
   (bind ?material (nth$ ?column ?row))
   (retract ?r ?m)
   (if (= (length$ (explode$ ?material)) 0)
      then
      (verbose "No material for roll " ?roll " + " ?b)
      else
      (assert (add (raw-entry ?material) (entry (explode$ ?material))))
      (verbose "Adding material " ?material " with muster roll of " ?roll " + " ?b))
   (assert (muster-rolls-material (- ?amount 1))))

(defrule muster-done
   ?t <- (task mustering-out)
   (muster-rolls-cash 0)
   (muster-rolls-material 0)
   =>
   (retract ?t)
   (assert (task display)))
    
;;;
;;; Display Task
;;;

(deffacts display-task
   (list (name type-order) 
         (values (pack$ character "Characteristics")  
                 (pack$ service "Service")
                 (pack$ skill "Skills") 
                 (pack$ muster "Possessions"))))
            
(defrule display-final-attributes
   (task display)
   (traveller)
   (list (name type-order)
         (values $?types))
   =>
   (foreach ?entry ?types
      (bind ?type (unpack$ ?entry 1))
      (bind ?header (unpack$ ?entry 2))
      (println crlf ?header)
      (bind ?facts (find-all-facts ((?a attribute)) (eq ?a:type ?type)))
      (bind ?facts (sort attribute-> ?facts))
      (foreach ?f ?facts
         (println (fact-slot-value ?f name) ": " (fact-slot-value ?f value))))
   (println))

;;;
;;; Testing
;;;

(deffacts test-rolls
;;;    (test-roll (name enlistment) (rolls 2))
;;;    (test-roll (name draft) (rolls 2))
;;;    (test-roll (name skill-table) (rolls 1 1 1 1 1 1 1 1 1 1 1 1))
;;;    (test-roll (name skill-row) (rolls 4 4 4 4 4 4 4 4 4 4 4 4 4))
;;;    (test-roll (name commission) (rolls 12))
;;;    (test-roll (name promotion) (rolls 12 12 12 12 12 12))
;;;    (test-roll (name survival) (rolls 12 12 12 12 12 12 12))
;;;    (test-roll (name muster-roll material) (rolls 4 5 4 5 4 5))
;;;    (test-roll (name reenlist) (rolls 11 11 11 11 11 11))
;;;    (test-roll (name "Strength") (rolls 2))
;;;    (test-roll (name "Endurance") (rolls 2))
;;;    (test-roll (name "Dexterity") (rolls 2))
;;;    (test-roll (name "Intelligence") (rolls 2))
;;;    (test-roll (name reenlist) (rolls 11 11 11 11 11 11))
)

