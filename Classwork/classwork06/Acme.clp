;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;;  File name  : Acme.clp
;;;  Purpose    : This CLIPS source file runs the "Acme.clp" program to
;;;                select the setup for a combination of chassis and
;;;                plug-in units.
;;;  Project    : CMSI 682
;;;  Date       : 14-Feb-2003
;;;  Author     : B.J. Johnson
;;;  Description: Acme Electronics makes a device called the Thingamabob
;;;                2000.  This device is available in five different
;;;                models.  Each model provides a number of bays for the
;;;                plug-ins called Gizmos, and is capable of generating
;;;                a certain amount of power.  Each gizmo requires a
;;;                certain amount of power.  The following tables are
;;;                the specifications:
;;;
;;;           Thingamabobs                           Gizmos
;;;   Chassis  #Bays  Power  Price        Plug-in          Power  Price
;;;   -------  -----  -----  -----        ---------------  -----  -----
;;;     C100     1      4    $2000        Zaptron            2     $100
;;;     C200     2      5    $2500        Yatmizer           6     $800
;;;     C300     3      7    $3000        Phenerator         1     $300
;;;     C400     2      8    $3000        Malcifier          3     $200
;;;     C500     4      9    $3500        Zerashield         4     $150
;;;                                       Warnosynchronizer  2     $ 50
;;;                                       Dynoseparator      3     $400
;;;
;;;  Operation  : This source file is intended to be run directly from
;;;                the CLIPS environment, using the commands:
;;;
;;;                   (load Acme.clp)
;;;                   (reset)
;;;                   (run)
;;;
;;;               It is assumed that all files to be tested will be in
;;;                a folder called "SourceCode".  This will be on the
;;;                current logged drive for the environment.
;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;;  Revision History:
;;;  -----------------
;;;
;;;   Ver      Date      Modified by:  Description
;;;  -----  -----------  ------------  ---------------------------------
;;;  1.0.0  14-Feb-2003  B.J. Johnson  Initial release
;;;
;;;
;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;;  Define a template for the Thingamabobs
;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   (deftemplate thingamabob "Template for the base chassis"
      (slot chassisName)
      (slot numberBays)
      (slot gizmosPower)
      (slot chassisPrice)
   )

;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;;  Define a template for the Gizmos
;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   (deftemplate gizmo "Template for the plug-in units"
      (slot pluginName)
      (slot powerNeeded)
      (slot pluginPrice)
   )

;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;;  Define the table of facts for the base chassis
;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   (deffacts chassis-list "List of thingamabob chassis and attributes"
      (thingamabob (chassisName "C100")
                   (numberBays   1)
                   (gizmosPower  4)
                   (chassisPrice 2000.00)
      )
      (thingamabob (chassisName  "C200")
                   (numberBays   2)
                   (gizmosPower  5)
                   (chassisPrice 2500.00)
      )
      (thingamabob (chassisName  "C300")
                   (numberBays   3)
                   (gizmosPower  7)
                   (chassisPrice 3000.00)
      )
      (thingamabob (chassisName  "C400")
                   (numberBays   2)
                   (gizmosPower  8)
                   (chassisPrice 3000.00)
      )
      (thingamabob (chassisName  "C500")
                   (numberBays   4)
                   (gizmosPower  9)
                   (chassisPrice 3500.00)
      )
   )

;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;;  Define the table of facts for the plug-ins
;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   (deffacts plugin-list "List of plugin gismos and their attributes"
      (gizmo (pluginName  "Zaptron")
             (powerNeeded 2)
             (pluginPrice 100.00)
      )
      (gizmo (pluginName  "Yatmizer")
             (powerNeeded 6)
             (pluginPrice 800.00)
      )
      (gizmo (pluginName  "Phenerator")
             (powerNeeded 1)
             (pluginPrice 300.00)
      )
      (gizmo (pluginName  "Malcifier")
             (powerNeeded 3)
             (pluginPrice 200.00)
      )
      (gizmo (pluginName  "Zerashield")
             (powerNeeded 4)
             (pluginPrice 150.00)
      )
      (gizmo (pluginName  "Warnosynchronizer")
             (powerNeeded 2)
             (pluginPrice 50.00)
      )
      (gizmo (pluginName  "Dynoseparator")
             (powerNeeded 3)
             (pluginPrice 400.00)
      )
   )
;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;;  Define the rule to display the chassis table data
;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   (defrule display-chassis-table "Chassis data in columnar format"
       ?init <- (initial-fact)
      =>
       (printout t crlf crlf)
       (printout t " Chassis      No.       Gizmo      Price" crlf)
       (printout t "  Name      of Bays     Power      (USD)" crlf)
       (printout t "---------   -------     -----      -----" crlf)
       (printout t "  C100          1         4        $2000" crlf)
       (printout t "  C200          2         5        $2500" crlf)
       (printout t "  C300          3         7        $3000" crlf)
       (printout t "  C400          2         8        $3000" crlf)
       (printout t "  C500          4         9        $3500" crlf)
       (printout t crlf crlf)
       (printout t "Select the desired chassis from the table above: ")
       (bind ?chassisSelection (read))
       (retract ?init)
       (assert (theChassisName ?chassisSelection))
       (assert (getGizmo))
   )

;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;;  Define the rule to display the plugin table data
;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   (defrule display-plugin-table "Gizmo data in columnar format"
       (theChassisName ?chassisSelection)
       (getGizmo)
      =>
       (printout t crlf crlf)
       (printout t "Plugin             Power   Price" crlf)
       (printout t "  Name             req'd   (USD)" crlf)
       (printout t "-----------------  -----   -----" crlf)
       (printout t "Zaptron              2     $100" crlf)
       (printout t "Yatmizer             6     $800" crlf)
       (printout t "Phenerator           1     $300" crlf)
       (printout t "Malcifier            3     $200" crlf)
       (printout t "Zerashield           4     $150" crlf)
       (printout t "Warnosynchronizer    2     $ 50" crlf)
       (printout t "Dynoseparator        3     $400" crlf)
       (printout t crlf crlf)
       (printout t "Select the desired plugins from the table above: ")
       (bind $?pluginSelection (read))
       (assert (pluginName ?pluginSelection))
       (assert (displayEm))
   )

;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;;  Define the rule to get the user input for the gizmos required
;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   (defrule displaySelections "Show the user what she picked"
       (theChassisName ?c-Selection)
       (pluginName     ?p-Selection)
       ?f1 <- (thingamabob (chassisName  ?c-name)
                           (numberBays   ?c-bays)
                           (gizmosPower  ?p-supplied)
                           (chassisPrice ?c-price))
       ?f2 <- (gizmo (pluginName  ?p-name)
                     (powerNeeded ?p-power)
                     (pluginPrice ?p-price))
       (displayEm)
      =>
       (if (and (eq ?c-name ?c-Selection)
                (eq ?p-name ?p-Selection))
          then
            (printout t crlf crlf)
            (printout t "You selected the " ?c-Selection " chassis" )
            (printout t " with the " ?p-Selection " plugins." crlf)
            (printout t crlf crlf)
            (retract ?f2)
            (retract ?f1)
       )
   )

;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;;  Define the rule to check if the combination will work
;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;;  Define the rule to calculate the price of the completed unit
;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
