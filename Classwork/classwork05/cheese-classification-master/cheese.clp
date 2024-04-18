;;; CLIPS Website
;;; clipsrules.net

;;; CLIPS on SourceForge
;;; sourceforge.net/projects/clipsrules/

;;; Adventures in Rule-Based Programming: A CLIPS Tutorial
;;; clipsrules.net/airbp

;;; Original Cheese Classification Source Code
;;; github.com/JherezTaylor/cheese-classification

;;; ###########
;;; MAIN module
;;; ###########

(defmodule MAIN (export ?ALL))

;;; ############
;;; deftemplates
;;; ############

(deftemplate cheese 
   (slot name)
   (multislot milk-source 
      (allowed-values cow goat sheep buffalo))
   (slot prune
      (allowed-values no yes))
   (multislot country)
   (multislot type 
      (allowed-values semi-soft soft semi-hard hard blue))
   (multislot texture 
      (allowed-values crumbly springy firm creamy smooth))
   (multislot color 
      (allowed-values white yellow pale-yellow green))
   (multislot flavor 
      (allowed-values strong mild rich sweet spicy creamy))
   (multislot aroma
      (allowed-values strong mild pleasant pungent none))
   (multislot common-usage 
      (allowed-values table-cheese bread cooking pasta salad 
                      melting dip dessert dressing pizza cheesecake)))

(deftemplate attribute
   (slot name)
   (slot question)
   (slot priority (default 0))
   (multislot values))
   
(deftemplate response
   (slot attribute)
   (slot value))
       
(deftemplate distribution
   (slot attribute)
   (multislot counts))
   
(deftemplate commands
   (multislot values))

;;; ############
;;; deffunctions
;;; ############

;;;
;;; ask-question
;;;
                                            
(deffunction ask-question (?question ?allowed-values $?commands)
  (printout t ?question " " ?allowed-values " ")
  (bind ?answer (read))
  (if (lexemep ?answer)
     then (bind ?answer (lowcase ?answer)))
  (while (and (not (member$ ?answer ?allowed-values))
              (not (member$ ?answer ?commands))) do
     (printout t ?question " " ?allowed-values " ")
     (bind ?answer (read))
     (if (lexemep ?answer)
        then (bind ?answer (lowcase ?answer))))
  ?answer)
  
;;;
;;; transmogrify$
;;;

(deffunction transmogrify$ (?mf)
   (bind ?nmf (create$))
   (foreach ?v ?mf 
      (bind ?nmf (create$ ?nmf (sym-cat ?v))))
   (implode$ ?nmf))

;;;
;;; print-cheese
;;;
   
(deffunction print-cheese (?c)
   (println "   Name: " (fact-slot-value ?c name))
   (println "   Milk Source: " (transmogrify$ (fact-slot-value ?c milk-source)))
   (println "   Type: " (transmogrify$ (fact-slot-value ?c type)))
   (println "   Country: " (transmogrify$ (fact-slot-value ?c country)))
   (println "   Texture: " (transmogrify$ (fact-slot-value ?c texture)))
   (println "   Color: " (transmogrify$ (fact-slot-value ?c color)))
   (println "   Flavor: " (transmogrify$ (fact-slot-value ?c flavor)))
   (println "   Aroma: " (transmogrify$ (fact-slot-value ?c aroma)))
   (println "   Common Usage: " (transmogrify$ (fact-slot-value ?c common-usage))))

;;;
;;; list-remaining-cheeses
;;;

(deffunction list-remaining-cheeses (?prompt)   
   (if ?prompt
      then
      (bind ?response (ask-question "List the remaining cheeses?" (create$ yes no)))
      else
      (bind ?response yes))
   (if (eq ?response yes)
      then
      (println)
      (println "The remaining cheeses are:")
      (do-for-all-facts ((?f cheese)) TRUE
         (println "   " ?f:name))
      (println)))

;;; #############
;;; startup rules
;;; #############

;;;
;;; print-banner
;;;

(defrule print-banner
   (declare (salience 10))
   =>
   (println)
   (println "Welcome to the Cheese Classification System which allows")
   (println "you to discover cheeses through a series of questions.")
   (println)
   (println "You may enter skip in response to a question to")
   (println "skip that question or stop to end the program.")
   (println))

;;;
;;; start
;;;

(defrule start
   (not (ask-question))
   (exists (attribute))
   =>
   (assert (ask-question))
   (focus QUESTION))
   
;;; ##############
;;; question rules
;;; ##############
      
(defmodule QUESTION (import MAIN ?ALL))

;;;
;;; generate-distributions
;;;
 
(defrule generate-distributions
   (logical (ask-question))
   (attribute (name ?attribute) (values $?values))
   =>
   (bind ?counts (create$))
   (foreach ?v ?values
      (bind ?matches (find-all-facts ((?f cheese))
                                     (member$ ?v (fact-slot-value ?f ?attribute))))
      (bind ?counts (create$ ?counts (length$ ?matches))))
   (assert (distribution (attribute ?attribute)
                         (counts (sort > ?counts)))))
 
;;;
;;; select-question
;;;

(defrule select-question
   ;; Distributions have been determined for all attributes
   (forall (attribute (name ?attribute))
           (distribution (attribute ?attribute)))
   ;; There is no attribute with a higher priority
   (attribute (name ?attribute) (priority ?p1))
   (not (attribute (name ~?attribute) (priority ?p2&:(> ?p2 ?p1))))
   ;; There is not an attribute with the same priority that
   ;; eliminates more choices in a worst case scenario
   (distribution (attribute ?attribute) (counts ?low $?middle ?high))
   (not (and (distribution (attribute ?a2&~?attribute) (counts ? $? ?high2&:(< ?high2 ?high)))
             (attribute (name ?a2) (priority ?p1))))
   ;; There is no an attribute with the same priority and worst case 
   ;; scenario that eliminates more choices in a best case scenario.
   (not (and (distribution (attribute ?a2&~?attribute) (counts ?low2&:(< ?low2 ?low) $? ?high))
             (attribute (name ?a2) (priority ?p1))))
   ;; A question has not already been selected
   (not (selected-question ?))
   =>
   (assert (selected-question ?attribute)))

;;;
;;; ask-question
;;;

(defrule ask-question
   ?s <- (selected-question ?attribute)
   (attribute (name ?attribute) 
              (question ?question)
              (values $?allowed-values))
   (commands (values $?commands))
   (distribution (attribute ?attribute) 
                 (counts $?first ?high))
   (test (> (+ 0 (expand$ ?first)) 0))
   =>
   (retract ?s)
   (bind ?response (ask-question ?question ?allowed-values ?commands))
   (assert (response (attribute ?attribute) (value ?response))))

;;;
;;; end-further-questioning
;;;

(defrule end-further-questioning
   (selected-question ?attribute)
   (distribution (attribute ?attribute) (counts $?first ?high))
   (test (= (+ 0 (expand$ ?first)) 0))
   =>
   (bind ?count (length$ (find-all-facts ((?c cheese)) TRUE)))
   (println)
   (println "There are " ?count " cheeses remaining. Further questions can")
   (println "only eliminate all or none of the remaining cheeses.")
   (println)
   (list-remaining-cheeses TRUE))

;;;
;;; no-remaining-questions
;;;

(defrule no-remaining-questions
   (not (attribute))
   =>
   (bind ?count (length$ (find-all-facts ((?c cheese)) TRUE)))
   (println)
   (println "There are " ?count " cheeses remaining. There are")
   (println "no further questions to eliminate cheeses.")
   (println)
   (list-remaining-cheeses TRUE))

;;;
;;; stop-question
;;;

(defrule stop-question
   ?f <- (ask-question)
   ?r <- (response (attribute ?attribute) (value stop))
   =>
   (retract ?f ?r)
   (assert (ask-question))
   (halt))

;;;
;;; skip-question
;;;

(defrule skip-question
   ?f <- (ask-question)
   ?r <- (response (attribute ?attribute) (value skip))
   ?a <- (attribute (name ?attribute))
   =>
   (retract ?f ?r ?a)
   (assert (ask-question)))

;;;
;;;
;;;

(defrule proceed-to-prune
   ?f <- (ask-question)
   (response (value ?value))
   (not (commands (values $? ?value $?)))
   =>
   (retract ?f)
   (focus PRUNE CHECK))

;;; ###########
;;; prune rules
;;; ###########

(defmodule PRUNE (import MAIN ?ALL))

;;;
;;; mark-to-prune
;;;

(defrule mark-to-prune
   (response (attribute ?attribute) (value ?response))
   (commands (values $?commands))
   (test (not (member$ ?response ?commands)))
   ?f <- (cheese (prune no))
   (test (or (and (deftemplate-slot-multip cheese ?attribute)
                  (not (member$ ?response (fact-slot-value ?f ?attribute))))
             (and (not (deftemplate-slot-multip cheese ?attribute))
                  (neq (fact-slot-value ?f ?attribute) ?response))))
   =>
   (modify ?f (prune yes)))

;;; ###########
;;; check rules
;;; ###########

(defmodule CHECK (import MAIN ?ALL))

;;; 
;;; all-choices-pruned
;;;

(defrule all-choices-pruned
   (not (cheese (prune no)))
   ?r <- (response)
   =>
   (println)
   (println "Your last choice eliminated all remaining cheeses.")
   (println "You can list the remaining cheeses, skip this question,")
   (println "choose a different answer for the last question, or stop.")
   (println)
   (bind ?response (ask-question "Choose an option: " (create$ list skip choose stop)))
   (switch ?response
      (case list 
         then 
         (list-remaining-cheeses FALSE)
         (halt))
      (case choose
         then
         (do-for-all-facts ((?c cheese)) (eq ?c:prune yes)
            (modify ?c (prune no)))
         (retract ?r)
         (assert (ask-question)))
      (case skip
         then
         (do-for-all-facts ((?c cheese)) (eq ?c:prune yes)
            (modify ?c (prune no))))
      (case stop
         then
         (retract ?r)
         (halt))))

;;;   
;;; apply-prune
;;;

(defrule apply-prune
   (exists (cheese (prune no)))
   (exists (cheese (prune yes)))
   =>
   (do-for-all-facts ((?c cheese)) (eq ?c:prune yes)
      (retract ?c)))

;;;
;;; one-cheese-remaining
;;;

(defrule one-cheese-remaining
   ?c <- (cheese (name ?name) (prune no))
   (not (cheese (name ~?name) (prune no)))
   (not (cheese (prune yes)))
   =>
   (println)
   (println "The cheese matching your choices is ")
   (println)
   (print-cheese ?c)
   (println)
   (halt))

;;;
;;; cleanup
;;;

(defrule cleanup
   (not (cheese (prune yes)))
   (exists (and (cheese (name ?name) (prune no))
                (cheese (name ~?name) (prune no))))
   ?r <- (response (attribute ?attribute) (value ?response))
   ?a <- (attribute (name ?attribute))
   =>
   (retract ?r ?a))

;;; ########
;;; deffacts
;;; ########

;;;
;;; Initial phase
;;;

(deffacts MAIN::start 
   (commands (values skip stop)))
  
;;;
;;; Cheese attributes
;;;

(deffacts MAIN::cheese-attributes
   (attribute (name type)
              (question "What type of cheese is it?") 
              (priority 2)
              (values semi-soft soft semi-hard hard blue))
   (attribute (name texture)
              (question "How would you describe the texture of the cheese?") 
              (priority 1)
              (values crumbly springy firm creamy smooth))
   (attribute (name color)
              (question "What is the general color of the cheese?") 
              (priority 0)
              (values white yellow pale-yellow green))
   (attribute (name flavor)
              (question "How would you describe the flavor of the cheese?") 
              (priority 0)
              (values strong mild rich sweet spicy creamy))
   (attribute (name aroma)
              (question "How would you describe the aroma of the cheese?") 
              (priority 0)
              (values strong mild pleasant pungent none))
   (attribute (name common-usage) 
              (question "What is the most common use of the cheese?") 
              (priority 0)
              (values table-cheese bread cooking pasta salad melting
                      dip dessert dressing pizza cheesecake)))

;;;
;;; List of cheeses
;;;

(deffacts MAIN::cheese-list
  ;;; Gouda
  (cheese (name "gouda")
        (milk-source cow)
        (country "Netherlands")
        (type semi-hard)
        (texture firm)
        (color yellow)
        (flavor rich)
        (aroma pungent)
        (common-usage table-cheese)
    )
    ;;; Cheddar
    (cheese (name "cheddar")
        (milk-source cow)
        (country "United Kingdom")
        (type hard)
        (texture firm) 
        (color yellow)
        (flavor strong)
        (aroma none)
        (common-usage melting)
    )
    ;;; Brie
    (cheese (name "brie")
        (milk-source cow)
        (country "France")
        (type soft)
        (texture smooth)
        (color white)
        (flavor creamy)
        (aroma none)
        (common-usage bread)
    )
    ;;; Parmasean
    (cheese (name "parmesan")
        (milk-source cow)
        (country "Italy")
        (type hard)
        (texture crumbly)
        (color white)
        (flavor strong)
        (aroma strong)
        (common-usage pasta)
    )
    ;;; Mozzarella
    (cheese (name "mozzarella")
        (milk-source cow)
        (country "Italy")
        (type semi-soft)
        (texture springy)
        (color white)
        (flavor creamy)
        (aroma none)
        (common-usage pizza)
    )
    ;;; Feta
    (cheese (name "Feta")
        (milk-source goat)
        (country "Greece")
        (type soft)
        (texture crumbly)
        (color white)
        (flavor rich)
        (aroma strong)
        (common-usage salad)
    )
    ;;; Asiago
    (cheese
      (name "asiago")
      (milk-source cow)
      (country "Italy")
      (type hard)
      (texture crumbly)
      (color yellow)
      (flavor mild)
      (aroma pungent)
      (common-usage salad)
    )
    ;;; Mascarpone
    (cheese (name "mascarpone")
      (milk-source cow)
      (country "Italy")
      (type soft)
      (texture smooth)
      (color white)
      (flavor mild)
      (aroma none)
      (common-usage salad)
    )
    ;;; Muenster
    (cheese (name "muenster")
      (milk-source cow)
      (country "United States")
      (type soft)
      (texture smooth)
      (color pale-yellow)
      (flavor mild)
      (aroma pungent)
      (common-usage melting)
    )
    ;;; Montery-Jack
    (cheese (name "montery jack")
        (milk-source cow)
        (country "United States")
        (type semi-hard)
        (texture creamy)
        (color pale-yellow)
        (flavor mild)
        (aroma pleasant)
        (common-usage table-cheese)
    )
    ;;; Ricotta
    (cheese (name "ricotta")
        (milk-source cow)
        (country "Italy")
        (type soft)
        (texture creamy)
        (color white)
        (flavor sweet)
        (aroma none)
        (common-usage cooking)
    )
    ;;; Cottage-Cheese
    (cheese (name "cottage cheese")
        (milk-source cow)
        (country "United Kingdom")
        (type soft)
        (texture creamy)
        (color white)
        (flavor sweet)
        (aroma none)
        (common-usage dip)
    )
    ;;; Gorgonzola
    (cheese (name "gorgonzola")
        (milk-source cow)
        (country "Italy")
        (type blue)
        (texture firm)
        (color yellow)
        (flavor mild)
        (aroma none)
        (common-usage pizza)
    )
    ;;; Cream-Cheese
    (cheese (name "cream cheese")
        (milk-source cow)
        (country "United States")
        (type soft)
        (texture creamy)
        (color white)
        (flavor creamy)
        (aroma pleasant)
        (common-usage cheesecake)
    )
    ;;; Danish-Blue
    (cheese (name "danish blue")
        (milk-source cow)
        (country "Denmark")
        (type blue)
        (texture creamy)
        (color white)
        (flavor strong)
        (aroma none)
        (common-usage dressing)
    )
    ;;; Jarslberg
    (cheese (name "jarlsberg")
        (milk-source cow)
        (country "Norway")
        (type semi-soft)
        (texture smooth)
        (color pale-yellow)
        (flavor mild)
        (aroma none)
        (common-usage melting)
    )
    ;;; Provolone
    (cheese (name "provolone")
        (milk-source cow)
        (country "Italy")
        (type semi-hard)
        (texture firm)
        (color pale-yellow)
        (flavor strong)
        (aroma pleasant)
        (common-usage melting)
    )
    ;;; Cantal
    (cheese (name "cantal")
        (milk-source cow)
        (country "France")
        (type semi-hard)
        (texture crumbly)
        (color pale-yellow)
        (flavor sweet)
        (aroma strong)
        (common-usage salad)
    )
    ;;; Roquefort
    (cheese (name "roquefort")
        (milk-source goat)
        (country "France")
        (type blue)
        (texture creamy)
        (color pale-yellow)
        (flavor strong)
        (aroma none)
        (common-usage cooking)
    )
    ;;; Fromage-Blanc
    (cheese (name "fromage blanc")
        (milk-source cow)
        (country "France")
        (type soft)
        (texture smooth)
        (color white)
        (flavor mild)
        (aroma mild)
        (common-usage table-cheese)
    )
    ;;; Stilton
    (cheese (name "stilton")
        (milk-source cow)
        (country "United Kingdom")
        (type semi-soft)
        (texture smooth)
        (color yellow)
        (flavor strong)
        (aroma none)
        (common-usage table-cheese)
    )
    ;;; Explorateur
    (cheese (name "explorateur")
        (milk-source cow)
        (country "France")
        (type soft)
        (texture smooth)
        (color white)
        (flavor mild)
        (aroma none)
        (common-usage salad)
    )
    ;;; Reblochon
    (cheese (name "reblochon")
        (milk-source cow)
        (country "France")
        (type semi-soft)
        (texture firm)
        (color white)
        (flavor mild)
        (aroma mild)
        (common-usage table-cheese)
    )
    ;;; Castigliano
    (cheese (name "castigliano")
        (milk-source cow)
        (country "Spain")
        (type hard)
        (texture firm)
        (color yellow)
        (flavor spicy)
        (aroma pleasant)
        (common-usage table-cheese)
    )
    ;;; Caciotta-al-Tartufo
    (cheese (name "caciotta al tartufo")
        (milk-source sheep)
        (country "Italy")
        (type semi-soft)
        (texture firm)
        (color white)
        (flavor mild)
        (aroma pungent)
        (common-usage salad)
    )
    ;;; Innes-Button
    (cheese (name "innes button")
        (milk-source goat)
        (country "United Kingdom")
        (type soft)
        (texture smooth)
        (color white)
        (flavor rich)
        (aroma none)
        (common-usage bread)
    )
    ;;; Brunost
    (cheese (name "brunost")
        (milk-source cow)
        (country "Germany")
        (type semi-soft)
        (texture firm)
        (color yellow)
        (flavor sweet)
        (aroma none)
        (common-usage dip)
    )
    ;;; Sapsago
    (cheese (name "sapsago")
        (milk-source cow)
        (country "Switzerland")
        (type hard)
        (texture firm)
        (color green)
        (flavor rich)
        (aroma pleasant)
        (common-usage bread)
    )
    ;;; Calcagno
    (cheese (name "calcagno")
        (milk-source sheep)
        (country "Italy")
        (type hard)
        (texture smooth)
        (color pale-yellow)
        (flavor rich)
        (aroma pleasant)
        (common-usage salad)
    )
    ;;; Machego
    (cheese (name "manchego")
        (milk-source sheep)
        (country "Spain")
        (type semi-soft)
        (texture smooth)
        (color pale-yellow)
        (flavor sweet)
        (aroma none)
        (common-usage table-cheese)
    )
)