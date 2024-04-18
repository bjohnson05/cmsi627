;;;======================================================
;;;   COMP 3850 Assignment 2
;;;   812003287 – Jherez Taylor
;;;   812002149 – Dillon Bhola
;;;   811003468 – Aaron Yuk Low
;;;
;;;   Cheese Selection
;;;
;;;     wichCheese: The Cheese Expert system.
;;;     This system returns the name and details of a cheese
;;;     to drink with a meal.
;;;
;;;     To execute, merely load, reset and run.
;;;======================================================


;;; This is the template definition for the cheese. Which holds the form:
;;; (cheese (name ?STRING) (country ?STRING) (milk-source $?SYMBOL) (type $?SYMBOL) (texture $?SYMBOL) (colour $?SYMBOL) (flavour $?SYMBOL) (aroma $?SYMBOL) (common-useage $?SYMBOL))

(deftemplate cheese "Template holding the characteristics of a given cheese variety"
  (multislot name (type STRING) (default ?NONE))

  (multislot milk-source (type SYMBOL) (default ?NONE)
    (allowed-symbols cow goat sheep buffalo)
  )
  (multislot country (type STRING) (default ?NONE))
  (multislot type (type SYMBOL) (default ?NONE)
    (allowed-symbols semi-soft soft semi-hard hard blue)
  )
  (multislot texture (type SYMBOL) (default ?NONE)
    (allowed-symbols crumbly springy firm creamy smooth)
  )
  (multislot colour (type SYMBOL) (default ?NONE)
    (allowed-symbols white yellow pale-yellow green)
  )
  (multislot flavour (type SYMBOL) (default ?NONE)
    (allowed-symbols strong mild rich sweet spicy creamy)
  )
  (multislot aroma (type SYMBOL) (default ?NONE)
    (allowed-symbols strong mild pleasant pungent none)
  )
  (multislot common-useage (type SYMBOL) (default ?NONE)
    (allowed-symbols table-cheese bread cooking pasta salad melting dip dessert dressing pizza cheesecake)
  )
)


(deffacts cheese-list "Add cheese list to the facts."
  ;;; Gouda
  (cheese (name "gouda")
        (milk-source cow)
        (country "netherlands")
        (type semi-hard)
        (texture firm)
        (colour yellow)
        (flavour rich)
        (aroma pungent)
        (common-useage table-cheese)
    )
    ;;; Cheddar
    (cheese (name "cheddar")
        (milk-source cow)
        (country "united-kingdom")
        (type hard)
        (texture firm crumbly)
        (colour yellow)
        (flavour strong)
        (aroma none)
        (common-useage melting)
    )
    ;;; Brie
    (cheese (name "brie")
        (milk-source cow)
        (country "france")
        (type soft)
        (texture smooth)
        (colour white)
        (flavour creamy)
        (aroma none)
        (common-useage bread)
    )
    ;;; Parmasean
    (cheese (name "parmasean")
        (milk-source cow)
        (country "italy")
        (type hard)
        (texture crumbly)
        (colour white)
        (flavour strong)
        (aroma strong)
        (common-useage pasta)
    )
    ;;; Mozzarella
    (cheese (name "mozzarella")
        (milk-source cow)
        (country "italy")
        (type semi-soft)
        (texture springy)
        (colour white)
        (flavour creamy)
        (aroma none)
        (common-useage pizza)
    )
    ;;; Feta
    (cheese (name "feta")
        (milk-source goat)
        (country "greece")
        (type soft)
        (texture crumbly)
        (colour white)
        (flavour rich)
        (aroma strong)
        (common-useage salad)
    )
    ;;; Asiago
    (cheese
      (name "asiago")
      (milk-source cow)
      (country "italy")
      (type hard)
      (texture crumbly)
      (colour yellow)
      (flavour mild)
      (aroma pungent)
      (common-useage salad)
    )
    ;;; Mascarpone
    (cheese (name "mascarpone")
      (milk-source cow)
      (country "italy")
      (type soft)
      (texture smooth)
      (colour white)
      (flavour mild)
      (aroma none)
      (common-useage salad)
    )
    ;;; Muenster
    (cheese (name "muenster")
      (milk-source cow)
      (country "united states")
      (type soft)
      (texture smooth)
      (colour pale-yellow)
      (flavour mild)
      (aroma pungent)
      (common-useage melting)
    )
    ;;; Montery-Jack
    (cheese (name "montery-jack")
        (milk-source cow)
        (country "united-states")
        (type semi-hard)
        (texture creamy)
        (colour pale-yellow)
        (flavour mild)
        (aroma pleasant)
        (common-useage table-cheese)
    )
    ;;; Ricotta
    (cheese (name "ricotta")
        (milk-source cow)
        (country "italy")
        (type soft)
        (texture creamy)
        (colour white)
        (flavour sweet)
        (aroma none)
        (common-useage cooking)
    )
    ;;; Cottage-Cheese
    (cheese (name "cottage-cheese")
        (milk-source cow)
        (country "united-kingdom")
        (type soft)
        (texture creamy)
        (colour white)
        (flavour sweet)
        (aroma none)
        (common-useage dip)
    )
    ;;; Gorgonzola
    (cheese (name "gorgonzola")
        (milk-source cow)
        (country "italy")
        (type blue)
        (texture firm)
        (colour yellow)
        (flavour mild)
        (aroma none)
        (common-useage pizza)
    )
    ;;; Cream-Cheese
    (cheese (name "cream-cheese")
        (milk-source cow)
        (country "united-states")
        (type soft)
        (texture creamy)
        (colour white)
        (flavour creamy)
        (aroma pleasant)
        (common-useage cheesecake)
    )
    ;;; Danish-Blue
    (cheese (name "danish-blue")
        (milk-source cow)
        (country "denmark")
        (type blue)
        (texture creamy)
        (colour white)
        (flavour strong)
        (aroma none)
        (common-useage dressing)
    )
    ;;; Jarslberg
    (cheese (name "jarlsberg")
        (milk-source cow)
        (country "norway")
        (type semi-soft)
        (texture smooth)
        (colour pale-yellow)
        (flavour mild)
        (aroma none)
        (common-useage melting)
    )
    ;;; Provolone
    (cheese (name "provolone")
        (milk-source cow)
        (country "italy")
        (type semi-hard)
        (texture firm)
        (colour pale-yellow)
        (flavour strong)
        (aroma pleasant)
        (common-useage melting)
    )
    ;;; Cantal
    (cheese (name "cantal")
        (milk-source cow)
        (country "france")
        (type semi-hard)
        (texture crumbly)
        (colour pale-yellow)
        (flavour sweet)
        (aroma strong)
        (common-useage salad)
    )
    ;;; Roquefort
    (cheese (name "roquefort")
        (milk-source goat)
        (country "france")
        (type blue)
        (texture creamy)
        (colour pale-yellow)
        (flavour strong)
        (aroma none)
        (common-useage cooking)
    )
    ;;; Fromage-Blanc
    (cheese (name "fromage-blanc")
        (milk-source cow)
        (country "france")
        (type soft)
        (texture smooth)
        (colour white)
        (flavour mild)
        (aroma mild)
        (common-useage table-cheese)
    )
    ;;; Stilton
    (cheese (name "stilton")
        (milk-source cow)
        (country "united-kingdom")
        (type semi-soft)
        (texture smooth)
        (colour yellow)
        (flavour strong)
        (aroma none)
        (common-useage table-cheese)
    )
    ;;; Explorateur
    (cheese (name "explorateur")
        (milk-source cow)
        (country "france")
        (type soft)
        (texture smooth)
        (colour white)
        (flavour mild)
        (aroma none)
        (common-useage salad)
    )
    ;;; Reblochon
    (cheese (name "reblochon")
        (milk-source cow)
        (country "france")
        (type semi-soft)
        (texture firm)
        (colour white)
        (flavour mild)
        (aroma mild)
        (common-useage table-cheese)
    )
    ;;; Castigliano
    (cheese (name "castigliano")
        (milk-source cow)
        (country "spain")
        (type hard)
        (texture firm)
        (colour yellow)
        (flavour spicy)
        (aroma pleasant)
        (common-useage table-cheese)
    )
    ;;; Caciotta-al-Tartufo
    (cheese (name "caciotta-al-tartufo")
        (milk-source sheep)
        (country "italy")
        (type semi-soft)
        (texture firm)
        (colour white)
        (flavour mild)
        (aroma pungent)
        (common-useage salad)
    )
    ;;; Innes-Button
    (cheese (name "innes-button")
        (milk-source goat)
        (country "united-kingdom")
        (type soft)
        (texture smooth)
        (colour white)
        (flavour rich)
        (aroma none)
        (common-useage bread)
    )
    ;;; Brunost
    (cheese (name "brunost")
        (milk-source cow)
        (country "germany")
        (type semi-soft)
        (texture firm)
        (colour yellow)
        (flavour sweet)
        (aroma none)
        (common-useage dip)
    )
    ;;; Sapsago
    (cheese (name "sapsago")
        (milk-source cow)
        (country "switzerland")
        (type hard)
        (texture firm)
        (colour green)
        (flavour rich)
        (aroma pleasant)
        (common-useage bread)
    )
    ;;; Calcagno
    (cheese (name "calcagno")
        (milk-source sheep)
        (country "italy")
        (type hard)
        (texture smooth)
        (colour pale-yellow)
        (flavour rich)
        (aroma pleasant)
        (common-useage salad)
    )
    ;;; Machego
    (cheese (name "manchego")
        (milk-source sheep)
        (country "spain")
        (type semi-soft)
        (texture smooth)
        (colour pale-yellow)
        (flavour sweet)
        (aroma none)
        (common-useage table-cheese)
    )
)

;;; Keep track of the number of available cheeses.
(defglobal ?*counter* = 30)

;;; The counter is modified each time we exclude a cheese from
;;; the possible solutions. It reduces the list by one.
(deffunction minusOne ()
  (bind ?*counter* (- ?*counter* 1))
)

;;; Function to check to see if we have found the cheese question before the all the questions have been asked
(deffunction cheeseFound()
  (if (eq ?*counter* 1)
    then (assert (found true))
  )
)

;;; Function to check to see if we failed to find the cheese question before the all the questions have been asked
(deffunction cheeseNotFound()
  (if (eq ?*counter* 0)
    then (assert (found false))
  )
)

;;; This function is used for every question made to the user.
;;; The question is broken into three arguments (?qBEG ?qMID ?qEND)
;;; The argument $?allowed-values is a list that holds the responses that the program accepts.
;;; If a non-acceptable value is entered, the program repeats the question until the response is valid.
(deffunction ask-question (?qBEG ?qMID ?qEND $?allowed-values)
  (printout t ?qBEG ?qMID ?qEND)
  (bind ?answer (read))
  (if (lexemep ?answer)
    then (bind ?answer (lowcase ?answer))
  )
  (while (not (member ?answer ?allowed-values)) do
    (printout t ?qBEG ?qMID ?qEND)
    (bind ?answer (read))
    (if (lexemep ?answer)
      then (bind ?answer (lowcase ?answer)))
  )
?answer)

;;; First question. We ask for the type of cheese. Accepted answers are semi-soft, soft, semi-hard, hard and blue.
;;; The result is stored as the following fact: (cheeseType ?type)
(defrule mainQuestion-Type
  ?x <- (initial-fact)
  =>
  (retract ?x)
  (bind ?type (ask-question "###  What type of cheese is it? (semi-soft soft semi-hard hard blue) ### " "" "" semi-soft soft semi-hard hard blue))
  (assert (cheeseType ?type))
)

;;; Using the fact (cheeseType ?type), the program triggers this rule to filter the cheese by type, and deletes those that are not in the give category. The counter is updated each time this happens
(defrule filterBy-Type
  (cheeseType ?t)
  ?fromage <- (cheese (type $?type))
  =>
  (if (not (member$ ?t $?type))
    then (retract ?fromage) (minusOne)
  )
)

;;; We proceed to ask the user about the texture of the cheese.
;;; The answer is stored as the following fact: (cheeseTexture ?texture)
(defrule mainQuestion-Texture
  (cheeseType ?t)
  =>
  (bind ?texture (ask-question "### How would you describe the texture of the cheese? (crumbly springy firm creamy smooth) ### " "" "" crumbly springy firm creamy smooth))
  (assert (cheeseTexture ?texture))
)

;;; Now that we have a value for the fact (cheeseTexture ?texture), we trigger this rule to filter once again and delete the cheeses that do not have this property
;;; We update the counter as required
(defrule filterBy-Texture
  (cheeseTexture ?tx)
  ?fromage <- (cheese (texture $?texture))
  =>
  (if (not (member$ ?tx $?texture))
    then (retract ?fromage) (minusOne)
  )
)

(defrule check-facts-at-texture
  ?f <- (cheeseTexture ?)
=>
  (cheeseFound)
  (cheeseNotFound)
  (retract ?f)
)

;;; Next up, we ask the user about the colour of the cheese.
;;; The answer is stored as the following fact: (cheeseColour ?colour)
(defrule mainQuestion-Colour
  (cheeseTexture ?tx)
  =>
  (bind ?colour (ask-question "### What is the general colour of the cheese? (white yellow pale-yellow green) ### " "" "" white yellow pale-yellow green))
  (assert (cheeseColour ?colour))
)

;;; Given that the fact (cheeseColour ?colour) exists, this rule gets triggered.
;;; This rule filters the cheese by colour, and deletes that do not match. As usual, we update our counter by calling the (minusOne) function.
(defrule filterBy-Colour
  (cheeseColour ?c)
  ?fromage <- (cheese (colour $?colour))
  =>
  (if (not (member$ ?c $?colour))
    then (retract ?fromage) (minusOne)
  )
)

(defrule check-facts-at-colour
  ?f <- (cheeseColour ?)
=>
  (cheeseFound)
  (cheeseNotFound)
  (retract ?f)
)

;;; Continuing along, we ask the user about the flavour of the cheese
;;; The answer is stored as the following fact: (cheeseFlavour: flavour)
(defrule mainQuestion-Flavour
  (cheeseColour ?c)
  =>
  (bind ?flavour (ask-question "### How would you describe the flavour of the cheese? (strong mild rich sweet spicy creamy) ### " "" "" strong mild rich sweet spicy creamy))
  (assert (cheeseFlavour ?flavour))
)

;;; Now that we have a value for the fact (cheeseFlavour ?texture), we trigger this rule to filter once again and delete the cheeses that do not have this property
;;; We update the counter as required
(defrule filterBy-Flavour
  (cheeseFlavour ?f)
  ?fromage <- (cheese (flavour $?flavour))
  =>
  (if (not (member$ ?f $?flavour))
    then (retract ?fromage) (minusOne)
  )
)

(defrule check-facts-at-flavour
  ?f <- (cheeseFlavour ?)
=>
  (cheeseFound)
  (cheeseNotFound)
  (retract ?f)
)

;;; For further refinement, we ask the user about the aroma of the cheese before we proceed to check the list of cheeses that remain
;;; The answer is stored as the following fact: (cheeseAroma: aroma)
(defrule mainQuestion-Aroma
  (cheeseFlavour ?f)
  =>
  (bind ?aroma (ask-question "### How would you describe the aroma of the cheese? (strong mild pleasant pungent none) ### " "" "" strong mild pleasant pungent none))
  (assert (cheeseAroma ?aroma))
)

;;; Filter and update by aroma
(defrule filterBy-Aroma
  (cheeseAroma ?a)
  ?fromage <- (cheese (aroma $?aroma))
  =>
  (if (not (member$ ?a $?aroma))
    then (retract ?fromage) (minusOne)
  )
)

(defrule check-facts-at-aroma
  ?f <- (cheeseAroma ?)
=>
  (cheeseFound)
  (cheeseNotFound)
  (retract ?f)
)

;;; Final question about the cheese. We ask for the most common use of the cheese.
(defrule mainQuestion-Useage
  (cheeseAroma ?a)
  =>
  (bind ?common-useage (ask-question "### What is the most common use of the cheese? (table-cheese bread cooking pasta salad melting dip dessert dressing pizza cheesecake) ### " "" "" table-cheese bread cooking pasta salad melting dip dessert dressing pizza cheesecake))
  (assert (cheeseUseage ?common-useage))
)

;;; Final filter and update
(defrule filterBy-Useage
  (cheeseUseage ?u)
  ?fromage <- (cheese (common-useage $?common-useage))
  =>
  (if (not (member$ ?u $?common-useage))
    then (retract ?fromage) (minusOne) (cheeseFound)
  )
)

;;; After we have filtered the list by type, texture, colour, flavour and aroma the main propeperties of a cheese, we check the
;;; global variable ?*counter* to see if we can determine where to go next.
;;; If we have one cheese left, then this is the answer and we can assert and trigger the success rule.
;;; If 0 cheeses are left we assert false, as no cheese passed the filtering.
;;; If there exists more than one cheese in the list, then we know that we need additional details and so we query the user for
;;; supplemental information. We assert (needMoreFacts ?type ?texture ?colour) for the program to progress.

(defrule postFilteringEvaluation
  ?type <- (cheeseType ?t)
  ?texture <- (cheeseTexture ?tx)
  ?colour <- (cheeseColour ?c)
  ?flavour <- (cheeseFlavour ?f)
  ?aroma <- (cheeseAroma ?a)
  ?common-useage <- (cheeseUseage ?u)
  =>
  (retract ?type ?texture ?colour ?flavour ?aroma ?common-useage)
  (if (eq ?*counter* 1)
    then (assert (found true))
  else (if (eq ?*counter* 0)
      then (assert (found false))
     )
  else (if (> ?*counter* 1)
      then (assert (found false))
     )
  )
)

;;; If the fact (found true) is present, it means that we have only one (cheese) fact in memory, thus we have our specimen.
;;; We assign this cheese to the variable ?fromage and print the details for the user
(defrule matchFound
  (declare (salience 1000))
  ?f <- (found true)
  ?fromage <- (cheese (name ?n)
            (milk-source ?m)
            (country ?co)
            (type ?t)
            (texture ?tx)
            (colour ?c)
            (flavour ?fl)
            (aroma ?a)
            (common-useage ?u)
        )
  =>
  (retract ?f ?fromage)
  (printout t "*********************" crlf)
  (printout t "* Cheese found!" crlf)
  (printout t "* Name: " ?n crlf)
  (printout t "* Milk Source: " ?m crlf)
  (printout t "* Type: " ?t crlf)
  (printout t "* Country: " ?co crlf)
  (printout t "* Texture: " ?tx crlf)
  (printout t "* Colour: " ?c crlf)
  (printout t "* Flavour: " ?fl crlf)
  (printout t "* Aroma: " ?a crlf)
  (printout t "* Common Useage: " ?u crlf)
  (printout t "*********************" crlf)
)

;;; If the fact (found false) is present, we have no (cheese) facts in memory. This means we have no results with the given criteria. We then print the failure to the user.
(defrule matchNotFound
  ?f <- (found false)
  =>
  (retract ?f)
  (printout t "*********************" crlf)
  (printout t "* No matching cheese found" crlf)
  (printout t "*********************" crlf)
)
