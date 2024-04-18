;;;;;;;;;;;;;;;;;;;;;;	Template for patient
(deftemplate person
	(multislot name (type STRING))
	(slot IC)
	(slot age (type INTEGER) (range 0 100))
	(slot gender (type SYMBOL) (allowed-symbols m f))
	(slot fever (type SYMBOL) (allowed-symbols n y))
	(slot fatigue (type SYMBOL) (allowed-symbols n y))
	(slot vomitstomach (type SYMBOL) (allowed-symbols n y))
	(slot dizzy (type SYMBOL) (allowed-symbols n y))
	(slot numb (type SYMBOL) (allowed-symbols n y))
	(slot sleep (type SYMBOL) (allowed-symbols n y))
	(slot light (type SYMBOL) (allowed-symbols n y))
	(slot focus (type SYMBOL) (allowed-symbols n y))
	(slot depression (type SYMBOL) (allowed-symbols n y))
	(slot blurvision (type SYMBOL) (allowed-symbols n y))
	(slot all-no-general (type SYMBOL) (allowed-symbols n y))

	;;;;;;;;;;;;;;;;;Specialised Questions
	;;;;;;;;;;;;;;flu
	(slot flu (type SYMBOL) (allowed-symbols n y)) 
	(slot sorethroat (type SYMBOL) (allowed-symbols n y))
	(slot shiver (type SYMBOL) (allowed-symbols n y))
	(slot ache-joint (type SYMBOL) (allowed-symbols n y))

	;;;;;;;;;;;;;brain hemorrhage
	(slot brain-hemorrhage (type SYMBOL) (allowed-symbols n y))
	(slot high-blood-pressure (type SYMBOL) (allowed-symbols n y))
	(slot swallow (type SYMBOL) (allowed-symbols n y))
	(slot ct-scan-bleed (type SYMBOL) (allowed-symbols n y))

	;;;;;;;;;;;;Dehydration + sorethroat from flu
	(slot dehydration (type SYMBOL) (allowed-symbols n y))
	(slot dry-mouth (type SYMBOL) (allowed-symbols n y))
	(slot dark-urine (type SYMBOL) (allowed-symbols n y))
	(slot active-in-sport (type SYMBOL) (allowed-symbols n y))
	(slot low-blood-pressure (type SYMBOL) (allowed-symbols n y))

	;;;;;;;;;;;;Migraines
	(slot migraine (type SYMBOL) (allowed-symbols n y))
	(slot no-appetite (type SYMBOL) (allowed-symbols n y))
	(slot pale-skin (type SYMBOL) (allowed-symbols n y))
	(slot very-warm-or-cold (type SYMBOL) (allowed-symbols n y))
	(slot skip-meal (type SYMBOL) (allowed-symbols n y))

	;;;;;;;;;;;;Tension headache
	(slot tension-headache (type SYMBOL) (allowed-symbols n y))
	(slot stress (type SYMBOL) (allowed-symbols n y))
	(slot anxiety (type SYMBOL) (allowed-symbols n y))
	(slot not-enough-rest (type SYMBOL) (allowed-symbols n y))
	(slot muscle-ache (type SYMBOL) (allowed-symbols n y))

	;;;;;;;;;;;;Concussion + no-appetite from migraine
	(slot concussion (type SYMBOL) (allowed-symbols n y))
	(slot injury-fall (type SYMBOL) (allowed-symbols n y))
	(slot pupils-different-size (type SYMBOL) (allowed-symbols n y))
	(slot ringing-in-ears (type SYMBOL) (allowed-symbols n y))
	(slot amnesia (type SYMBOL) (allowed-symbols n y))
	(slot lost-consciousness (type SYMBOL) (allowed-symbols n y))

	;;;;;;;;;;;;Stroke
	(slot stroke (type SYMBOL) (allowed-symbols n y))
	(slot confusion (type SYMBOL) (allowed-symbols n y))
	(slot bladder-bowel-control (type SYMBOL) (allowed-symbols n y))
	(slot trouble-walking (type SYMBOL) (allowed-symbols n y))
	(slot face-droop (type SYMBOL) (allowed-symbols n y))
	(slot arm-weak (type SYMBOL) (allowed-symbols n y))
	(slot speech (type SYMBOL) (allowed-symbols n y))

	;;;;;;;;;;;;Brain Tumor + trouble-walking from stroke
	(slot brain-tumor (type SYMBOL) (allowed-symbols n y))
	(slot headache-remedy-fail (type SYMBOL) (allowed-symbols n y))
	(slot ct-scan-tumor (type SYMBOL) (allowed-symbols n y))
	(slot personality-change (type SYMBOL) (allowed-symbols n y))

	;;;;;;;;;;;;Panic Attack
	(slot panic-attack (type SYMBOL) (allowed-symbols n y))
	(slot chest-pain (type SYMBOL) (allowed-symbols n y))
	(slot fear-of-dying (type SYMBOL) (allowed-symbols n y))
	(slot fear-of-losing-control (type SYMBOL) (allowed-symbols n y))
	(slot rapid-heartbeat (type SYMBOL) (allowed-symbols n y))
	(slot shaking-trembling (type SYMBOL) (allowed-symbols n y))
	(slot sweating (type SYMBOL) (allowed-symbols n y))
)

;;;;;;;;;;;;;;;;;;	Patient's Details
(defrule name
	=>
	(printout t crlf "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%" crlf)
	(printout t "               Welcome to Tim & Albert Headache Medical Diagnosis System		" crlf)
	(printout t "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%" crlf crlf crlf crlf)
	(printout t "What is your patient's name?" crlf)
	(printout t "Answer: ")
	(bind ?name (readline))
	
	;;;;;;;; This will capitalize all first letter of the patient
	(bind ?name (str-cat (upcase (sub-string 1 1 ?name)) (sub-string 2 (str-length ?name) ?name)))
			
	(if (eq (type (str-index " " ?name)) INTEGER) then
		(bind ?prename (sub-string 1 (- (str-index " " ?name) 1) ?name))
		(bind ?appname (sub-string (str-index " " ?name) (str-length ?name) ?name))

		(while (eq (type (str-index " " ?appname)) INTEGER)
			(bind ?prename (str-cat ?prename (str-cat (sub-string 1 (str-index " " ?appname) ?appname) (upcase (sub-string (+ 1 (str-index " " ?appname)) (+ 1 (str-index " " ?appname)) ?appname)))))
			(bind ?appname (sub-string (+ 2 (str-index " " ?appname)) (str-length ?appname) ?appname))
		)
		(bind ?name (str-cat ?prename ?appname))
	)
	(assert (name ?name))
)

;;;;;;;;;;;Patient's personal information
(defrule IC
	(name ?name)
	=>
	(printout t crlf "What is "?name"'s National I.C. number?" crlf)
	(printout t "Answer: ")
	(assert (IC (read)))
)

(defrule age
	(name ?name)
	(IC ?ic)
	=>
	(printout t crlf "What is "?name"'s age?" crlf)
	(printout t "Answer: ")
	(bind ?age (read))
	(assert (age ?age))
	
	(if (<= ?age 13) then
		(assert (agecat child))
	else
		(if (>= ?age 60) then
			(assert (agecat eldery))
		else		
			(assert (agecat adult))
		)
	)
)

(defrule gender
	(name ?name)
	(IC ?ic)
	(age ?age)
	(agecat ?agecat)
	=>
	(printout t crlf "What is the gender of "?name" of age "?age" ("?agecat")? (male/female)" crlf)
	(printout t "Answer: ")
	(bind ?gender (lowcase (read)))
	(if (eq ?gender male) then
		(bind ?gender m)
	else
		(if (eq ?gender female) then
			(bind ?fever f)
		)
	)
	(assert (gender ?gender))
	(assert (person (name ?name) (IC ?ic) (age ?age) (gender ?gender)))
)

;;;;;;;;;;;;;;;;;;	General Questions starts :
;;;;;;;;;;;;;;;;;;	General Questions contribute to lesser value in the final probability calculation
(defrule fever
	(not (fever ?))
	?person <- (person (name ?name) (IC ?ic))
	=>
	(printout t crlf "Does "?name" has fever? (yes/no)" crlf)
	(printout t "Answer: ")
	(bind ?fever (lowcase (read)))
	;;;;;;;;;;;;;;;;; This if else will appear in almost every questions to allow the input of yes, YES, y, Y, no, No, n, N to improve user experiences
	(if (eq ?fever yes) then
		(bind ?fever y)
	else
		(if (eq ?fever no) then
			(bind ?fever n)
		)
	)
	(assert (fever ?fever))
	(modify ?person (fever ?fever))
)

(defrule fatigue
	(not (fatigue ?))
	?person <- (person (name ?name) (IC ?ic))
	=>
	(printout t crlf "Does "?name" feels fatigued? (yes/no)" crlf)
	(printout t "Answer: ")
	(bind ?fatigue (lowcase (read)))
	(if (eq ?fatigue yes) then
		(bind ?fatigue y)
	else
		(if (eq ?fatigue no) then
			(bind ?fatigue n)
		)
	)
	(assert (fatigue ?fatigue))
	(modify ?person (fatigue ?fatigue))
)

(defrule vomitstomach
	(not (vomitstomach ?))
	?person <- (person (name ?name) (IC ?ic))
	=>
	(printout t crlf "Does "?name" has vomitting or upset stomach? (yes/no)" crlf)
	(printout t "Answer: ")
	(bind ?vomitstomach (lowcase (read)))
	(if (eq ?vomitstomach yes) then
		(bind ?vomitstomach y)
	else
		(if (eq ?vomitstomach no) then
			(bind ?vomitstomach n)
		)
	)
	(assert (vomitstomach ?vomitstomach))
	(modify ?person (vomitstomach ?vomitstomach))
)

(defrule dizzy
	(not (dizzy ?))
	?person <- (person (name ?name) (IC ?ic))
	=>
	(printout t crlf "Does "?name" has dizziness? (yes/no)" crlf)
	(printout t "Answer: ")
	(bind ?dizzy (lowcase (read)))
	(if (eq ?dizzy yes) then
		(bind ?dizzy y)
	else
		(if (eq ?dizzy no) then
			(bind ?dizzy n)
		)
	)
	(assert (dizzy ?dizzy))
	(modify ?person (dizzy ?dizzy))
)

(defrule numb
	(not (numb ?))
	?person <- (person (name ?name) (IC ?ic))
	=>
	(printout t crlf "Does "?name" feels numbness in parts of body? (yes/no)" crlf)
	(printout t "Answer: ")
	(bind ?numb (lowcase (read)))
	(if (eq ?numb yes) then
		(bind ?numb y)
	else
		(if (eq ?numb no) then
			(bind ?numb n)
		)
	)
	(assert (numb ?numb))
	(modify ?person (numb ?numb))
)

(defrule sleep
	(not (sleep ?))
	?person <- (person (name ?name) (IC ?ic))
	=>
	(printout t crlf "Does "?name" has trouble sleeping? (yes/no)" crlf)
	(printout t "Answer: ")
	(bind ?sleep (lowcase (read)))
	(if (eq ?sleep yes) then
		(bind ?sleep y)
	else
		(if (eq ?sleep no) then
			(bind ?sleep n)
		)
	)
	(assert (sleep ?sleep))
	(modify ?person (sleep ?sleep))
)

(defrule light
	(not (light ?))
	?person <- (person (name ?name) (IC ?ic))
	=>
	(printout t crlf "Does "?name" feels sensitive to light? (yes/no)" crlf)
	(printout t "Answer: ")
	(bind ?light (lowcase (read)))
	(if (eq ?light yes) then
		(bind ?light y)
	else
		(if (eq ?light no) then
			(bind ?light n)
		)
	)
	(assert (light ?light))
	(modify ?person (light ?light))
)

(defrule focus
	(not (focus ?))
	?person <- (person (name ?name) (IC ?ic))
	=>
	(printout t crlf "Does "?name" has trouble focusing? (yes/no)" crlf)
	(printout t "Answer: ")
	(bind ?focus (lowcase (read)))
	(if (eq ?focus yes) then
		(bind ?focus y)
	else
		(if (eq ?focus no) then
			(bind ?focus n)
		)
	)
	(assert (focus ?focus))
	(modify ?person (focus ?focus))
)

(defrule depression
	(not (depression ?))
	?person <- (person (name ?name) (IC ?ic))
	=>
	(printout t crlf "Does "?name" has depression? (yes/no)" crlf)
	(printout t "Answer: ")
	(bind ?depression (lowcase (read)))
	(if (eq ?depression yes) then
		(bind ?depression y)
	else
		(if (eq ?depression no) then
			(bind ?depression n)
		)
	)
	(assert (depression ?depression))
	(modify ?person (depression ?depression))
)

(defrule blurvision
	(not (blurvision ?))
	?person <- (person (name ?name) (IC ?ic))
	=>
	(printout t crlf "Does "?name" has blurred vision? (yes/no)" crlf)
	(printout t "Answer: ")
	(bind ?blurvision (lowcase (read)))
	(if (eq ?blurvision yes) then
		(bind ?blurvision y)
	else
		(if (eq ?blurvision no) then
			(bind ?blurvision n)
		)
	)
	(assert (blurvision ?blurvision))
	(modify ?person (blurvision ?blurvision))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	General Questions end
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	CHECKPOINT: General Questions half way check:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	We will stop the systeme if we have all no replies for the patient

(defrule all-no-general
	(not (all-no-general ?))
	?person <- (person (name ?name) (IC ?ic) (age ?age) (gender ?gender) (fever ?fever) (fatigue ?fatigue) (vomitstomach ?vomitstomach) (dizzy ?dizzy) (numb ?numb) (sleep ?sleep) (light ?light) (focus ?focus) (depression ?depression) (blurvision ?blurvision))
	(test (eq ?fever ?fatigue ?vomitstomach ?dizzy ?numb ?sleep ?light ?focus ?depression ?blurvision n))
	=>
	(printout t crlf crlf "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%" crlf)
	(printout t crlf "Your patient seems to have shown no symptom at all" crlf "It seems that your patient just need some rest for the headache to go away" crlf "Come back if your patient's headache still persist. Goodbye!" crlf crlf "----------------------        Timothy & Albert         	----------------------" crlf)
	(printout t "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%" crlf crlf crlf crlf)
	(bind ?all-no-general n)
	(assert (all-no-general ?all-no-general))
	(modify ?person (all-no-general ?all-no-general))
	(reset)
	(halt)
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		Specialized Questions starts :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		Specialized Questions will contribute to a higher value in final probability calculation

(defrule flu
	(not (flu ?))
	?person <- (person (name ?name) (IC ?ic) (age ?age) (gender ?gender) (fever ?fever) (fatigue ?fatigue) (vomitstomach ?vomitstomach) (dizzy ?dizzy) (numb ?numb) (sleep ?sleep) (light ?light) (focus ?focus) (depression ?depression) (blurvision ?blurvision))
	(or (person (fever y)) (person (fatigue y)) (person (vomitstomach y)))
	=>
	(printout t crlf "Does "?name" has sore throat? (yes/no)" crlf)
	(printout t "Answer: ")
	(bind ?sorethroat (lowcase (read)))
	(if (eq ?sorethroat yes) then
		(bind ?sorethroat y)
	else
		(if (eq ?sorethroat no) then
			(bind ?sorethroat n)
		)
	)
	(modify ?person (sorethroat ?sorethroat))

	(printout t crlf "Is "?name" cold and shivering? (yes/no)" crlf)
	(printout t "Answer: ")
	(bind ?shiver (lowcase (read)))
	(if (eq ?shiver yes) then
		(bind ?shiver y)
	else
		(if (eq ?shiver no) then
			(bind ?shiver n)
		)
	)
	(modify ?person (shiver ?shiver))

	(printout t crlf "Does "?name" has aching joints or limbs? (yes/no)" crlf)
	(printout t "Answer: ")
	(bind ?ache-joint (lowcase (read)))
	(if (eq ?ache-joint yes) then
		(bind ?ache-joint y)
	else
		(if (eq ?ache-joint no) then
			(bind ?ache-joint n)
		)
	)
	(modify ?person (ache-joint ?ache-joint))

	(assert (flu y))
)

(defrule brain-hemorrhage
	(not (brain-hemorrhage ?))
	?person <- (person (name ?name) (IC ?ic) (age ?age) (gender ?gender) (fever ?fever) (fatigue ?fatigue) (vomitstomach ?vomitstomach) (dizzy ?dizzy) (numb ?numb) (sleep ?sleep) (light ?light) (focus ?focus) (depression ?depression) (blurvision ?blurvision))
	(or (person (fever y)) (person (numb y)) (person (blurvision y)))
	=>
	(printout t crlf "Does "?name" has high blood pressure? (yes/no)" crlf)
	(printout t "Answer: ")
	(bind ?high-blood-pressure (lowcase (read)))
	(if (eq ?high-blood-pressure yes) then
		(bind ?high-blood-pressure y)
	else
		(if (eq ?high-blood-pressure no) then
			(bind ?high-blood-pressure n)
		)
	)
	(modify ?person (high-blood-pressure ?high-blood-pressure))

	(printout t crlf "Does "?name" has difficulty in swallowing? (yes/no)" crlf)
	(printout t "Answer: ")
	(bind ?swallow (lowcase (read)))
	(if (eq ?swallow yes) then
		(bind ?swallow y)
	else
		(if (eq ?swallow no) then
			(bind ?swallow n)
		)
	)
	(modify ?person (swallow ?swallow))

	(printout t crlf "Does "?name"'s CT or MRI scan shows possibility of brain bleeding? (yes/no)" crlf)
	(printout t "Answer: ")
	(bind ?ct-scan-bleed (lowcase (read)))
	(if (eq ?ct-scan-bleed yes) then
		(bind ?ct-scan-bleed y)
	else
		(if (eq ?ct-scan-bleed no) then
			(bind ?ct-scan-bleed n)
		)
	)
	(modify ?person (ct-scan-bleed ?ct-scan-bleed))

	(assert (brain-hemorrhage y))
)

(defrule dehydration
	(not (dehydration ?))
	?person <- (person (name ?name) (IC ?ic) (age ?age) (gender ?gender) (fever ?fever) (fatigue ?fatigue) (vomitstomach ?vomitstomach) (dizzy ?dizzy) (numb ?numb) (sleep ?sleep) (light ?light) (focus ?focus) (depression ?depression) (blurvision ?blurvision) (sorethroat ?sorethroat))
	(or (person (fatigue y)) (person (vomitstomach y)) (person (dizzy y)) (person (fever y)))
	=>
	(printout t crlf "Does "?name" has dry mouth? (yes/no)" crlf)
	(printout t "Answer: ")
	(bind ?dry-mouth (lowcase (read)))
	(if (eq ?dry-mouth yes) then
		(bind ?dry-mouth y)
	else
		(if (eq ?dry-mouth no) then
			(bind ?dry-mouth n)
		)
	)
	(modify ?person (dry-mouth ?dry-mouth))

	(printout t crlf "Does "?name" has dark urine? (yes/no)" crlf)
	(printout t "Answer: ")
	(bind ?dark-urine (lowcase (read)))
	(if (eq ?dark-urine yes) then
		(bind ?dark-urine y)
	else
		(if (eq ?dark-urine no) then
			(bind ?dark-urine n)
		)
	)
	(modify ?person (dark-urine ?dark-urine))

	(printout t crlf "Is "?name" active in sports? (yes/no)" crlf)
	(printout t "Answer: ")
	(bind ?active-in-sport (lowcase (read)))
	(if (eq ?active-in-sport yes) then
		(bind ?active-in-sport y)
	else
		(if (eq ?active-in-sport no) then
			(bind ?active-in-sport n)
		)
	)
	(modify ?person (active-in-sport ?active-in-sport))

	(printout t crlf "Does "?name" has low blood pressure? (yes/no)" crlf)
	(printout t "Answer: ")
	(bind ?low-blood-pressure (lowcase (read)))
	(if (eq ?low-blood-pressure yes) then
		(bind ?low-blood-pressure y)
	else
		(if (eq ?low-blood-pressure no) then
			(bind ?low-blood-pressure n)
		)
	)
	(modify ?person (low-blood-pressure ?low-blood-pressure))

	(if (and (neq ?sorethroat y) (neq ?sorethroat n)) then
		(printout t crlf "Does "?name" has sore throat? (yes/no)" crlf)
		(printout t "Answer: ")
		(bind ?sorethroat (lowcase (read)))
		(if (eq ?sorethroat yes) then
			(bind ?sorethroat y)
		else
			(if (eq ?sorethroat no) then
				(bind ?sorethroat n)
			)
		)
		(modify ?person (sorethroat ?sorethroat))
	)

	(assert (dehydration y))
)

(defrule migraine
	(not (migraine ?))
	?person <- (person (name ?name) (IC ?ic) (age ?age) (gender ?gender) (fever ?fever) (fatigue ?fatigue) (vomitstomach ?vomitstomach) (dizzy ?dizzy) (numb ?numb) (sleep ?sleep) (light ?light) (focus ?focus) (depression ?depression) (blurvision ?blurvision))
	(or (and (person (light y)) (person (fatigue y))) (and (person (light y)) (person (dizzy y))) (and (person (light y)) (person (blurvision y))) (and (person (light y)) (person (vomitstomach y))) (and (person (dizzy y)) (person (fatigue y))) (and (person (blurvision y)) (person (fatigue y))) (and (person (vomitstomach y)) (person (fatigue y))) (and (person (dizzy y)) (person (blurvision y))) (and (person (dizzy y)) (person (vomitstomach y))) (and (person (vomitstomach y)) (person (blurvision y))))
	=>
	(printout t crlf "Does "?name" has no appetite? (yes/no)" crlf)
	(printout t "Answer: ")
	(bind ?no-appetite (lowcase (read)))
	(if (eq ?no-appetite yes) then
		(bind ?no-appetite y)
	else
		(if (eq ?no-appetite no) then
			(bind ?no-appetite n)
		)
	)
	(modify ?person (no-appetite ?no-appetite))

	(printout t crlf "Does "?name" has pale skin? (yes/no)" crlf)
	(printout t "Answer: ")
	(bind ?pale-skin (lowcase (read)))
	(if (eq ?pale-skin yes) then
		(bind ?pale-skin y)
	else
		(if (eq ?pale-skin no) then
			(bind ?pale-skin n)
		)
	)
	(modify ?person (pale-skin ?pale-skin))

	(printout t crlf "Is "?name" very warm or cold? (yes/no)" crlf)
	(printout t "Answer: ")
	(bind ?very-warm-or-cold (lowcase (read)))
	(if (eq ?very-warm-or-cold yes) then
		(bind ?very-warm-or-cold y)
	else
		(if (eq ?very-warm-or-cold no) then
			(bind ?very-warm-or-cold n)
		)
	)
	(modify ?person (very-warm-or-cold ?very-warm-or-cold))

	(printout t crlf "Does "?name" recently skipped meals? (yes/no)" crlf)
	(printout t "Answer: ")
	(bind ?skip-meal (lowcase (read)))
	(if (eq ?skip-meal yes) then
		(bind ?skip-meal y)
	else
		(if (eq ?skip-meal no) then
			(bind ?skip-meal n)
		)
	)
	(modify ?person (skip-meal ?skip-meal))

	(assert (migraine y))
)

(defrule tension-headache
	(not (tension-headache ?))
	?person <- (person (name ?name) (IC ?ic) (age ?age) (gender ?gender) (fever ?fever) (fatigue ?fatigue) (vomitstomach ?vomitstomach) (dizzy ?dizzy) (numb ?numb) (sleep ?sleep) (light ?light) (focus ?focus) (depression ?depression) (blurvision ?blurvision))
	(or (and (person (fatigue y)) (person (focus y))) (and (person (light y)) (person (sleep y))) (and (person (fatigue y)) (person (light y))) (and (person (fatigue y)) (person (sleep y))) (and (person (focus y)) (person (light y))) (and (person (focus y)) (person (sleep y))))
	=>
	(printout t crlf "Is "?name" feeling stressful? (yes/no)" crlf)
	(printout t "Answer: ")
	(bind ?stress (lowcase (read)))
	(if (eq ?stress yes) then
		(bind ?stress y)
	else
		(if (eq ?stress no) then
			(bind ?stress n)
		)
	)
	(modify ?person (stress ?stress))

	(printout t crlf "Does "?name" has anxiety? (yes/no)" crlf)
	(printout t "Answer: ")
	(bind ?anxiety (lowcase (read)))
	(if (eq ?anxiety yes) then
		(bind ?anxiety y)
	else
		(if (eq ?anxiety no) then
			(bind ?anxiety n)
		)
	)
	(modify ?person (anxiety ?anxiety))

	(printout t crlf "Does "?name" has enough rest? (yes/no)" crlf)
	(printout t "Answer: ")
	(bind ?not-enough-rest (lowcase (read)))
	(if (eq ?not-enough-rest yes) then
		(bind ?not-enough-rest y)
	else
		(if (eq ?not-enough-rest no) then
			(bind ?not-enough-rest n)
		)
	)
	(modify ?person (not-enough-rest ?not-enough-rest))

	(printout t crlf "Does "?name" has muscle aches? (yes/no)" crlf)
	(printout t "Answer: ")
	(bind ?muscle-ache (lowcase (read)))
	(if (eq ?muscle-ache yes) then
		(bind ?muscle-ache y)
	else
		(if (eq ?muscle-ache no) then
			(bind ?muscle-ache n)
		)
	)
	(modify ?person (muscle-ache ?muscle-ache))

	(assert (tension-headache y))
)

(defrule concussion
	(not (concussion ?))
	?person <- (person (name ?name) (IC ?ic) (age ?age) (gender ?gender) (fever ?fever) (fatigue ?fatigue) (vomitstomach ?vomitstomach) (dizzy ?dizzy) (numb ?numb) (sleep ?sleep) (light ?light) (focus ?focus) (depression ?depression) (blurvision ?blurvision) (no-appetite ?no-appetite))
	(or (and (person (fatigue y)) (person (vomitstomach y))) (and (person (fatigue y)) (person (dizzy y))) (and (person (fatigue y)) (person (light y))) (and (person (fatigue y)) (person (sleep y))) (and (person (fatigue y)) (person (focus y))) (and (person (vomitstomach y)) (person (dizzy y))) (and (person (vomitstomach y)) (person (light y))) (and (person (vomitstomach y)) (person (sleep y))) (and (person (vomitstomach y)) (person (focus y))) (and (person (dizzy y)) (person (light y))) (and (person (dizzy y)) (person (sleep y))) (and (person (dizzy y)) (person (focus y))) (and (person (light y)) (person (sleep y))) (and (person (light y)) (person (focus y))) (and (person (focus y)) (person (sleep y))))
	=>
	(printout t crlf "Does "?name" has any injury from fall? (yes/no)" crlf)
	(printout t "Answer: ")
	(bind ?injury-fall (lowcase (read)))
	(if (eq ?injury-fall yes) then
		(bind ?injury-fall y)
	else
		(if (eq ?injury-fall no) then
			(bind ?injury-fall n)
		)
	)
	(modify ?person (injury-fall ?injury-fall))

	(printout t crlf "Does "?name"'s pupil has different size? (yes/no)" crlf)
	(printout t "Answer: ")
	(bind ?pupils-different-size (lowcase (read)))
	(if (eq ?pupils-different-size yes) then
		(bind ?pupils-different-size y)
	else
		(if (eq ?pupils-different-size no) then
			(bind ?pupils-different-size n)
		)
	)
	(modify ?person (pupils-different-size ?pupils-different-size))

	(printout t crlf "Did "?name" experienced ringing in ears? (yes/no)" crlf)
	(printout t "Answer: ")
	(bind ?ringing-in-ears (lowcase (read)))
	(if (eq ?ringing-in-ears yes) then
		(bind ?ringing-in-ears y)
	else
		(if (eq ?ringing-in-ears no) then
			(bind ?ringing-in-ears n)
		)
	)
	(modify ?person (ringing-in-ears ?ringing-in-ears))

	(printout t crlf "Does "?name" has amnesia? (yes/no)" crlf)
	(printout t "Answer: ")
	(bind ?amnesia (lowcase (read)))
	(if (eq ?amnesia yes) then
		(bind ?amnesia y)
	else
		(if (eq ?amnesia no) then
			(bind ?amnesia n)
		)
	)
	(modify ?person (amnesia ?amnesia))

	(printout t crlf "Did "?name" lost consciousness recently? (yes/no)" crlf)
	(printout t "Answer: ")
	(bind ?lost-consciousness (lowcase (read)))
	(if (eq ?lost-consciousness yes) then
		(bind ?lost-consciousness y)
	else
		(if (eq ?lost-consciousness no) then
			(bind ?lost-consciousness n)
		)
	)
	(modify ?person (lost-consciousness ?lost-consciousness))

	(if (and (neq ?no-appetite y) (neq ?no-appetite n)) then
		(printout t crlf "Does "?name" has no appetite? (yes/no)" crlf)
		(printout t "Answer: ")
		(bind ?no-appetite (lowcase (read)))
		(if (eq ?no-appetite yes) then
			(bind ?no-appetite y)
		else
			(if (eq ?no-appetite no) then
				(bind ?no-appetite n)
			)
		)
		(modify ?person (no-appetite ?no-appetite))
	)

	(assert (concussion y))
)

(defrule stroke
	(not (stroke ?))
	?person <- (person (name ?name) (IC ?ic) (age ?age) (gender ?gender) (fever ?fever) (fatigue ?fatigue) (vomitstomach ?vomitstomach) (dizzy ?dizzy) (numb ?numb) (sleep ?sleep) (light ?light) (focus ?focus) (depression ?depression) (blurvision ?blurvision))
	(or (person (numb y)) (person (depression y)) (person (blurvision y)))
	=>
	(printout t crlf "Does "?name" has trouble speaking and understanding?? (yes/no)" crlf)
	(printout t "Answer: ")
	(bind ?confusion (lowcase (read)))
	(if (eq ?confusion yes) then
		(bind ?confusion y)
	else
		(if (eq ?confusion no) then
			(bind ?confusion n)
		)
	)
	(modify ?person (confusion ?confusion))

	(printout t crlf "Does "?name" has trouble walking? (yes/no)" crlf)
	(printout t "Answer: ")
	(bind ?trouble-walking (lowcase (read)))
	(if (eq ?trouble-walking yes) then
		(bind ?trouble-walking y)
	else
		(if (eq ?trouble-walking no) then
			(bind ?trouble-walking n)
		)
	)
	(modify ?person (trouble-walking ?trouble-walking))

	(printout t crlf "Does "?name" has bladder or bowel control problem? (yes/no)" crlf)
	(printout t "Answer: ")
	(bind ?bladder-bowel-control (lowcase (read)))
	(if (eq ?bladder-bowel-control yes) then
		(bind ?bladder-bowel-control y)
	else
		(if (eq ?bladder-bowel-control no) then
			(bind ?bladder-bowel-control n)
		)
	)
	(modify ?person (bladder-bowel-control ?bladder-bowel-control))

	(if (eq ?gender m) then
		(bind ?heshe he)
	else
		(bind ?heshe she)
	)
	(printout t crlf "Does one side of "?name"'s face droop when "?heshe" tries to smile? (yes/no)" crlf)
	(printout t "Answer: ")
	(bind ?face-droop (lowcase (read)))
	(if (eq ?face-droop yes) then
		(bind ?face-droop y)
	else
		(if (eq ?face-droop no) then
			(bind ?face-droop n)
		)
	)
	(modify ?person (face-droop ?face-droop))

	(printout t crlf "Does "?name"'s arm drift downward when raising both their arms? (yes/no)" crlf)
	(printout t "Answer: ")
	(bind ?arm-weak (lowcase (read)))
	(if (eq ?arm-weak yes) then
		(bind ?arm-weak y)
	else
		(if (eq ?arm-weak no) then
			(bind ?arm-weak n)
		)
	)
	(modify ?person (arm-weak ?arm-weak))

	(assert (stroke y))
)

(defrule brain-tumor
	(not (brain-tumor ?))
	?person <- (person (name ?name) (IC ?ic) (age ?age) (gender ?gender) (fever ?fever) (fatigue ?fatigue) (vomitstomach ?vomitstomach) (dizzy ?dizzy) (numb ?numb) (sleep ?sleep) (light ?light) (focus ?focus) (depression ?depression) (blurvision ?blurvision) (trouble-walking ?trouble-walking))
	(or (person (blurvision y)) (person (numb y)) (person (focus y)))
	=>
	(printout t crlf "Did "?name" applied usual headache remedies but those are not working? (yes/no)" crlf)
	(printout t "Answer: ")
	(bind ?headache-remedy-fail (lowcase (read)))
	(if (eq ?headache-remedy-fail yes) then
		(bind ?headache-remedy-fail y)
	else
		(if (eq ?headache-remedy-fail no) then
			(bind ?headache-remedy-fail n)
		)
	)
	(modify ?person (headache-remedy-fail ?headache-remedy-fail))

	(printout t crlf "Does "?name" CT or MRI scan result shows possible tumor? (yes/no)" crlf)
	(printout t "Answer: ")
	(bind ?ct-scan-tumor (lowcase (read)))
	(if (eq ?ct-scan-tumor yes) then
		(bind ?ct-scan-tumor y)
	else
		(if (eq ?ct-scan-tumor no) then
			(bind ?ct-scan-tumor n)
		)
	)
	(modify ?person (ct-scan-tumor ?ct-scan-tumor))

	(printout t crlf "Did "?name" recently changed personality? (yes/no)" crlf)
	(printout t "Answer: ")
	(bind ?personality-change (lowcase (read)))
	(if (eq ?personality-change yes) then
		(bind ?personality-change y)
	else
		(if (eq ?personality-change no) then
			(bind ?personality-change n)
		)
	)
	(modify ?person (personality-change ?personality-change))

	(if (and (neq ?trouble-walking y) (neq ?trouble-walking n)) then
		(printout t crlf "Does "?name" has trouble walking? (yes/no)" crlf)
		(printout t "Answer: ")
		(bind ?trouble-walking (lowcase (read)))
		(if (eq ?trouble-walking yes) then
			(bind ?trouble-walking y)
		else
			(if (eq ?trouble-walking no) then
				(bind ?trouble-walking n)
			)
		)
		(modify ?person (trouble-walking ?trouble-walking))
	)

	(assert (brain-tumor y))
)