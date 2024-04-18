;;; CLIPS Website
;;; clipsrules.net

;;; CLIPS on SourceForge
;;; sourceforge.net/projects/clipsrules/

;;; Adventures in Rule-Based Programming: A CLIPS Tutorial
;;; clipsrules.net/airbp

;;; Original Headache Diagnosis Source Code
;;; github.com/ttimt96/Headache-Diagnosis-System

;;;
;;; Defglobals
;;;

(defglobal ?*verbose* = FALSE)

;;;
;;; Defclasses
;;;

(defclass Chemical_Element
   (is-a USER)
   (slot Colour
      (type SYMBOL)
      (default none))
	(multislot Attribute
      (type STRING)) 
   (slot Smell
      (type SYMBOL)
      (default none))
   (slot PH
      (type FLOAT)
      (range 0.0 14.0))
   (slot Spectroscopy
      (type SYMBOL)
      (default none))
   (slot Radioactivity
      (type SYMBOL)
      (allowed-values yes no)
      (default no))
   (slot Solubility
      (type SYMBOL)
      (allowed-values yes no))
   (slot Specific_gravity
      (type FLOAT)
      (range 0.9 1.1)
      (default 1.0))
   (slot Name_ch
      (type STRING))
   (slot candidate 
      (type SYMBOL) 
      (allowed-symbols yes no) 
      (default yes)))

(defclass Oil
   (is-a Chemical_Element)
   (slot PH
      (type FLOAT)
      (range 6.0 7.99))
   (slot Solubility
      (type SYMBOL)
      (allowed-values yes no)
      (default no)))

(defclass Base
   (is-a Chemical_Element)
   (slot PH
      (type FLOAT)
      (range 8.0 14.0))
   (slot corrosive
      (type SYMBOL)
      (allowed-values no yes))
   (slot Solubility
      (type SYMBOL)
      (allowed-values yes no)
      (default yes)))

(defclass StrongBase
   (is-a Base)
   (slot PH
      (type FLOAT)
      (range 11.0 14.0))
   (slot corrosive
      (type SYMBOL)
      (allowed-values FALSE TRUE)
      (default TRUE)))

(defclass WeakBase
   (is-a Base)
   (slot PH
      (type FLOAT)
      (range 8.0 10.999))
   (slot corrosive
      (type SYMBOL)
      (allowed-values FALSE TRUE)
      (default FALSE)))

(defclass Acid
   (is-a Chemical_Element)
   (slot PH
      (type FLOAT)
      (range 0.0 5.9))
   (slot corrosive
      (type SYMBOL)
      (allowed-values FALSE TRUE))
   (slot Solubility
      (type SYMBOL)
      (allowed-values yes no)
      (default yes)))

(defclass StrongAcid
   (is-a Acid)
   (slot PH
      (type FLOAT)
      (range 0.0 2.9))
   (slot corrosive
      (type SYMBOL)
      (allowed-values FALSE TRUE)
      (default TRUE)))

(defclass WeakAcid
   (is-a Acid)
   (slot PH
      (type FLOAT)
      (range 3.0 5.9))
   (slot corrosive
      (type SYMBOL)
      (allowed-values FALSE TRUE)
      (default FALSE)))

(defclass Warehouse
   (is-a USER)
   (multislot Elements
      (type INSTANCE)
      (allowed-classes StrongAcid StrongBase Oil WeakBase WeakAcid)
      (cardinality 1 ?VARIABLE))
   (slot Name_ch
      (type STRING))
   (slot candidate 
      (type SYMBOL)
      (allowed-symbols yes no)
      (default yes)))

(defclass Manhole
   (is-a USER)
   (multislot next
      (type INSTANCE)
      (allowed-classes Manhole StationControl))
   (multislot previous
      (type INSTANCE)
      (allowed-classes Manhole Warehouse)
      (cardinality 1 ?VARIABLE))
   (slot Name_ch
      (type STRING))
   (slot candidate 
      (type SYMBOL)
      (allowed-symbols yes no) 
      (default yes)))

(defclass StationControl
   (is-a USER)
   (role concrete)
   (multislot PreviousManholes
      (type INSTANCE)
      (allowed-classes Manhole)
      (cardinality 1 ?VARIABLE)))

;;; Defmessage-handlers

(defmessage-handler Chemical_Element within_class_range (?attribute ?value)
   (bind ?lower (nth$ 1 (slot-range (class ?self) ?attribute)))
   (bind ?upper (nth$ 2 (slot-range (class ?self) ?attribute)))
   (and (or (eq ?lower -oo) (>= ?value ?lower))
        (or (eq ?upper +oo) (<= ?value ?upper))))            

;;;    
;;; Deftemplates
;;;

(deftemplate check
   (multislot manholes))
   
(deftemplate result
   (slot manhole)
   (slot value))
   
(deftemplate response
   (slot attribute)
   (slot value)
   (slot check))
   
(deftemplate question
   (slot id)
   (slot question)
   (multislot answers)
   (slot answer-type)
   (slot attribute)
   (slot match))
             
(deftemplate ask-questions
   (multislot ids))
    
;;;
;;; Deffunctions
;;;

(deffunction apply$ (?function $?values)
   (bind ?rv (create$))
   (foreach ?v ?values
      (bind ?rv (create$ ?rv (funcall ?function ?v))))
   (return ?rv))

(deffunction ask-question-number-in-range (?question ?low ?high)
   (printout t ?question " (" ?low " - " ?high ") ")
   (bind ?answer (read))
   (while (or (not (numberp ?answer))
              (> ?answer ?high)
              (< ?answer ?low)) do
      (printout t ?question " (" ?low " - " ?high ") ")
      (bind ?answer (read)))
   (return ?answer))
   
(deffunction ask-question (?question $?allowed-values)
   (bind ?allowed-values (apply$ lowcase ?allowed-values))
   (printout t ?question " " ?allowed-values " ")
   (bind ?answer (read))
   (if (lexemep ?answer) 
       then (bind ?answer (lowcase ?answer)))
   (while (not (member$ ?answer ?allowed-values)) do
      (printout t ?question " " ?allowed-values " ")
      (bind ?answer (read))
      (if (lexemep ?answer) 
         then (bind ?answer (lowcase ?answer))))
   (return ?answer))
   
(deffunction check-multi-response (?responses ?allowed-values)
   (bind ?errors FALSE)
   (foreach ?r ?responses
      (if (not (member$ ?r ?allowed-values))
         then
         (println ?r " is not a valid response")
         (bind ?errors TRUE)))
   (if ?errors
      then
      (return FALSE)
      else
      (return ?responses)))

(deffunction lowcase-lexeme (?v)
   (if (lexemep ?v)
      then
      (return (lowcase ?v))
      else
      (return ?v)))
      
(deffunction ask-question-multi-response (?question $?allowed-values)
   (bind ?allowed-values (apply$ lowcase-lexeme ?allowed-values))
   (printout t ?question " " ?allowed-values " ")
   (bind ?answer (apply$ lowcase-lexeme (explode$ (readline))))
   (while (not (check-multi-response ?answer ?allowed-values)) do
      (printout t ?question " " ?allowed-values " ")
      (bind ?answer (apply$ lowcase-lexeme (explode$ (readline)))))
   (return ?answer))
   
(deffunction instance-collect$ (?instances ?class ?slot ?value)
   (bind ?rv (create$))
   (foreach ?i ?instances
      (if (and (or (eq ?class (class ?i))
                   (member$ ?class (class-superclasses (class ?i) inherit)))
               (eq (send ?i (sym-cat get- ?slot)) ?value))
         then
         (bind ?rv (create$ ?rv ?i))))
   (return ?rv))
   
;;;
;;; Defrules
;;;

(defrule asking_for_metrics
   =>
   (bind ?answer 
      (ask-question-multi-response 
         "For which measurements will values be given?"
         pH solubility spectroscopy colour smell specific_gravity radioactivity))
   (assert (ask-questions (ids ?answer))))

(defrule ask-answer-type-symbol-question
   ?a <- (ask-questions (ids $?b ?id $?e))
   (question (id ?id)
             (question ?question)
             (answers $?answers)
             (answer-type symbol)
             (attribute ?attribute)
             (match ?match))
   =>
   (modify ?a (ids ?b ?e))
   (bind ?response (ask-question ?question ?answers))
   (assert (response (attribute ?attribute) (check ?match) (value ?response))))

(defrule ask-answer-type-number-question
   ?a <- (ask-questions (ids $?b ?id $?e))
   (question (id ?id)
             (question ?question)
             (answers ?low ?high)
             (answer-type number-in-range)
             (attribute ?attribute)
             (match ?match))
   =>
   (modify ?a (ids ?b ?e))
   (bind ?response (ask-question-number-in-range ?question ?low ?high))
   (assert (response (attribute ?attribute) (check ?match) (value ?response))))

(defrule slot-within-class-range
   (response (attribute ?attribute) 
             (check class-in-range)
             (value ?value))
   (object (is-a Chemical_Element)
           (name ?x)
           (Name_ch ?name)
           (candidate yes))
   (test (not (send ?x within_class_range ?attribute ?value)))             
   =>   
   (if ?*verbose*
      then
      (println "Eliminating " ?name "."))
   (modify-instance ?x (candidate no)))
 
(defrule slot-match
   (response (attribute ?attribute)
             (check slot-match)
             (value ?value))
   (object (is-a Chemical_Element)    
           (name ?x)
           (Name_ch ?name)
           (candidate yes))
   (test (or (and (not (numberp ?value))
                  (neq ?value (send ?x (sym-cat get- ?attribute))))
             (and (numberp ?value)       
                  (<> ?value (send ?x (sym-cat get- ?attribute))))))
   =>   
   (if ?*verbose*
      then
      (println "Eliminating " ?name "."))
   (modify-instance ?x (candidate no)))

(defrule warehouse-not-candidate
   (declare (salience 10))
   (object (is-a Warehouse)
	       (name ?x)
	       (Name_ch ?name)
	       (candidate yes)
	       (Elements $?list))
   (not (object (is-a Chemical_Element)
                (name ?ce&:(member$ ?ce ?list))
                (candidate yes)))
   =>	
   (if ?*verbose*
      then
      (println "Eliminating " ?name "."))
   (modify-instance ?x (candidate no)))

(defrule manhole-not-candidate
   (declare (salience 10))
   (object (is-a Manhole)
           (name ?x)
           (Name_ch ?name)
           (candidate yes)
           (previous $?list))
   (not (object (name ?ce&:(member$ ?ce ?list))
                (candidate yes)))
   =>	
   (if ?*verbose*
      then
      (println "Eliminating " ?name "."))
   (modify-instance ?x (candidate no)))

(defrule propagate-not-candidate
   (declare (salience 10))
   (object (is-a Manhole)
           (name ?x)
           (candidate no)
           (previous $?list))
   (object (name ?ce&:(member$ ?ce ?list))
           (Name_ch ?name)
           (candidate yes))
   =>	
   (if ?*verbose*
      then
      (println "Eliminating " ?name "."))
   (modify-instance ?ce (candidate no)))

(defrule start-at-station-control
   (declare (salience -10))
   (object (is-a StationControl)
	       (PreviousManholes $?list))
   =>	
   (bind ?list (instance-collect$ ?list Manhole candidate yes))
   (assert (check (manholes ?list))))

(defrule run-test-manhole
   (check (manholes ?manhole ?next $?rest))
   (not (result (manhole ?manhole)))
   (object (is-a Manhole)
           (name ?manhole)
           (Name_ch ?name_ch))
   =>
   (bind ?answer (ask-question (str-cat "Is there contamination at " ?name_ch "?") 
                 yes no))
   (assert (result (manhole ?manhole) (value ?answer))))

(defrule assume-only-one-positive
   (check (manholes ?manhole))
   (not (result (manhole ?manhole)))
   (object (is-a Manhole)
           (name ?manhole)           
           (previous $?list)
           (candidate yes))
   =>
   (bind ?list (instance-collect$ ?list Manhole candidate yes))
   (assert (check (manholes ?list))))

(defrule positive-test-result-1
   ?c <- (check (manholes ?manhole ?next $?rest))
   (result (manhole ?manhole) (value yes))
   ?o <- (object (is-a Manhole)
                 (name ?next)
                 (candidate yes))
   =>
   (modify ?c (manholes ?manhole ?rest))
   (modify-instance ?o (candidate no)))

(defrule positive-test-result-2
   ?c <- (check (manholes ?manhole ?next $?rest))
   (result (manhole ?manhole) (value yes))
   (object (is-a Manhole)
           (name ?next)
           (candidate no))
   =>
   (modify ?c (manholes ?manhole ?rest)))

(defrule positive-test-result-3
   ?c <- (check (manholes ?manhole))
   (result (manhole ?manhole) (value yes))
   (object (is-a Manhole)
           (name ?manhole)
           (previous $?list)
           (candidate yes))
   =>
   (bind ?list (instance-collect$ ?list Manhole candidate yes))
   (assert (check (manholes ?list))))

(defrule negative-test-result-1
   ?c <- (check (manholes ?manhole ?next $?rest))
   (result (manhole ?manhole) (value no))
   ?o <- (object (is-a Manhole)
                 (name ?manhole)
                 (candidate yes))
   =>
   (modify ?c (manholes ?next ?rest))
   (modify-instance ?o (candidate no)))
   
(defrule all-contaminants-eliminated
   (not (object (is-a Warehouse)
                (candidate yes)))
   =>
   (println "All warehouses have been eliminated as the source of the contaminant.")
   (halt))

(defrule find-contaminate-in-warehouse
   (object (is-a Warehouse)
           (name ?name)
           (Name_ch ?warehouse)
           (Elements $?list)
           (candidate yes))
   (not (object (is-a Warehouse)
                (name ~?name)
                (candidate yes)))
   (ask-questions (ids))
   =>
   (printout t "The source of contamination is " ?warehouse "." crlf)
   (bind ?list (instance-collect$ ?list Chemical_Element candidate yes))
   (foreach ?r $?list
      (println "   The contaminate could be " 
               (send ?r get-Name_ch) ".")
      (bind $?attributes (send ?r get-Attribute))
      (if (> (length$ ?attributes) 0)
         then
         (println "   Potential risks: ")
         (foreach ?a ?attributes (println "      " ?a)))))

;;;
;;; Deffacts
;;;
   
(deffacts questions
   (question (id ph)
             (question "What is the pH?")
             (answers 0 14)
             (answer-type number-in-range)
             (attribute PH)
             (match class-in-range))
   (question (id solubility)
             (question "Is it soluble?")
             (answers yes no)
             (answer-type symbol)
             (attribute Solubility)
             (match slot-match))
   (question (id spectroscopy)
             (question "What is the spectroscopy?")
             (answers none carbon sulphur metal sodium)
             (answer-type symbol)
             (attribute Spectroscopy)
             (match slot-match))
   (question (id colour)
             (question "What is the color?")
             (answers none white red)
             (answer-type symbol)
             (attribute Colour)
             (match slot-match))
   (question (id smell)
             (question "What is the smell?")
             (answers none choking vinegar)
             (answer-type symbol)
             (attribute Smell)
             (match slot-match))
   (question (id smell)
             (question "What is the smell?")
             (answers none choking vinegar)
             (answer-type symbol)
             (attribute Smell)
             (match slot-match))
   (question (id specific_gravity)
             (question "What is the specific gravity?")
             (answers 0.9 1.1)
             (answer-type number-in-range)
             (attribute Specific_gravity)
             (match slot-match))
   (question (id radioactivity)
             (question "What is the radioactivity?")
             (answers yes no)
             (answer-type symbol)
             (attribute Radioactivity)
             (match slot-match)))

;;;    
;;; Definstances
;;;

(definstances chemicals
   ([sulphuric_acid] of  StrongAcid
       (Attribute "skin burns")
       (Colour none)
       (corrosive TRUE)
       (Name_ch "sulphuric acid")
       (Radioactivity no)
       (Smell none)
       (Solubility yes)
       (Specific_gravity 1.0)
       (Spectroscopy sulphur))
   ([hydrochloric_acid] of  StrongAcid
       (Attribute
           "skin burns"
           "asphyxiation")
       (Colour none)
       (corrosive TRUE)
       (Name_ch "Hydrochloric acid")
       (Radioactivity no)
       (Smell choking)
       (Solubility yes)
       (Specific_gravity 1.0)
       (Spectroscopy none))
   ([acetic_acid] of  WeakAcid
       (Colour none)
       (Name_ch "acetic acid")
       (Radioactivity yes)
       (Smell vinegar)
       (Solubility yes)
       (Specific_gravity 1.0)
       (Spectroscopy none))
   ([carbonic_acid] of  WeakAcid
       (Colour none)
       (Name_ch "carbonic acid")
       (Radioactivity no)
       (Smell none)
       (Solubility yes)
       (Specific_gravity 1.0)
       (Spectroscopy carbon))
   ([sodium_hydroxide] of  StrongBase
       (Colour none)
       (corrosive TRUE)
       (Name_ch "sodium hydroxide")
       (Radioactivity no)
       (Smell none)
       (Solubility yes)
       (Specific_gravity 1.0)
       (Spectroscopy sodium))
   ([chromogen_23] of  WeakBase
       (Colour red)
       (corrosive FALSE)
       (Name_ch "chromogen 23")
       (Radioactivity no)
       (Smell none)
       (Solubility yes)
       (Specific_gravity 0.9)
       (Spectroscopy none))
   ([aluminum_hydroxide] of  WeakBase
       (Colour white)
       (corrosive FALSE)
       (Name_ch "aluminium hydroxide")
       (Radioactivity no)
       (Smell none)
       (Solubility yes)
       (Specific_gravity 1.02)
       (Spectroscopy metal))
   ([rubidium_hydroxide] of  WeakBase
       (Colour none)
       (corrosive FALSE)
       (Name_ch "rubidium hydroxide")
       (Radioactivity yes)
       (Smell none)
       (Solubility yes)
       (Specific_gravity 1.02)
       (Spectroscopy metal))
   ([petrol] of  Oil
       (Attribute "explosive")
       (Colour none)
       (Name_ch "petrol")
       (Radioactivity yes)
       (Smell none)
       (Solubility no)
       (Specific_gravity 0.9)
       (Spectroscopy carbon))
   ([transformer_oil] of  Oil
       (Attribute "highly toxic PCBs")
       (Colour none)
       (Name_ch "transformer oil")
       (Radioactivity no)
       (Smell none)
       (Solubility no)
       (Specific_gravity 1.0)
       (Spectroscopy carbon))
   ([warehouse_1] of  Warehouse
       (Elements
           [sulphuric_acid]
           [petrol])
       (Name_ch "warehouse 1"))
   ([warehouse_2] of  Warehouse
       (Elements
           [hydrochloric_acid]
           [acetic_acid])
       (Name_ch "warehouse 2"))
   ([warehouse_3] of  Warehouse
       (Elements
           [rubidium_hydroxide]
           [transformer_oil])
       (Name_ch "warehouse 3"))
   ([warehouse_4] of  Warehouse
       (Elements
           [carbonic_acid]
           [acetic_acid]
           [petrol])
       (Name_ch "warehouse 4"))
   ([warehouse_5] of  Warehouse
       (Elements
           [chromogen_23]
           [sulphuric_acid]
           [petrol])
       (Name_ch "warehouse 5"))
   ([warehouse_6] of  Warehouse
       (Elements
           [aluminum_hydroxide]
           [transformer_oil]
           [carbonic_acid])
       (Name_ch "warehouse 6"))
   ([warehouse_7] of  Warehouse
       (Elements
           [hydrochloric_acid]
           [sulphuric_acid])
       (Name_ch "warehouse 7"))
   ([warehouse_8] of  Warehouse
       (Elements
           [acetic_acid]
           [carbonic_acid]
           [sodium_hydroxide])
       (Name_ch "warehouse 8"))
   ([manhole_1] of  Manhole
       (Name_ch "manhole 1")
       (next [manhole_9])
       (previous [warehouse_1]))
   ([manhole_2] of  Manhole
       (Name_ch "manhole 2")
       (next [manhole_9])
       (previous [warehouse_2]))
   ([manhole_3] of  Manhole
       (Name_ch "manhole 3")
       (next [manhole_9])
       (previous [warehouse_3]))
   ([manhole_4] of  Manhole
       (Name_ch "manhole 4")
       (next [manhole_10])
       (previous [warehouse_4]))
   ([manhole_5] of  Manhole
       (Name_ch "manhole 5")
       (next [manhole_10])
       (previous [warehouse_5]))
   ([manhole_6] of  Manhole
       (Name_ch "manhole 6")
       (next [manhole_11])
       (previous [warehouse_6]))
   ([manhole_7] of  Manhole
       (Name_ch "manhole 7")
       (next [manhole_11])
       (previous [warehouse_7]))
   ([manhole_8] of  Manhole
       (Name_ch "manhole 8")
       (next [manhole_13])
       (previous [warehouse_8]))
   ([manhole_9] of  Manhole
       (Name_ch "manhole 9")
       (next [manhole_12])
       (previous
           [manhole_1]
           [manhole_2]
           [manhole_3]))
   ([manhole_10] of  Manhole
       (Name_ch "manhole 10")
       (next [manhole_12])
       (previous
           [manhole_4]
           [manhole_5]))
   ([manhole_11] of  Manhole
       (Name_ch "manhole 11")
       (next [manhole_13])
       (previous
           [manhole_6]
           [manhole_7]))
   ([manhole_12] of  Manhole
       (Name_ch "manhole 12")
       (next [station_control])
       (previous
           [manhole_10]
           [manhole_9]))
   ([manhole_13] of  Manhole
       (Name_ch "manhole 13")
       (next [station_control])
       (previous
           [manhole_11]
           [manhole_8]))
   ([station_control] of StationControl
       (PreviousManholes
           [manhole_12]
           [manhole_13])))
