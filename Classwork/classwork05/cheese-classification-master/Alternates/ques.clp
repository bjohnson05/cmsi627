(deftemplate cheese 
	(slot name (default ?NONE))
	(multislot milk-source
		(type SYMBOL)
		(allowed-symbols cow goat sheep buffalo)
		(default ?NONE)
	)
	(multislot country
		(type SYMBOL)
		(allowed-symbols netherlands france italy greece united-states united-kingdom denmark norway sweden spain)
		(default ?NONE)
	)
	(multislot type
		(type SYMBOL)
		(allowed-symbols semi-soft soft semi-hard hard blue)
		(default ?NONE)
	)
	(multislot texture
		(type SYMBOL)
		(allowed-symbols crumbly springy firm creamy smooth)
		(default ?NONE)
	)
	(multislot colour
		(type SYMBOL)
		(allowed-symbols white yellow pale-yellow green)
		(default ?NONE)
	)
	(multislot flavour
		(type SYMBOL)
		(allowed-symbols strong mild rich sweet spicy creamy)
		(default ?NONE)
	)
	(multislot aroma
		(type SYMBOL)
		(allowed-symbols strong mild pleasant pungent none)
		(default ?NONE)
	)
	(multislot common-useage
		(type SYMBOL)
		(allowed-symbols table-cheese bread cooking pasta salad melting dip dessert dressing pizza)
		(default ?NONE)
	)
)

(deftemplate rule 
   (multislot if)
   (multislot then)
)

;(defglobal ?*counter* = 1)

;(deffunction addOne ()
;	(bind ?*counter* (+ ?*counter* 1))
;)

(defrule get-question
	(legalanswers ? $?answers)
	?f <- (question ?category ?value ?text)
=>
	(retract ?f)
	(format t "%s " ?text)
	(printout t ?answers " ")
	(bind ?reply (read))
	(assert (answer is ?reply))

	;(if (answer is yes))
		;then (assert (cheesedets ?category is ?value))
		;?f1 <- (answer is yes)
		;(retract ?f1)

	(if (member (lowcase ?reply) ?answers) 
     then (assert (cheesedets ?category is ?value))
          ;(retract ?f2)
          (assert (answer is yes))
     else (assert (answer is no))
    )
)

(defrule remove-facts
	(cheesedets ?category is ?value)
	;?f1 <- (cheese (name ?) (milk-source ?) (country ?) (type ~?value) (texture ?) (colour ?) (flavour ?) (aroma ?) (common-useage ?))
	?f2 <- (question ?category ~?value $?)
	?f3 <- (cheese (type ~?value))
=>
	;(retract ?f1)
	(retract ?f2)
	(retract ?f3)
)

;(defrule remove-question
;	(cheesedets ?category is ?value)
;	?f1 <- (cheesedets ?category is ?value)
;	?f2 <- (question ?category ~?value $?)
;=>
;	(retract ?f1)
;	(retract ?f2)
;)

(deffacts knowledgebase

	(legalanswers are yes no)

	
	(question texture smooth "Is the type of cheese smooth?")
	(question texture creamy "Is the type of cheese creamy?")
	(question texture firm "Is the type of cheese firm?")
	(question texture springy "Is the type of cheese sprigy?")
	(question texture crumbly "Is the type of cheese crumbly?")
	
	(question type blue "Is the type of cheese blue?")
	(question type soft "Is the type of cheese soft?")
	(question type semi-soft "Is the type of cheese semi-soft?")
	(question type semi-hard "Is the type of cheese semi-hard?")
	(question type hard "Is the type of cheese hard?")


	(cheese (name gouda) (milk-source cow) (country netherlands) (type semi-hard) (texture firm) (colour yellow) (flavour rich) (aroma pungent) (common-useage table-cheese))
	(cheese (name cheddar) (milk-source cow) (country united-kingdom) (type hard) (texture firm) (colour yellow) (flavour strong) (aroma none) (common-useage melting))
	(cheese (name brie) (milk-source cow) (country france) (type soft) (texture smooth) (colour white) (flavour creamy) (aroma none) (common-useage bread))
	(cheese (name parmasean) (milk-source cow) (country italy) (type hard) (texture crumbly) (colour white) (flavour strong) (aroma strong) (common-useage pasta))
	(cheese (name mozzarella) (milk-source cow) (country italy) (type semi-soft) (texture springy) (colour white) (flavour creamy) (aroma none) (common-useage pizza))
	(cheese (name feta) (milk-source goat) (country greece) (type soft) (texture crumbly) (colour white) (flavour rich) (aroma strong) (common-useage salad))
	(cheese (name asiago) (milk-source cow) (country italy) (type hard) (texture crumbly) (colour yellow) (flavour mild) (aroma pungent) (common-useage salad))
	(cheese (name mascarpone) (milk-source cow) (country italy) (type soft) (texture smooth) (colour white) (flavour mild) (aroma none) (common-useage salad))

)