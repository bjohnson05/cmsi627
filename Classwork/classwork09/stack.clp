;
; filename: stack.clp
; purpose: demonstration of a stack data structure
; author: Dr. Johnson
; date: 2026-03-09
;
; - Implements stacks as deftemplate facts with a multifield
; - Includes push/pop/peek/size/empty/clear/print/destroy
; - Includes a simple test harness
;

; ----------------------------
; Data representation
; ----------------------------
(deftemplate stack
   (slot name (type SYMBOL))
   (slot capacity (type INTEGER) (default -1)) ; -1 means unbounded
   (multislot data)                            ; bottom ... top
)

; ----------------------------
; Internal helpers
; ----------------------------
; Return the fact-address of the stack with the given name, or FALSE if not found.
; the 'find-all-facts' function gets all facts that mach the stack name
; the '?s:name' syntax is similar to python's fields within and object
;     where the variable '?s' is expected to be a stack object
;     and the ':name' portion is the name slot in the variable
(deffunction get-stack (?name)
   (bind ?facts (find-all-facts ((?s stack)) (eq ?s:name ?name)))
   (if (= (length$ ?facts) 0)
      then FALSE
      else (nth$ 1 ?facts)
   )
)

; Return the data multifield of a stack or FALSE if not found.
; check if the named stack exists, and if so, return its data field
; the 'fack-slot-value' CLIPS function gets the value of a specific slot
(deffunction get-stack-data (?name)
   (bind ?f (get-stack ?name))
   (if (eq ?f FALSE)
      then FALSE
      else (fact-slot-value ?f data)
   )
)

; Generic equality (numbers vs symbols)
; the 'numberp' CLIPS function checks if its argument is a number
; this 'equals' function returns TRUE if the argments are equal
; it handles both numbers and symbols
(deffunction equals (?a ?b)
   (if (and (numberp ?a) (numberp ?b))
      then (= ?a ?b)
      else (eq ?a ?b)
   )
)

; ----------------------------
; Public API
; ----------------------------
; Create a new stack
; Usage:
;   (stack-create myStack)            ; unbounded stack named 'myStack'
;   (stack-create myStack 10)         ; capacity 10 stack named 'myStack'
(deffunction stack-create (?name $?rest)
   (bind ?maxSize -1)
   (if (> (length$ ?rest) 0) then (bind ?maxSize (nth$ 1 ?rest)))
   (if (neq (get-stack ?name) FALSE) then
      (printout t "Error: stack '" ?name "' already exists." crlf)
      (return FALSE)
   )
   (assert (stack (name ?name) (capacity ?maxSize)))
   (return TRUE)
)

; Destroy an existing stack
(deffunction stack-destroy (?name)
   (bind ?f (get-stack ?name))
   (if (eq ?f FALSE) then
      (printout t "Error: stack '" ?name "' not found." crlf)
      (return FALSE)
   )
   (retract ?f)
   (return TRUE)
)

; Return number of items on the stack (or FALSE on error)
(deffunction stack-size (?name)
   (bind ?f (get-stack ?name))
   (if (eq ?f FALSE) then
      (printout t "Error: stack '" ?name "' not found." crlf)
      (return FALSE)
   )
   (bind $?d (fact-slot-value ?f data))
   (return (length$ $?d))
)

; Return TRUE if empty, FALSE if not empty, or FALSE on error (with message)
(deffunction stack-empty (?name)
   (bind ?f (get-stack ?name))
   (if (eq ?f FALSE) then
      (printout t "Error: stack '" ?name "' not found." crlf)
      (return FALSE)
   )
   (bind $?d (fact-slot-value ?f data))
   (return (= (length$ $?d) 0))
)

; Push a value; returns TRUE on success, FALSE on error/overflow
(deffunction stack-push (?name ?value)
   (bind ?f (get-stack ?name))
   (if (eq ?f FALSE) then
      (printout t "Error: stack '" ?name "' not found." crlf)
      (return FALSE)
   )
   (bind ?cap (fact-slot-value ?f capacity))
   (bind $?d  (fact-slot-value ?f data))
   (bind ?sz  (length$ $?d))
   (if (and (>= ?cap 0) (>= ?sz ?cap)) then
      (printout t "Error: stack '" ?name "' overflow (capacity " ?cap ")." crlf)
      (return FALSE)
   )
  (retract ?f)
  (assert (stack (name ?name) (capacity ?cap) (data $?d ?value)))
  (return TRUE)
)

; Pop the top element; returns element on success, FALSE on underflow/error
(deffunction stack-pop (?name)
   (bind ?f (get-stack ?name))
   (if (eq ?f FALSE) then
      (printout t "Error: stack '" ?name "' not found." crlf)
      (return FALSE)
   )
   (bind $?d (fact-slot-value ?f data))
   (bind ?n (length$ $?d))
   (if (= ?n 0) then
      (printout t "Error: stack '" ?name "' underflow." crlf)
      (return FALSE)
   )
   (bind ?top (nth$ ?n $?d))
   (bind $?rest (if (= ?n 1) then (create$) else (subseq$ $?d 1 (- ?n 1))))
   (bind ?cap (fact-slot-value ?f capacity))
   (retract ?f)
   (assert (stack (name ?name) (capacity ?cap) (data $?rest)))
   (return ?top)
)

; Peek at the top element; returns element on success, FALSE on empty/error
(deffunction stack-peek (?name)
   (bind ?f (get-stack ?name))
   (if (eq ?f FALSE) then
      (printout t "Error: stack '" ?name "' not found." crlf)
      (return FALSE)
   )
   (bind $?d (fact-slot-value ?f data))
   (bind ?n (length$ $?d))
   (if (= ?n 0) then
      (printout t "Error: stack '" ?name "' is empty." crlf)
      (return FALSE)
   )
   (return (nth$ ?n $?d))
)

; Clear the stack; returns TRUE on success
(deffunction stack-clear (?name)
   (bind ?f (get-stack ?name))
   (if (eq ?f FALSE) then
      (printout t "Error: stack '" ?name "' not found." crlf)
      (return FALSE)
   )
   (bind ?cap (fact-slot-value ?f capacity))
   (retract ?f)
   (assert (stack (name ?name) (capacity ?cap)))
   (return TRUE)
)

; Print the stack content. By default, prints bottom -> top.
; Optional flag 'top-first' prints top -> bottom.
; Examples: (stack-print s)  or  (stack-print s top-first)
(deffunction stack-print (?name $?opts)
   (bind ?f (get-stack ?name))
   (if (eq ?f FALSE) then
      (printout t "Error: stack '" ?name "' not found." crlf)
      (return FALSE))
   (bind ?topFirst FALSE)
   (if (> (length$ ?opts) 0) then (bind ?topFirst (eq (nth$ 1 ?opts) top-first)))
   (bind $?d (fact-slot-value ?f data))
   (printout t "Stack '" ?name "' [size=" (length$ $?d) ", cap=" (fact-slot-value ?f capacity) "]: " crlf)
   (if ?topFirst then
      (printout t "  top -> ")
      (bind ?i (length$ $?d))
      (while (> ?i 0) do
         (printout t (nth$ ?i $?d) " ")
         (bind ?i (- ?i 1))
      )
      (printout t "<- bottom" crlf)
    else
      (printout t "  bottom -> ")
      (bind ?i 1)
      (while (<= ?i (length$ $?d)) do
         (printout t (nth$ ?i $?d) " ")
         (bind ?i (+ ?i 1)))
      (printout t "<- top" crlf)
   )
   (return TRUE)
)

; ----------------------------
; Test harness
; ----------------------------
(deffunction assert-eq (?label ?expected ?actual)
   (if (equals ?expected ?actual)
      then (printout t "[PASS] " ?label " expected: " ?expected "  got: " ?actual crlf)
      else (printout t "[FAIL] " ?label " expected: " ?expected "  got: " ?actual crlf))
)

(deffunction run-stack-tests ()
   (printout t crlf "===== Running Stack Tests =====" crlf)

   ; Fresh create (bounded)
   (printout t crlf "   > creating empty stack of size 3 named 'main'" crlf)
   (stack-create main 3)
   (assert-eq "size on new stack" 0 (stack-size main))
   (assert-eq "empty? on new stack" TRUE (stack-empty main))

   ; Underflow checks
   (printout t crlf "   > test peek and pop on empty stack" crlf)
   (assert-eq "peek on empty returns FALSE" FALSE (stack-peek main))
   (assert-eq "pop on empty returns FALSE" FALSE (stack-pop main))

   ; Push within capacity
   (printout t crlf "   > pushing A, B, C onto empty stack" crlf)
   (assert-eq "push A" TRUE (stack-push main A))
   (assert-eq "push B" TRUE (stack-push main B))
   (assert-eq "push C" TRUE (stack-push main C))
   (assert-eq "size after pushes" 3 (stack-size main))
   (assert-eq "peek after pushes" C (stack-peek main))

   ; Overflow
   (printout t crlf "   > test pushing onto full stack" crlf)
   (assert-eq "push beyond capacity -> FALSE" FALSE (stack-push main D))

   ; Print
   (printout t crlf "   > test printing stack contents" crlf)
   (stack-print main)           ; bottom -> top
   (stack-print main top-first) ; top -> bottom

   ; Pop order (LIFO)
   (printout t crlf "   > test popping to empty out stack 'main'" crlf)
   (assert-eq "pop #1" C (stack-pop main))
   (assert-eq "pop #2" B (stack-pop main))
   (assert-eq "pop #3" A (stack-pop main))
   (assert-eq "empty? after pops" TRUE (stack-empty main))
   (printout t crlf "   > test pop on empty stack" crlf)
   (assert-eq "pop on empty stack returns FALSE" FALSE (stack-pop main))

   ; Clear + reuse unbounded
   (stack-destroy main)
   (printout t crlf "   > creating empty unbounded stack named 'unbounded'" crlf)
   (stack-create unbounded) ; capacity = -1 (unbounded)
   (assert-eq "size on new stack" 0 (stack-size unbounded))
   (assert-eq "empty? on new stack" TRUE (stack-empty unbounded))

   (printout t crlf "   > pushing values 1 - 15 onto empty stack" crlf)
   (stack-push unbounded 1)
   (stack-push unbounded 2)
   (stack-push unbounded 3)
   (stack-push unbounded 4)
   (stack-push unbounded 5)
   (stack-push unbounded 6)
   (stack-push unbounded 7)
   (stack-push unbounded 8)
   (stack-push unbounded 9)
   (stack-push unbounded 10)
   (stack-push unbounded 11)
   (stack-push unbounded 12)
   (stack-push unbounded 13)
   (stack-push unbounded 14)
   (stack-push unbounded 15)
   (printout t crlf "   > test printing stack contents" crlf)
   (stack-print unbounded top-first) ; top -> bottom

   (printout t crlf "   > test peek and pop on unbounded stack" crlf)
   (assert-eq "size on unbounded" 15 (stack-size unbounded))
   (assert-eq "peek the top" 15 (stack-peek unbounded))
   (assert-eq "pop the top" 15 (stack-pop unbounded))
   (assert-eq "size on unbounded" 14 (stack-size unbounded))
   (assert-eq "peek the top" 14 (stack-peek unbounded))
   (assert-eq "pop the top" 14 (stack-pop unbounded))
   (assert-eq "size on unbounded" 13 (stack-size unbounded))
   (assert-eq "peek the top" 13 (stack-peek unbounded))
   (assert-eq "pop the top" 13 (stack-pop unbounded))
   (assert-eq "size on unbounded" 25 (stack-size unbounded))
   (assert-eq "peek the top" 12 (stack-peek unbounded))

   (printout t crlf "   > clear entire stack [shotgun approach]" crlf)
   (stack-clear unbounded)
   (assert-eq "size after clear" 0 (stack-size unbounded))

   ; Cleanup
   (stack-destroy unbounded)

   (printout t "===== Tests Complete =====" crlf crlf)
)
