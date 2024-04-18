(defrule sayhi
   =>
   (println)
   (println "hello world!" )
   (println)
)

(defrule sayhiagain
   =>
   (println)
   (printout t "Hello world again!" crlf)
   (println)
)

(deffacts walk "Some facts about walking"
   ; status fact to be asserted
   (status walking)
   ; walk-sign fact to be asserted
   (walk-sign walk)
)

(deffacts blah
   (name "Bozo")
)

(defrule take-a-walk
   (status walking)
   (walk-sign walk)
   =>
   (printout t "Go" crlf)
)

(defrule sayhibozo
   (name "Bozo")
   =>
   (printout t "Hello Bozo" crlf)
   (retract 3)
   (assert (myname "woof"))
)
