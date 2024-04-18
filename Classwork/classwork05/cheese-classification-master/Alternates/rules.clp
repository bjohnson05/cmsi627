;user input
(defrule user-input
	(initial-fact) ;fires if initial fact is in the system
=>
	(printout t "Enter the milk source" crlf)
	(assert (milk-source (read)))

	(printout t "Enter the type of cheese" crlf)
	(assert (type (read)))

	(printout t "Enter the texture of the cheese" crlf)
	(bind ?string (readline)) ;reading more than one word
	(assert-string (str-cat "(" ?string ")"))

	(printout t "Enter the colour of the cheese" crlf)
	(assert (colour (read)))

	(printout t "Enter the flavour of the cheese" crlf)
	(bind ?string (readline))
	(assert-string (str-cat "(" ?string ")"))

	(printout t "Enter the aroma of the cheese" crlf)
	(assert (aroma (read)))
)


;rules section

(deftemplate CHEESE::cheese 
	(slot name (default ?NONE))
	(multislot milk-source
		(type SYMBOL)
		(allowed-symbols cow goat sheep buffalo)
		(default ?NONE)
	)
	(multislot country
		(type SYMBOL)
		(allowed-symbols netherlands france italy greece united-states united-kingdom denmark norway sweden spain switzerland)
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
		(allowed-symbols table-cheese bread cooking pasta salad melting dip dessert dressing pizza cheesecake)
		(default ?NONE)
	)
)

(deffacts CHEESE::the-cheese-list 
  (cheese (name gouda) (milk-source cow) (country netherlands) (type semi-hard) (texture firm) (colour yellow) (flavour rich) (aroma pungent) (common-useage table-cheese))
  (cheese (name cheddar) (milk-source cow) (country united-kingdom) (type hard) (texture firm) (colour yellow) (flavour strong) (aroma none) (common-useage melting))
  (cheese (name brie) (milk-source cow) (country france) (type soft) (texture smooth) (colour white) (flavour creamy) (aroma none) (common-useage bread))
  (cheese (name parmasean) (milk-source cow) (country italy) (type hard) (texture crumbly) (colour white) (flavour strong) (aroma strong) (common-useage pasta))
  (cheese (name mozzarella) (milk-source cow) (country italy) (type semi-soft) (texture springy) (colour white) (flavour creamy) (aroma none) (common-useage pizza))
  (cheese (name feta) (milk-source goat) (country greece) (type soft) (texture crumbly) (colour white) (flavour rich) (aroma strong) (common-useage salad))
  (cheese (name asiago) (milk-source cow) (country italy) (type hard) (texture crumbly) (colour yellow) (flavour mild) (aroma pungent) (common-useage salad))
  (cheese (name mascarpone) (milk-source cow) (country italy) (type soft) (texture smooth) (colour white) (flavour mild) (aroma none) (common-useage salad))
  (cheese (name muenster) (milk-source cow) (country united states) (type soft) (texture smooth) (colour pale-yellow) (flavour mild) (aroma pungent) (common-useage melting))
  (cheese (name montery-jack) (milk-source cow) (country united-states) (type semi-hard) (texture creamy) (colour pale-yellow) (flavour mild) (aroma pleasant) (common-useage table-cheese))
  (cheese (name ricotta) (milk-source cow) (country italy) (type soft) (texture creamy) (colour white) (flavour sweet) (aroma none) (common-useage cooking))
  (cheese (name cottage-cheese) (milk-source cow) (country united-kingdom) (type soft) (texture creamy) (colour white) (flavour sweet) (aroma none) (common-useage dip))
  (cheese (name gorgonzola) (milk-source cow) (country italy) (type blue) (texture firm) (colour yellow) (flavour mild) (aroma none) (common-useage pizza))
  (cheese (name cream-cheese) (milk-source cow) (country united-states) (type soft) (texture creamy) (colour white) (flavour creamy) (aroma pleasant) (common-useage cheesecake))
  (cheese (name danish-blue) (milk-source cow) (country denmark) (type blue) (texture creamy) (colour white) (flavour strong) (aroma none) (common-useage dressing))
  (cheese (name jarlsberg) (milk-source cow) (country norway) (type semi-soft) (texture smooth) (colour pale-yellow) (flavour mild) (aroma none) (common-useage melting))
  (cheese (name provolone) (milk-source cow) (country italy) (type semi-hard) (texture firm) (colour pale-yellow) (flavour strong) (aroma pleasant) (common-useage melting))
  (cheese (name cantal) (milk-source cow) (country france) (type semi-hard) (texture crumbly) (colour pale-yellow) (flavour sweet) (aroma strong) (common-useage salad))
  (cheese (name roquefort) (milk-source goat) (country france) (type blue) (texture creamy) (colour pale-yellow) (flavour strong) (aroma none) (common-useage cooking))
  (cheese (name fromage-blanc) (milk-source cow) (country france) (type soft) (texture smooth) (colour white) (flavour mild) (aroma mild) (common-useage table-cheese))
  (cheese (name stilton) (milk-source cow) (country united-kingdom) (type semi-soft) (texture smooth) (colour yellow) (flavour strong) (aroma none) (common-useage table-cheese))
  (cheese (name explorateur) (milk-source cow) (country france) (type soft) (texture smooth) (colour white) (flavour mild) (aroma none) (common-useage salad))
  (cheese (name reblochon) (milk-source cow) (country france) (type semi-soft) (texture firm) (colour white) (flavour mild) (aroma mild) (common-useage table-cheese))
  (cheese (name castigliano) (milk-source cow) (country spain) (type hard) (texture firm) (colour yellow) (flavour spicy) (aroma pleasant) (common-useage table-cheese))
  (cheese (name caciotta-al-tartufo) (milk-source sheep) (country italy) (type semi-soft) (texture firm) (color white) (flavour mild) (aroma pungent) (common-useage salad))
  (cheese (name innes-button) (milk-source goat) (country united-kingdom) (type soft) (texture smooth) (color white) (flavour rich) (aroma none) (common-useage bread))
  (cheese (name brunost) (milk-source cow) (country germany) (type semi-soft) (texture firm) (color yellow) (flavour sweet) (aroma none) (common-useage dip))
  (cheese (name sapsago) (milk-source cow) (country switzerland) (type hard) (texture firm) (color green) (flavour rich) (aroma pleasant) (common-useage bread))
  (cheese (name calcagno) (milk-source sheep) (country italy) (type hard) (texture smooth) (color pale-yellow) (flavour rich) (aroma pleasant) (common-useage salad))
  (cheese (name manchego) (milk-source sheep) (country spain) (type semi-soft) (texture smooth) (color pale-yellow) (flavour sweet) (aroma none) (common-useage table-cheese)))