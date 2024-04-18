;;;
;  filename: polymorph.clp
;  purpose: example of subclassing
;              including polymorphism
;;;

(defclass PERSON "Person class"
   (is-a USER)
   (slot full-name)
   (slot age)
   (slot eye-color)
   (slot hair-color)
   (slot cell-phone)
)

(defclass STUDENT "Student class that extends Person"
   (is-a PERSON)
   (slot major)
   (slot GPA)
   (slot college)
   (slot university)
)

(defclass EMPLOYEE "Employee class that extends Person"
   (is-a PERSON)
   (slot position)
   (slot salary)
   (slot boss-full-name)
)

(defclass STUDENT-EMPLOYEE "Student employee subclass"
   (is-a STUDENT EMPLOYEE)
)

(definstances stud-empl
   (Employee246677 of STUDENT-EMPLOYEE
      (full-name "Homey D. Clown")
      (age 22)
      (eye-color hazel)
      (hair-color brown)
      (cell-phone "213-555-1212")
      (major "computer science")
      (GPA 4.0)
      (college "Seaver")
      (university "LMU")
      (position "clerk")
      (salary 21.0)
      (boss-full-name "Bozo D. Clown")
   )
   (Employee369258 of STUDENT-EMPLOYEE
      (full-name "Bette E. Boop")
      (age 23)
      (eye-color black)
      (hair-color black)
      (cell-phone "424-555-3434")
      (major "theater arts")
      (GPA 4.0)
      (college "Burns")
      (university "LMU")
      (position "clerk")
      (salary 21.0)
      (boss-full-name "Bozo D. Clown")
   )
)

(defrule list-Bozo-emps "List Bozo's employees"
   (object (is-a STUDENT-EMPLOYEE)
           (boss-full-name ?boss)
           (full-name ?empl))
  =>
   (printout t ?empl " works for " ?boss crlf)
)
