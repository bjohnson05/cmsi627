;;; CLIPS Website
;;; clipsrules.net

;;; CLIPS on SourceForge
;;; sourceforge.net/projects/clipsrules/

;;; Adventures in Rule-Based Programming: A CLIPS Tutorial
;;; clipsrules.net/airbp

;;; Original Headache Diagnosis Source Code
;;; github.com/ttimt96/Headache-Diagnosis-System

(defmodule MAIN (export ?ALL))

;;;
;;; Deftemplates
;;;

(deftemplate person
	(multislot name)
	(slot gender))

(deftemplate symptom 
   (slot name)
   (multislot question)
   (multislot answers))
   
(deftemplate response
   (slot name)
   (slot value))

(deftemplate diagnosis
    (slot name)
    (multislot symptoms-1st)
    (multislot satisfied-1st)
    (slot threshold-1st (default 1))
    (multislot symptoms-2nd)
    (multislot satisfied-2nd)
    (slot rating (default 0.0)))

(deftemplate pronouns
   (slot gender)
   (slot subject)
   (slot object))

;;;
;;; Deffunctions
;;;

(deffunction ask-question (?question $?allowed-values)
  (printout t ?question " " ?allowed-values " ")
  (bind ?answer (read))
  (if (lexemep ?answer)
     then (bind ?answer (lowcase ?answer)))
  (while (not (member$ ?answer ?allowed-values)) do
     (printout t ?question " " ?allowed-values " ")
     (bind ?answer (read))
     (if (lexemep ?answer)
        then (bind ?answer (lowcase ?answer))))
  ?answer)

(deffunction capitalize-words (?name)
   (bind ?rv (create$))
   (foreach ?v (explode$ (lowcase ?name))
      (bind ?nv (sym-cat ?v))
      (bind ?nv (sym-cat (upcase (sub-string 1 1 ?nv)) 
                         (sub-string 2  (str-length ?nv) ?nv)))
      (bind ?rv (create$ ?rv ?nv)))
   (return (implode$ ?rv)))
             
(deffunction format-question (?components ?name ?subject ?object)
    (bind ?question "")
    (foreach ?c ?components
       (switch ?c
          (case <name> 
             then
             (bind ?question (str-cat ?question ?name)))
          (case <he-she> 
             then
             (bind ?question (str-cat ?question ?subject)))
          (case <his-her> 
             then
             (bind ?question (str-cat ?question ?object)))
          (default
             then
             (bind ?question (str-cat ?question ?c)))))
   (return ?question))
   
;;;          
;;; Rules
;;;

(defrule start
   =>
   (focus CHECK-DATA WELCOME 1ST 2ND RATE RESULTS))
   
(defmodule CHECK-DATA (import MAIN ?ALL))

(defrule can't-find-symptom-1
   (symptom (name ?name))
   (not (and (diagnosis (symptoms-1st $?s1) (symptoms-2nd $?s2))
             (test (member$ ?name (create$ ?s1 ?s2)))))
   =>
   (println "Can't find symptom " ?name " in any diagnoses.")
   (halt))
                 
(defrule can't-find-symptom-2
   (or (diagnosis (name ?d) (symptoms-1st $? ?name $?))
       (diagnosis (name ?d) (symptoms-2nd $? ?name $?)))
   (not (symptom (name ?name)))
   =>
   (println "Can't find symptom " ?name " from diagnosis " ?d ".")
   (halt))

(defmodule WELCOME (import MAIN ?ALL))

(defrule welcome
   (not (person))
   =>
   (println)
   (println "Welcome to the Headache Medical Diagnosis System")
   (println))

(defrule name-and-gender
	=>
	(print "Patient's name: ")
	(bind ?name (readline))
	(bind ?gender (ask-question "Patient's gender:" male female))
	(println)
    (assert (person (name (capitalize-words ?name))
                    (gender ?gender))))
    	
(defmodule 1ST (import MAIN ?ALL))

(defrule ask-question-symptoms-1st
   (declare (salience 10)) ; TBD Convert to Modules
   (person (name ?name)
           (gender ?gender))
   (pronouns (gender ?gender)
	         (subject ?subject)
	         (object ?object))
   (symptom (name ?symptom)
            (question $?components)
            (answers $?answers))
   (exists (diagnosis (symptoms-1st $? ?symptom $?)))
   (not (response (name ?symptom)))
   =>
   (bind ?question (format-question ?components ?name ?subject ?object))
   (bind ?response (ask-question ?question ?answers))
   (assert (response (name ?symptom) (value ?response))))

(defrule add-symptom-1st-to-diagnosis
   ?d <- (diagnosis (symptoms-1st $? ?symptom $?)
                    (satisfied-1st $?satisfied&:(not (member$ ?symptom ?satisfied))))
   (response (name ?symptom) (value yes))
   =>
   (modify ?d (satisfied-1st ?satisfied ?symptom)))

(defmodule 2ND (import MAIN ?ALL))

(defrule ask-question-symptoms-2nd
   (person (name ?name)
           (gender ?gender))
   (pronouns (gender ?gender)
	         (subject ?subject)
	         (object ?object))
   (symptom (name ?symptom)
            (question $?components)
            (answers $?answers))
   (exists (diagnosis (threshold-1st ?count)
                      (satisfied-1st $?satisfied&:(>= (length$ ?satisfied) ?count))
                      (symptoms-2nd $? ?symptom $?)))
   (not (response (name ?symptom)))
   =>
   (bind ?question (format-question ?components ?name ?subject ?object))
   (bind ?response (ask-question ?question ?answers))
   (assert (response (name ?symptom) (value ?response))))

(defrule add-symptom-2nd-to-diagnosis
   ?d <- (diagnosis (symptoms-2nd $? ?symptom $?)
                    (satisfied-2nd $?satisfied&:(not (member$ ?symptom ?satisfied))))
   (response (name ?symptom) (value yes))
   =>
   (modify ?d (satisfied-2nd ?satisfied ?symptom)))

(defmodule RATE (import MAIN ?ALL))

(defrule assign-rating
   ?d <- (diagnosis (name ?name)
                    (rating 0.0)
                    (symptoms-1st $?s1)
                    (satisfied-1st $?ss1)
                    (threshold-1st ?t&:(>= (length$ ?ss1) ?t))
                    (symptoms-2nd $?s2)
                    (satisfied-2nd $?ss2))
   =>
   (bind ?count (+ (length$ ?s1) (* 2 (length$ ?s2))))
   (bind ?score (+ (length$ ?ss1) (* 2 (length$ ?ss2))))
   (bind ?rating (/ ?score ?count))
   (modify ?d (rating ?rating)))

(defmodule RESULTS (import MAIN ?ALL))

(deffunction rating-compare (?f1 ?f2)
   (< (fact-slot-value ?f1 rating) (fact-slot-value ?f2 rating)))
      
(defrule no-serious-symptoms
   (not (diagnosis (rating ~0.0)))
   =>
   (println)
   (println "Your patient seems to have no serious symptoms.")
   (println "Recommendation is for rest until the headache goes away.")
   (println))

(defrule output-analysis
   (exists (diagnosis (rating ~0.0)))
   =>
   (println)
   (println "Headache Symptoms Analyzed:")
   (println)
   (bind ?diagnoses (find-all-facts ((?d diagnosis)) (<> ?d:rating 0.0)))
   (bind ?diagnoses (sort rating-compare ?diagnoses))
   (foreach ?d ?diagnoses
      (format t "   %s has a rating of %0.2f%n" 
         (fact-slot-value ?d name) (fact-slot-value ?d rating)))
   (println))

;;;
;;; Deffacts
;;;

(deffacts MAIN::pronouns
   (pronouns (gender male)
             (subject he)
             (object his))
   (pronouns (gender female)
             (subject she)
             (object her)))

(deffacts MAIN::diagnoses
   (diagnosis (name "Flu")
              (symptoms-1st fever fatigue vomit-upset-stomach)
              (threshold-1st 1)
              (symptoms-2nd sore-throat cold-shivering joint-aches))
   (diagnosis (name "Brain hemorrhage")
              (symptoms-1st fever numbness blurred-vision)
              (threshold-1st 1)
              (symptoms-2nd high-blood-pressure difficulty-swallowing
                            brain-bleeding))
   (diagnosis (name "Dehydration")
              (symptoms-1st fever fatigue vomit-upset-stomach dizzy)
              (threshold-1st 1)
              (symptoms-2nd dry-mouth dark-urine active-in-sports
                            low-blood-pressure sore-throat))
   (diagnosis (name "Migraine")
              (symptoms-1st light-sensitivity fatigue dizzy 
                            blurred-vision vomit-upset-stomach)
              (threshold-1st 2)
              (symptoms-2nd no-appetite pale-skin 
                            very-warm-or-cold skipped-meals))
   (diagnosis (name "Tension headache")
              (symptoms-1st fatigue focus light-sensitivity sleep)
              (threshold-1st 2)
              (symptoms-2nd stressed anxiety lack-of-rest muscle-aches))

   (diagnosis (name "Concussion")
              (symptoms-1st fatigue vomit-upset-stomach dizzy light-sensitivity
                             sleep focus)
              (threshold-1st 2)
              (symptoms-2nd injury-from-fall pupils-different-size 
                            ringing-in-ears amnesia loss-of-consciousness
                            no-appetite))
   (diagnosis (name "Stroke")
              (symptoms-1st numbness depression blurred-vision)
              (threshold-1st 1)
              (symptoms-2nd trouble-speaking trouble-walking 
                            bladder-or-bowel-control face-droop 
                            arm-weak))
   (diagnosis (name "Brain tumor")
              (symptoms-1st blurred-vision numbness focus)
              (threshold-1st 1)
              (symptoms-2nd headache-remedies-don't-work scan-shows-tumor
                            changed-personality trouble-walking))
   (diagnosis (name "Panic attack")
              (symptoms-1st dizzy numbness vomit-upset-stomach)
              (threshold-1st 1)
              (symptoms-2nd chest-pain fear-of-dying fear-of-losing-control
                            rapid-heartbeat shaking-or-trembling sweating)))
  
(deffacts MAIN::symptoms-1st
   (symptom (name fever)
            (question "Does " <name> " have a fever?")
            (answers yes no))
   (symptom (name fatigue)
            (question "Does " <name> " feel fatigued?")
            (answers yes no))
   (symptom (name vomit-upset-stomach)
            (question "Does " <name> " have vomiting or an upset stomach?")
            (answers yes no))
   (symptom (name dizzy)
            (question "Does " <name> " have dizziness?")
            (answers yes no))
   (symptom (name numbness)
            (question "Does " <name> " feel numbness in body parts?")
            (answers yes no))
   (symptom (name sleep)
            (question "Does " <name> " have trouble sleeping?")
            (answers yes no))
   (symptom (name light-sensitivity)
            (question "Does " <name> " have light sensitivity?")
            (answers yes no))
   (symptom (name focus)
            (question "Does " <name> " have trouble focusing?")
            (answers yes no))
   (symptom (name depression)
            (question "Does " <name> " have depression?")
            (answers yes no))
   (symptom (name blurred-vision)
            (question "Does " <name> " have blurred vision?")
            (answers yes no)))

(deffacts MAIN::symptoms-2nd
   ;; flu 
   (symptom (name sore-throat)
            (question "Does " <name> " have a sore throat?")
            (answers yes no))
   (symptom (name cold-shivering)
            (question "Is " <name> " cold and shivering?")
            (answers yes no))
   (symptom (name joint-aches)
            (question "Is " <name> " have aching joints or limbs?")
            (answers yes no))
   ;; brain hemorrhage
   (symptom (name high-blood-pressure)
            (question "Is " <name> " have high blood pressure?")
            (answers yes no))
   (symptom (name difficulty-swallowing)
            (question "Does " <name> " have difficulty swallowing?")
            (answers yes no))
   (symptom (name brain-bleeding)
            (question "Does " <name> "'s CT or MRI scan show possibility of brain bleeding?")
            (answers yes no))
   ;; dehydration
   (symptom (name dry-mouth)
            (question "Does " <name> " have a dry mouth?")
            (answers yes no))
   (symptom (name dark-urine)
            (question "Does " <name> " have dark urine?")
            (answers yes no))
   (symptom (name active-in-sports)
            (question "Is " <name> " active in sports?")
            (answers yes no))
   (symptom (name low-blood-pressure)
            (question "Does " <name> " have low blood pressure?")
            (answers yes no))
   ;; migraine
   (symptom (name no-appetite)
            (question "Does " <name> " have no appetite?")
            (answers yes no))
   (symptom (name pale-skin)
            (question "Does " <name> " have pale-skin?")
            (answers yes no))
   (symptom (name very-warm-or-cold)
            (question "Is " <name> " very warm or cold?")
            (answers yes no))
   (symptom (name skipped-meals)
            (question "Has " <name> " recently skipped meals?")
            (answers yes no))
   ;; tension headache
   (symptom (name stressed)
            (question "Is " <name> " under-stress?")
            (answers yes no))
   (symptom (name anxiety)
            (question "Does " <name> " have anxiety?")
            (answers yes no))
   (symptom (name lack-of-rest)
            (question "Has " <name> " had a lack of rest?")
            (answers yes no))
   (symptom (name muscle-aches)
            (question "Does " <name> " have muscle aches?")
            (answers yes no))
   ;; concussion
   (symptom (name injury-from-fall)
            (question "Does " <name> " have any injury from a fall?")
            (answers yes no))
   (symptom (name pupils-different-size)
            (question "Does " <name> " have pupils of different size?")
            (answers yes no))
   (symptom (name ringing-in-ears)
            (question "Does " <name> " experience ringing in ears?")
            (answers yes no))
   (symptom (name amnesia)
            (question "Does " <name> " have amnesia?")
            (answers yes no))
   (symptom (name loss-of-consciousness)
            (question "Did " <name> " lose consciousness recently?")
            (answers yes no))
   (symptom (name no-appetite)
            (question "Does " <name> " have no appetite?")
            (answers yes no))
   ;; stroke
   (symptom (name trouble-speaking)
            (question "Does " <name> " have trouble speaking and understanding?")
            (answers yes no))
   (symptom (name trouble-walking)
            (question "Does " <name> " have trouble walking?")
            (answers yes no))
   (symptom (name bladder-or-bowel-control)
            (question "Does " <name> " have bladder or bowel control problems?")
            (answers yes no))
   (symptom (name face-droop)
            (question "Does one side of " <name> "'s face droop when " <he-she>
                      " tries to smile?")
            (answers yes no))
   (symptom (name arm-weak)
            (question "Does " <name> "'s arm drift downward when raising both " 
                      <his-her> " arms?")
            (answers yes no))
   ;; brain tumor      
   (symptom (name headache-remedies-don't-work)
            (question "Are " <name> "'s usual headache remedies not working?")
            (answers yes no))  
   (symptom (name scan-shows-tumor)
            (question "Does " <name> "'s CT or MRI scans show a possible tumors?")
            (answers yes no))  
   (symptom (name changed-personality)
            (question "Has " <name> "'s personality recently changed?")
            (answers yes no))   
   ;; panic attack
   (symptom (name chest-pain)
            (question "Is " <name> " experiencing chest pain?")
            (answers yes no))
   (symptom (name fear-of-dying)
            (question "Does " <name> " have a fear of dying?")
            (answers yes no))
   (symptom (name fear-of-losing-control)
            (question "Does " <name> " have a fear of losing control?")
            (answers yes no))
   (symptom (name rapid-heartbeat)
            (question "Does " <name> " have a rapid heartbeat?")
            (answers yes no))
   (symptom (name shaking-or-trembling)
            (question "Is " <name> " shaking or trembling?")
            (answers yes no))
   (symptom (name sweating)
            (question "Is " <name> " sweating?")
            (answers yes no)))
