;;;;;;;;;;;;;;;;;Disease: Panic attack specified questions
(defrule panic-attack
	(not (panic-attack ?))
	?person <- (person (name ?name) (IC ?ic) (age ?age) (gender ?gender) (fever ?fever) (fatigue ?fatigue) (vomitstomach ?vomitstomach) (dizzy ?dizzy) (numb ?numb) (sleep ?sleep) (light ?light) (focus ?focus) (depression ?depression) (blurvision ?blurvision) (trouble-walking ?trouble-walking))
	(or (person (dizzy y)) (person (numb y)) (person (vomitstomach y)))
	=>
	(printout t crlf "Did "?name" experienced chest pain? (yes/no)" crlf)
	(printout t "Answer: ")
	(bind ?chest-pain (lowcase (read)))
	(if (eq ?chest-pain yes) then
		(bind ?chest-pain y)
	else
		(if (eq ?chest-pain no) then
			(bind ?chest-pain n)
		)
	)
	(modify ?person (chest-pain ?chest-pain))

	(printout t crlf "Does "?name" has fear of dying? (yes/no)" crlf)
	(printout t "Answer: ")
	(bind ?fear-of-dying (lowcase (read)))
	(if (eq ?fear-of-dying yes) then
		(bind ?fear-of-dying y)
	else
		(if (eq ?fear-of-dying no) then
			(bind ?fear-of-dying n)
		)
	)
	(modify ?person (fear-of-dying ?fear-of-dying))

	(printout t crlf "Does "?name" has fear of losing control? (yes/no)" crlf)
	(printout t "Answer: ")
	(bind ?fear-of-losing-control (lowcase (read)))
	(if (eq ?fear-of-losing-control yes) then
		(bind ?fear-of-losing-control y)
	else
		(if (eq ?fear-of-losing-control no) then
			(bind ?fear-of-losing-control n)
		)
	)
	(modify ?person (fear-of-losing-control ?fear-of-losing-control))

	(printout t crlf "Does "?name" has rapid heartbeat? (yes/no)" crlf)
	(printout t "Answer: ")
	(bind ?rapid-heartbeat (lowcase (read)))
	(if (eq ?rapid-heartbeat yes) then
		(bind ?rapid-heartbeat y)
	else
		(if (eq ?rapid-heartbeat no) then
			(bind ?rapid-heartbeat n)
		)
	)
	(modify ?person (rapid-heartbeat ?rapid-heartbeat))

	(printout t crlf "Is "?name" shaking or trembling? (yes/no)" crlf)
	(printout t "Answer: ")
	(bind ?shaking-trembling (lowcase (read)))
	(if (eq ?shaking-trembling yes) then
		(bind ?shaking-trembling y)
	else
		(if (eq ?shaking-trembling no) then
			(bind ?shaking-trembling n)
		)
	)
	(modify ?person (shaking-trembling ?shaking-trembling))

	(printout t crlf "Does "?name" has sweating? (yes/no)" crlf)
	(printout t "Answer: ")
	(bind ?sweating (lowcase (read)))
	(if (eq ?sweating yes) then
		(bind ?sweating y)
	else
		(if (eq ?sweating no) then
			(bind ?sweating n)
		)
	)
	(modify ?person (sweating ?sweating))

	(assert (panic-attack y))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;		Final: Calculate Probability
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defrule calculate-result
	(not (sickness ? ?))
	(not (calculation ?))
	?person <- (person (name ?name) (IC ?ic) (age ?age) (gender ?gender) (fever ?fever) (fatigue ?fatigue) (vomitstomach ?vomitstomach) (dizzy ?dizzy) (numb ?numb) (sleep ?sleep) (light ?light) (focus ?focus) (depression ?depression) (blurvision ?blurvision) (sorethroat ?sorethroat) (shiver ?shiver) (ache-joint ?ache-joint) (high-blood-pressure ?high-blood-pressure) (swallow ?swallow) (ct-scan-bleed ?ct-scan-bleed) (dry-mouth ?dry-mouth) (dark-urine ?dark-urine) (active-in-sport ?active-in-sport) (low-blood-pressure ?low-blood-pressure)  (no-appetite ?no-appetite) (pale-skin ?pale-skin) (very-warm-or-cold ?very-warm-or-cold) (skip-meal ?skip-meal) (stress ?stress) (anxiety ?anxiety) (not-enough-rest ?not-enough-rest) (muscle-ache ?muscle-ache) (injury-fall ?injury-fall) (pupils-different-size ?pupils-different-size) (ringing-in-ears ?ringing-in-ears) (amnesia ?amnesia) (lost-consciousness ?lost-consciousness) (bladder-bowel-control ?bladder-bowel-control) (trouble-walking ?trouble-walking) (face-droop ?face-droop) (arm-weak ?arm-weak) (speech ?speech) (headache-remedy-fail ?headache-remedy-fail) (ct-scan-tumor ?ct-scan-tumor) (personality-change ?personality-change) (chest-pain ?chest-pain) (fear-of-dying ?fear-of-dying) (fear-of-losing-control ?fear-of-losing-control) (rapid-heartbeat ?rapid-heartbeat) (shaking-trembling ?shaking-trembling) (sweating ?sweating))
	=>
	;;;;;;;;;;;;;;Set all initial values with 0
	(bind ?flu 0)
	(bind ?brain-hemorrhage 0)
	(bind ?dehydration 0)
	(bind ?migraine 0)
	(bind ?tension-headache 0)
	(bind ?concussion 0)
	(bind ?stroke 0)
	(bind ?brain-tumor 0)
	(bind ?panic-attack 0)

	;;;;;;;;;;;;;;;;Calculate general questions and scores
	(if (eq ?fever y) then
		(bind ?flu (+ ?flu 1))
		(bind ?brain-hemorrhage (+ ?brain-hemorrhage 1))
		(bind ?dehydration (+ ?dehydration 1))
	)

	(if (eq ?fatigue y) then
		(bind ?flu (+ ?flu 1))
		(bind ?migraine (+ ?migraine 1))
		(bind ?dehydration (+ ?dehydration 1))
		(bind ?tension-headache (+ ?tension-headache 1))
		(bind ?concussion (+ ?concussion 1))
	)

	(if (eq ?vomitstomach y) then
		(bind ?flu (+ ?flu 1))
		(bind ?concussion (+ ?concussion 1))
		(bind ?migraine (+ ?migraine 1))
		(bind ?dehydration (+ ?dehydration 1))
		(bind ?panic-attack (+ ?panic-attack 1))
	)

	(if (eq ?dizzy y) then
		(bind ?migraine (+ ?migraine 1))
		(bind ?concussion (+ ?concussion 1))
		(bind ?dehydration (+ ?dehydration 1))
		(bind ?panic-attack (+ ?panic-attack 1))
	)

	(if (eq ?numb y) then
		(bind ?brain-hemorrhage (+ ?brain-hemorrhage 1))
		(bind ?stroke (+ ?stroke 1))
		(bind ?brain-tumor (+ ?brain-tumor 1))
		(bind ?panic-attack (+ ?panic-attack 1))
	)

	(if (eq ?sleep y) then
		(bind ?tension-headache (+ ?tension-headache 1))
		(bind ?concussion (+ ?concussion 1))
	)

	(if (eq ?light y) then
		(bind ?tension-headache (+ ?tension-headache 1))
		(bind ?concussion (+ ?concussion 1))
		(bind ?migraine (+ ?migraine 1))
	)

	(if (eq ?focus y) then
		(bind ?tension-headache (+ ?tension-headache 1))
		(bind ?concussion (+ ?concussion 1))
		(bind ?brain-tumor (+ ?brain-tumor 1))
	)

	(if (eq ?depression y) then
		(bind ?stroke (+ ?stroke 1))
	)

	(if (eq ?blurvision y) then
		(bind ?stroke (+ ?stroke 1))
		(bind ?migraine (+ ?migraine 1))
		(bind ?brain-tumor (+ ?brain-tumor 1))
	)

	;;;;;;;;;;Calculation for specific questions
	(if (eq ?sorethroat y) then
		(bind ?flu (+ ?flu 2))
		(bind ?dehydration (+ ?dehydration 2))
	)

	(if (eq ?shiver y) then
		(bind ?flu (+ ?flu 2))
	)

	(if (eq ?ache-joint y) then
		(bind ?flu (+ ?flu 2))
	)

	(if (eq ?high-blood-pressure y) then
		(bind ?brain-hemorrhage (+ ?brain-hemorrhage 2))
	)

	(if (eq ?swallow y) then
		(bind ?brain-hemorrhage (+ ?brain-hemorrhage 2))
	)

	(if (eq ?ct-scan-bleed y) then
		(bind ?brain-hemorrhage (+ ?brain-hemorrhage 2))
	)

	(if (eq ?dry-mouth y) then
		(bind ?dehydration (+ ?dehydration 2))
	)

	(if (eq ?dark-urine y) then
		(bind ?dehydration (+ ?dehydration 2))
	)

	(if (eq ?active-in-sport y) then
		(bind ?dehydration (+ ?dehydration 2))
	)

	(if (eq ?low-blood-pressure y) then
		(bind ?dehydration (+ ?dehydration 2))
	)

	(if (eq ?no-appetite y) then
		(bind ?migraine (+ ?migraine 2))
		(bind ?concussion (+ ?concussion 2))
	)
	
	(if (eq ?pale-skin y) then
		(bind ?migraine (+ ?migraine 2))
	)

	(if (eq ?very-warm-or-cold y) then
		(bind ?migraine (+ ?migraine 2))
	)

	(if (eq ?skip-meal y) then
		(bind ?migraine (+ ?migraine 2))
	)

	(if (eq ?stress y) then
		(bind ?tension-headache (+ ?tension-headache 2))
	)

	(if (eq ?anxiety y) then
		(bind ?tension-headache (+ ?tension-headache 2))
	)

	(if (eq ?not-enough-rest y) then
		(bind ?tension-headache (+ ?tension-headache 2))
	)

	(if (eq ?muscle-ache y) then
		(bind ?tension-headache (+ ?tension-headache 2))
	)

	(if (eq ?injury-fall y) then
		(bind ?concussion (+ ?concussion 2))
	)

	(if (eq ?pupils-different-size y) then
		(bind ?concussion (+ ?concussion 2))
	)

	(if (eq ?ringing-in-ears y) then
		(bind ?concussion (+ ?concussion 2))
	)

	(if (eq ?amnesia y) then
		(bind ?concussion (+ ?concussion 2))
	)

	(if (eq ?lost-consciousness y) then
		(bind ?concussion (+ ?concussion 2))
	)

	(if (eq ?bladder-bowel-control y) then
		(bind ?stroke (+ ?stroke 2))
	)

	(if (eq ?trouble-walking y) then
		(bind ?stroke (+ ?stroke 2))
		(bind ?brain-tumor (+ ?brain-tumor 2))
	)

	(if (eq ?face-droop y) then
		(bind ?stroke (+ ?stroke 2))
	)

	(if (eq ?arm-weak y) then
		(bind ?stroke (+ ?stroke 2))
	)

	(if (eq ?speech y) then
		(bind ?stroke (+ ?stroke 2))
	)

	(if (eq ?headache-remedy-fail y) then
		(bind ?brain-tumor (+ ?brain-tumor 2))
	)

	(if (eq ?ct-scan-tumor y) then
		(bind ?brain-tumor (+ ?brain-tumor 2))
	)

	(if (eq ?personality-change y) then
		(bind ?brain-tumor (+ ?brain-tumor 2))
	)

	(if (eq ?panic-attack y) then
		(bind ?panic-attack (+ ?panic-attack 2))
	)

	(if (eq ?chest-pain y) then
		(bind ?panic-attack (+ ?panic-attack 2))
	)

	(if (eq ?fear-of-dying y) then
		(bind ?panic-attack (+ ?panic-attack 2))
	)

	(if (eq ?fear-of-losing-control y) then
		(bind ?panic-attack (+ ?panic-attack 2))
	)

	(if (eq ?rapid-heartbeat y) then
		(bind ?panic-attack (+ ?panic-attack 2))
	)

	(if (eq ?shaking-trembling y) then
		(bind ?panic-attack (+ ?panic-attack 2))
	)

	(if (eq ?sweating y) then
		(bind ?panic-attack (+ ?panic-attack 2))
	)

	;;;;; Divide to get probability
	(if (> ?flu 0) then
		(bind ?flu (/ ?flu 6))
	)
	(if (> ?brain-hemorrhage 0) then
		(bind ?brain-hemorrhage (/ ?brain-hemorrhage 6))
	)
	(if (> ?dehydration 0) then
		(bind ?dehydration (/ ?dehydration 9))
	)
	(if (> ?migraine 0) then
		(bind ?migraine (/ ?migraine 9))
	)
	(if (> ?tension-headache 0) then
		(bind ?tension-headache (/ ?tension-headache 8))
	)
	(if (> ?concussion 0) then
		(bind ?concussion (/ ?concussion 12))
	)
	(if (> ?stroke 0) then
		(bind ?stroke (/ ?stroke 8))
	)
	(if (> ?brain-tumor 0) then
		(bind ?brain-tumor (/ ?brain-tumor 7))
	)
	(if (> ?panic-attack 0) then
		(bind ?panic-attack (/ ?panic-attack 9))
	)

	;;;;;;;;;;;;;;;;;; STore all of them as facts in database
	(assert (sickness flu ?flu))
	(assert (sickness brain-hemorrhage ?brain-hemorrhage))
	(assert (sickness dehydration ?dehydration))
	(assert (sickness migraine ?migraine))
	(assert (sickness tension-headache ?tension-headache))
	(assert (sickness concussion ?concussion))
	(assert (sickness stroke ?stroke))
	(assert (sickness brain-tumor ?brain-tumor))
	(assert (sickness panic-attack ?panic-attack))
	(assert (calculation done))
	(printout t crlf "Headache Symptom Analyzed:" crlf)
)

;;;;;;;;Output sorted results
(defrule output-result
	?u <- (sickness ?name ?rating)
	(sickness ?name ?rating)
	(forall (sickness ?n ?r)
		(test (<= ?r ?rating))
	)
	=>
	(retract ?u)
	(printout t ?name " has rating of " ?rating "." crlf)
)