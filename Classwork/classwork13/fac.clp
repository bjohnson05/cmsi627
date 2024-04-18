

   (deffunction factorial "calculate the factorial" (?n)
      (bind ?fac 1)
      (loop-for-count (?cnt1 1 ?n) do
          (bind ?fac (* ?fac ?cnt1))
      )
      (return ?fac)
   )