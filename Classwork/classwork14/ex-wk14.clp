;;;
;  filename: ex-wk14.clp
;  purpose: example of subclassing
;              in-class exercise week14
;;;

(defclass SHAPE "superclass for 2d shapes"
   (is-a USER)
   (slot side-count)
   (slot color)
)

(defclass TRIANGLE "triangle subclass"
   (is-a SHAPE)
   (slot area)
   (slot side1)
   (slot side2)
   (slot side3)
)

(defclass RECTANGLE "rectangle subclass"
   (is-a SHAPE)
   (slot area)
   (slot long-side)
   (slot short-side)
)

(defclass SQUARE "square subclass"
   (is-a RECTANGLE)
   (slot side-length)
)

(defclass PENTAGON "pentagon subclass"
   (is-a SHAPE)
   (slot area)
   (slot side-length)
)

(defclass HEXAGON "hexagon subclass"
   (is-a SHAPE)
   (slot area)
   (slot side1-side4)
   (slot side2-side5)
   (slot side3-side6)
)

(definstances shape-stuff
   (rec1 of RECTANGLE
      (side-count 4)
      (long-side 5)
      (short-side 2)
      (color red)
   )
   (rec2 of RECTANGLE
      (side-count 4)
      (long-side 8)
      (short-side 5)
      (color orange)
   )
   (tri1 of TRIANGLE
      (side-count 3)
      (side1 3)
      (side2 4)
      (side3 5)
      (color yellow)
   )
   (tri2 of TRIANGLE
      (side-count 3)
      (side1 5)
      (side2 12)
      (side3 13)
      (color green)
   )
   (tri3 of TRIANGLE
      (side-count 3)
      (side1 7)
      (side2 24)
      (side3 25)
      (color green)
   )
   (pent1 of PENTAGON
      (side-count 5)
      (side-length 7)
      (color blue)
   )
   (pent2 of PENTAGON
      (side-count 5)
      (side-length 9)
      (color indigo)
   )
   (hex1 of HEXAGON
      (side-count 6)
      (side1-side4 11)
      (side2-side5 11)
      (side3-side6 11)
      (color violet)
   )
   (hex2 of HEXAGON
      (side-count 6)
      (side1-side4 3)
      (side2-side5 3)
      (side3-side6 3)
      (color red)
   )
   (squ1 of SQUARE
      (side-count 4)
      (side-length 19)
      (color orange)
   )
)

;;;
;  TODO: we need user-defined messages
;     to calculate the areas and save them
;     in the instances
;
;  NEXT WEEK'S IN-CLASS EXERCISE
;;;
