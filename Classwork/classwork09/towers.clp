;
; filename: towers.clp
; purpose: Interactive Towers of towers (CLIPS KBS)
; author: Dr. Johnson
; date: 2026-03-09
;
; - Player moves: enter disk number and destination post (A/B/C)
; - Validations: disk exists, post exists, disk is top, legal stacking
; - Tracks number of moves; checks for completion
; - Indentation: three spaces per level
;

; ----------------------------
; Data representation
; ----------------------------
(deftemplate post
   (slot name (type SYMBOL))
   ; pile is bottom -> top, i.e., last element is the top disk
   (multislot pile)
)

(deftemplate game
   (slot n (type INTEGER))
   (slot moves (type INTEGER) (default 0))
)

; ----------------------------
; Utilities
; ----------------------------
(deffunction get-post (?name)
   (bind ?facts (find-all-facts ((?p post)) (eq ?p:name ?name)))
   (if (= (length$ ?facts) 0)
      then FALSE
      else (nth$ 1 ?facts)
   )
)

(deffunction get-game ()
   (bind ?facts (find-all-facts ((?g game)) TRUE))
   (if (= (length$ ?facts) 0)
      then FALSE
      else (nth$ 1 ?facts)
   )
)

(deffunction post-top (?postName)
   (bind ?pf (get-post ?postName))
   (if (eq ?pf FALSE) then (return FALSE))
   (bind $?pile (fact-slot-value ?pf pile))
   (bind ?n (length$ $?pile))
   (if (= ?n 0)
      then FALSE
      else (nth$ ?n $?pile)
   )
)

(deffunction legal-post-symbol (?p)
   (or (eq ?p A) (eq ?p B) (eq ?p C))
)

(deffunction find-disk-post (?disk)
   ; Returns the symbol A/B/C where the disk currently is, or FALSE if not found
   (bind ?pfA (get-post A))
   (bind ?pfB (get-post B))
   (bind ?pfC (get-post C))
   (if (and ?pfA (member$ ?disk (fact-slot-value ?pfA pile))) then (return A))
   (if (and ?pfB (member$ ?disk (fact-slot-value ?pfB pile))) then (return B))
   (if (and ?pfC (member$ ?disk (fact-slot-value ?pfC pile))) then (return C))
   (return FALSE)
)

(deffunction show-board ()
   (printout t crlf)
   (foreach ?p (create$ A B C)
      (bind ?pf (get-post ?p))
      (bind $?pile (if ?pf then (fact-slot-value ?pf pile) else (create$)))
      (printout t "Post " ?p "  [size=" (length$ $?pile) "]:  " crlf)
      (printout t "   top -> ")
      (bind ?i (length$ $?pile))
      (while (> ?i 0) do
         (printout t (nth$ ?i $?pile) " ")
         (bind ?i (- ?i 1))
      )
      (printout t "<- bottom" crlf))
   (bind ?gf (get-game))
   (if ?gf then
      (printout t "Moves: " (fact-slot-value ?gf moves) crlf)
   )
   (printout t crlf)
)

(deffunction two-power-minus-one (?n)
   (bind ?r 1)
   (bind ?i 1)
   (while (<= ?i ?n) do
      (bind ?r (* ?r 2))
      (bind ?i (+ ?i 1))
   )
   (return (- ?r 1))
)

; ----------------------------
; Setup / Teardown
; ----------------------------
(deffunction teardown-towers ()
   (do-for-all-facts ((?p post)) TRUE (retract ?p))
   (do-for-all-facts ((?g game)) TRUE (retract ?g))
)

(deffunction setup-towers (?n)
   (teardown-towers)
   (if (or (not (integerp ?n)) (< ?n 1)) then
      (printout t "Error: Number of disks must be a positive integer." crlf)
      (return FALSE)
   )
   ; Create initial piles: A has N..1 (bottom->top), B and C empty
   (bind $?pileA (create$))
   (bind ?i ?n)
   (while (>= ?i 1) do
      (bind $?pileA (create$ $?pileA ?i))
      (bind ?i (- ?i 1))
   )
   (assert (post (name A) (pile $?pileA)))
   (assert (post (name B)))
   (assert (post (name C)))
   (assert (game (n ?n) (moves 0)))
   (printout t "New game created with " ?n " disks." crlf)
   (printout t "Goal: move all disks from A to C." crlf)
   (show-board)
   (return TRUE)
)

; ----------------------------
; Move logic with validations
; ----------------------------
(deffunction increment-moves ()
   (bind ?gf (get-game))
   (if (eq ?gf FALSE) then (return))
   (modify ?gf (moves (+ (fact-slot-value ?gf moves) 1)))
)

(deffunction move-disk (?disk ?dest)
   ; Returns TRUE if moved, FALSE otherwise (printing an error)
   (bind ?gf (get-game))
   (if (eq ?gf FALSE) then
      (printout t "Error: No active game. Start with (play-towers)." crlf)
      (return FALSE)
   )
   (bind ?n (fact-slot-value ?gf n)
)

   ; Validate disk number
   (if (not (integerp ?disk)) then
      (printout t "Error: Disk must be an integer." crlf)
      (return FALSE)
   )
   (if (or (< ?disk 1) (> ?disk ?n)) then
      (printout t "Error: Disk " ?disk " does not exist (valid: 1.." ?n ")." crlf)
      (return FALSE)
   )

   ; Validate destination post
   (if (not (legal-post-symbol ?dest)) then
      (printout t "Error: Destination post must be A, B, or C." crlf)
      (return FALSE)
   )

   ; Locate disk's current post
   (bind ?src (find-disk-post ?disk))
   (if (eq ?src FALSE) then
      (printout t "Error: Disk " ?disk " not found on any post." crlf)
      (return FALSE)
   )

   ; Disk must be the top disk on its source post
   (bind ?srcTop (post-top ?src))
   (if (neq ?srcTop ?disk) then
      (printout t "Illegal move: Disk " ?disk " is not on top of post " ?src "." crlf)
      (return FALSE)
   )

   ; Check stacking rules on destination
   (bind ?destTop (post-top ?dest))
   (if (and ?destTop (< ?destTop ?disk)) then
      (printout t "Illegal move: Cannot place larger disk " ?disk " on top of smaller disk " ?destTop "." crlf)
      (return FALSE)
   )

   ; Perform the move: pop from src, push to dest
   (bind ?srcF (get-post ?src))
   (bind ?destF (get-post ?dest))
   (bind $?srcPile (fact-slot-value ?srcF pile))
   (bind ?len (length$ $?srcPile))
   (bind $?srcRest (if (= ?len 1) then (create$) else (subseq$ $?srcPile 1 (- ?len 1))))
   (modify ?srcF (pile $?srcRest))

   (bind $?destPile (if ?destTop then (fact-slot-value ?destF pile) else (create$)))
   (modify ?destF (pile $?destPile ?disk))

   (increment-moves)
   (printout t "Moved disk " ?disk " from " ?src " to " ?dest "." crlf)
   (show-board)
   (return TRUE)
)

(deffunction is-solved ()
   (bind ?gf (get-game))
   (if (eq ?gf FALSE) then (return FALSE))
   (bind ?n (fact-slot-value ?gf n))
   (bind ?cF (get-post C))
   (if (eq ?cF FALSE) then (return FALSE))
   (bind ?len (length$ (fact-slot-value ?cF pile)))
   (return (= ?len ?n))
)

; ----------------------------
; Main loop
; ----------------------------
(deffunction play-towers ()
   (printout t crlf "=== Towers of towers ===" crlf)
   (printout t "Enter number of disks (1..12 recommended), or q to cancel: ")
   (bind ?in (read))
   (if (or (eq ?in q) (eq ?in Q)) then
      (printout t "Cancelled." crlf)
      (return)
   )
   (if (not (integerp ?in)) then
      (printout t "Please enter an integer." crlf)
      (return)
   )
   (if (not (setup-towers ?in)) then (return))

   (bind ?optimal (two-power-minus-one ?in))
   (printout t "Optimal number of moves: " ?optimal crlf crlf)

   (while TRUE do
      (if (is-solved) then
         (bind ?gf (get-game))
         (bind ?m (fact-slot-value ?gf moves))
         (printout t "*** Solved! ***" crlf)
         (printout t "You used " ?m " moves. Optimal is " ?optimal "." crlf crlf)
         (return)
      )

      (printout t "Move a disk: Enter disk number (or q to quit): ")
      (bind ?d (read))
      (if (or (eq ?d q) (eq ?d Q)) then
         (printout t "Goodbye!" crlf)
         (return)
      )

      (printout t "Enter destination post (A/B/C), or q to quit: ")
      (bind ?p (read))
      (if (or (eq ?p q) (eq ?p Q)) then
         (printout t "Goodbye!" crlf)
         (return)
      )

      ; Normalize simple lowercase posts
      (if (eq ?p a) then (bind ?p A))
      (if (eq ?p b) then (bind ?p B))
      (if (eq ?p c) then (bind ?p C))

      (move-disk ?d ?p)
   )
)

