;;;
;  filename: message.clp
;  purpose: demonstration
;  author: Dr. Johnson
;  date: 2024-04-17
;;;

(defclass RECTANGLE
   (is-a USER)
   (slot height)
   (slot width)
)
(defclass CIRCLE
   (is-a USER)
   (slot radius)
)

(defmessage-handler RECTANGLE compute-area
   ()   ; this is where the arguments go, if any
   (* (send ?self get-height)
      (send ?self get-width)
   )
)

(defmessage-handler CIRCLE compute-area
   ()
   (* (pi)
      (send ?self get-radius)
      (send ?self get-radius)
   )
)

;(defmessage-handler RECTANGLE compute-area
;   ()   ; this is where the arguments go, if any
;   (* ?self:height ?self:width)
;)
;
;(defmessage-handler CIRCLE compute-area
;   ()
;   (* (pi) ?self:radius ?self:radius)
;)

(definstances figures
   (rectangle1 of RECTANGLE (height 17)(width 23))
   (circle1 of CIRCLE (radius 11))
)

