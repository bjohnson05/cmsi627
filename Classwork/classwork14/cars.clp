;;;
; filename: class1.clp
; purpose: example COOL class file
;;;

(defclass CAR "example"
   (is-a USER)
   (slot topSpeed (type INTEGER)(range 0 250))
   (slot vehicleType (type STRING))
   (slot marque (type STRING))
   (slot passengers (type INTEGER))
   (slot engineSize (type FLOAT))
)

(definstances cars
   (Porsche of CAR
      (topSpeed 200)
      (vehicleType "coupe")
      (marque "Porsche")
      (passengers 2)
      (engineSize 5.0)
   )
   (Smart of CAR
      (topSpeed 75)
      (vehicleType "coupe")
      (marque "Smart")
      (passengers 2)
      (engineSize 2.0)
   )
   (Mercedes of CAR
      (topSpeed 120)
      (vehicleType "sedan")
      (marque "Mercedes")
      (passengers 6)
      (engineSize 5.0)
   )
   (Ford of CAR
      (topSpeed 100)
      (vehicleType "SUV")
      (marque "Ford")
      (passengers 7)
      (engineSize 3.5)
   )
)
