###
# filename: cars.py
# purpose: demonstrate OOP
###

class car():

   # This is a class that defines the attributes we care
   #  about for a 'car' thing
   def __init__( self, speed, vehicle, marque, folks, displacement ):
      self.topSpeed = speed            # top speed of car
      self.vehicleType = vehicle       # sedan, coupe, SUV, etc.
      self.marque = marque             # car 'brand'
      self.passengers = folks          # how many people fit
      self.engineSize = displacement   # in liters

   def printCar( self ):
      print( "\n   Car make: \t", self.marque,
             "\n   Car type: \t", self.vehicleType,
             "\n   Car holds: \t", self.passengers, "people",
             "\n   Car top end: ", self.topSpeed, "MPH",
             "\n   Car engine: \t", self.engineSize, "liters" )


#  Now we've defined the 'type' we can make 'objects'
def main():
   car1 = car( 150, "coupe", "Porsche", 2, 5 )
   car2 = car( 75, "coupe", "Smart", 2, 0.5 )
   car3 = car( 120, "sedan", "Mercedes", 6, 5 )
   car4 = car( 100, "SUV", "Ford", 7, 3.5 )
   car1.printCar()
   car2.printCar()
   car3.printCar()
   car4.printCar()

main()
