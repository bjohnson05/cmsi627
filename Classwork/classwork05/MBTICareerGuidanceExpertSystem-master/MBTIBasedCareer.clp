(defglobal
   ?*E* = 0
   ?*I* = 0
   ?*S* = 0
   ?*N* = 0
   ?*F* = 0
   ?*T* = 0
   ?*J* = 0
   ?*P* = 0
   )

(defrule init
   (declare (salience 500))
   =>
   (printout t "Welcome to MBTI-powered Career Guidance System" crlf)
   )

(defrule q1
   (declare (salience 490))
   =>
   (printout t crlf "Q1) At a party, you" crlf)
   (printout t "1 - interact with many, including strangers" crlf)
   (printout t "2 - interact with a few, known to you" crlf)
   (printout t "Enter your response (1 or 2) : " crlf)
   (bind ?resp (read))
   (while (not (or (eq ?resp 1) (eq ?resp 2)) ) do
		(printout t "Incorrect response. Enter your response (1 or 2) : " crlf)
		(bind ?resp (read))
   )
   (if (= ?resp 1)
      then
      (bind ?*E* (+ ?*E* 1))
      )
   (if (= ?resp 2)
      then
      (bind ?*I* (+ ?*I* 1))
      )
   )

(defrule q2
   (declare (salience 480))
   =>
   (printout t crlf "Q2) Are you more " crlf)
   (printout t "1 - realistic than speculative" crlf)
   (printout t "2 - speculative than realistic" crlf)
   (printout t "Enter your response (1 or 2) : " crlf)
   (bind ?resp (read))
   (while (not (or (eq ?resp 1) (eq ?resp 2)) ) do
		(printout t "Incorrect response. Enter your response (1 or 2) : " crlf)
		(bind ?resp (read))
   )
   (if (= ?resp 1)
      then
      (bind ?*S* (+ ?*S* 1))
      )
   (if (= ?resp 2)
      then
      (bind ?*N* (+ ?*N* 1))
      )
   )

(defrule q3
   (declare (salience 470))
   =>
   (printout t crlf "Q3) Are you more impressed by " crlf)
   (printout t "1 - principles" crlf)
   (printout t "2 - emotions" crlf)
   (printout t "Enter your response (1 or 2) : " crlf)
   (bind ?resp (read))
   (while (not (or (eq ?resp 1) (eq ?resp 2)) ) do
		(printout t "Incorrect response. Enter your response (1 or 2) : " crlf)
		(bind ?resp (read))
   )
   (if (= ?resp 1)
      then
      (bind ?*T* (+ ?*T* 1))
      )
   (if (= ?resp 2)
      then
      (bind ?*F* (+ ?*F* 1))
      )
   )

(defrule q4
   (declare (salience 460))
   =>
   (printout t crlf "Q4) Do you tend to choose" crlf)
   (printout t "1 - rather carefully" crlf)
   (printout t "2 - somewhat impulsively" crlf)
   (printout t "Enter your response (1 or 2) : " crlf)
   (bind ?resp (read))
   (while (not (or (eq ?resp 1) (eq ?resp 2)) ) do
		(printout t "Incorrect response. Enter your response (1 or 2) : " crlf)
		(bind ?resp (read))
   )
   (if (= ?resp 1)
      then
      (bind ?*J* (+ ?*J* 1))
      )
   (if (= ?resp 2)
      then
      (bind ?*P* (+ ?*P* 1))
      )
   )

(defrule q5
   (declare (salience 450))
   =>
   (printout t crlf "Q5) While in company do you" crlf)
   (printout t "1 - initiate conversation" crlf)
   (printout t "2 - wait to be approached" crlf)
   (printout t "Enter your response (1 or 2) : " crlf)
   (bind ?resp (read))
   (while (not (or (eq ?resp 1) (eq ?resp 2)) ) do
		(printout t "Incorrect response. Enter your response (1 or 2) : " crlf)
		(bind ?resp (read))
   )
   (if (= ?resp 1)
      then
      (bind ?*E* (+ ?*E* 1))
      )
   (if (= ?resp 2)
      then
      (bind ?*I* (+ ?*I* 1))
      )
   )

(defrule q6
   (declare (salience 440))
   =>
   (printout t crlf "Q6) Are you more interested in" crlf)
   (printout t "1 - what is actual" crlf)
   (printout t "2 - what is possible" crlf)
   (printout t "Enter your response (1 or 2) : " crlf)
   (bind ?resp (read))
   (while (not (or (eq ?resp 1) (eq ?resp 2)) ) do
		(printout t "Incorrect response. Enter your response (1 or 2) : " crlf)
		(bind ?resp (read))
   )
   (if (= ?resp 1)
      then
      (bind ?*S* (+ ?*S* 1))
      )
   (if (= ?resp 2)
      then
      (bind ?*N* (+ ?*N* 1))
      )
   )

(defrule q7
   (declare (salience 430))
   =>
   (printout t crlf "Q7) In judging others are you more swayed by" crlf)
   (printout t "1 - laws than circumstances" crlf)
   (printout t "2 - circumstances than laws" crlf)
   (printout t "Enter your response (1 or 2) : " crlf)
   (bind ?resp (read))
   (while (not (or (eq ?resp 1) (eq ?resp 2)) ) do
		(printout t "Incorrect response. Enter your response (1 or 2) : " crlf)
		(bind ?resp (read))
   )
   (if (= ?resp 1)
      then
      (bind ?*T* (+ ?*T* 1))
      )
   (if (= ?resp 2)
      then
      (bind ?*F* (+ ?*F* 1))
      )
   )

(defrule q8
   (declare (salience 420))
   =>
   (printout t crlf "Q8) Do you prefer to work" crlf)
   (printout t "1 - according to deadlines" crlf)
   (printout t "2 - whenever you feel like working" crlf)
   (printout t "Enter your response (1 or 2) : " crlf)
   (bind ?resp (read))
   (while (not (or (eq ?resp 1) (eq ?resp 2)) ) do
		(printout t "Incorrect response. Enter your response (1 or 2) : " crlf)
		(bind ?resp (read))
   )
   (if (= ?resp 1)
      then
      (bind ?*J* (+ ?*J* 1))
      )
   (if (= ?resp 2)
      then
      (bind ?*P* (+ ?*P* 1))
      )
   )

(defrule q9
   (declare (salience 410))
   =>
   (printout t crlf "Q9) Does meeting new people" crlf)
   (printout t "1 - stimulate and energize you" crlf)
   (printout t "2 - tax your reserves" crlf)
   (printout t "Enter your response (1 or 2) : " crlf)
   (bind ?resp (read))
   (while (not (or (eq ?resp 1) (eq ?resp 2)) ) do
		(printout t "Incorrect response. Enter your response (1 or 2) : " crlf)
		(bind ?resp (read))
   )
   (if (= ?resp 1)
      then
      (bind ?*E* (+ ?*E* 1))
      )
   (if (= ?resp 2)
      then
      (bind ?*I* (+ ?*I* 1))
      )
   )

(defrule q10
   (declare (salience 400))
   =>
   (printout t crlf "Q10) In writings do you prefer " crlf)
   (printout t "1 - literal meanings" crlf)
   (printout t "2 - figurative meanings" crlf)
   (printout t "Enter your response (1 or 2) : " crlf)
   (bind ?resp (read))
   (while (not (or (eq ?resp 1) (eq ?resp 2)) ) do
		(printout t "Incorrect response. Enter your response (1 or 2) : " crlf)
		(bind ?resp (read))
   )
   (if (= ?resp 1)
      then
      (bind ?*S* (+ ?*S* 1))
      )
   (if (= ?resp 2)
      then
      (bind ?*N* (+ ?*N* 1))
      )
   )

(defrule q11
   (declare (salience 390))
   =>
   (printout t crlf "Q11) Which do you wish more for yourself?" crlf)
   (printout t "1 - clarity of reason" crlf)
   (printout t "2 - strength of compassion" crlf)
   (printout t "Enter your response (1 or 2) : " crlf)
   (bind ?resp (read))
   (while (not (or (eq ?resp 1) (eq ?resp 2)) ) do
		(printout t "Incorrect response. Enter your response (1 or 2) : " crlf)
		(bind ?resp (read))
   )
   (if (= ?resp 1)
      then
      (bind ?*T* (+ ?*T* 1))
      )
   (if (= ?resp 2)
      then
      (bind ?*F* (+ ?*F* 1))
      )
   )

(defrule q12
   (declare (salience 380))
   =>
   (printout t crlf "Q12) Do you prefer the" crlf)
   (printout t "1 - planned events" crlf)
   (printout t "2 - unplanned / unexpected events" crlf)
   (printout t "Enter your response (1 or 2) : " crlf)
   (bind ?resp (read))
   (while (not (or (eq ?resp 1) (eq ?resp 2)) ) do
		(printout t "Incorrect response. Enter your response (1 or 2) : " crlf)
		(bind ?resp (read))
   )
   (if (= ?resp 1)
      then
      (bind ?*J* (+ ?*J* 1))
      )
   (if (= ?resp 2)
      then
      (bind ?*P* (+ ?*P* 1))
      )
   )

(defrule q13
   (declare (salience 370))
   =>
   (printout t crlf "Q13) Do you prefer having" crlf)
   (printout t "1 - many friends" crlf)
   (printout t "2 - few friends with more lengthy contact" crlf)
   (printout t "Enter your response (1 or 2) : " crlf)
   (bind ?resp (read))
   (while (not (or (eq ?resp 1) (eq ?resp 2)) ) do
		(printout t "Incorrect response. Enter your response (1 or 2) : " crlf)
		(bind ?resp (read))
   )
   (if (= ?resp 1)
      then
      (bind ?*E* (+ ?*E* 1))
      )
   (if (= ?resp 2)
      then
      (bind ?*I* (+ ?*I* 1))
      )
   )

(defrule q14
   (declare (salience 360))
   =>
   (printout t crlf "Q14) Do you prize more in yourself" crlf)
   (printout t "1 - a strong sense of reality" crlf)
   (printout t "2 - a vivid imagination" crlf)
   (printout t "Enter your response (1 or 2) : " crlf)
   (bind ?resp (read))
   (while (not (or (eq ?resp 1) (eq ?resp 2)) ) do
		(printout t "Incorrect response. Enter your response (1 or 2) : " crlf)
		(bind ?resp (read))
   )
   (if (= ?resp 1)
      then
      (bind ?*S* (+ ?*S* 1))
      )
   (if (= ?resp 2)
      then
      (bind ?*N* (+ ?*N* 1))
      )
   )

(defrule q15
   (declare (salience 350))
   =>
   (printout t crlf "Q15) Which is more important?" crlf)
   (printout t "1 - to discuss an issue thoroughly" crlf)
   (printout t "2 - to arrive at an agreement on an issue" crlf)
   (printout t "Enter your response (1 or 2) : " crlf)
   (bind ?resp (read))
   (while (not (or (eq ?resp 1) (eq ?resp 2)) ) do
		(printout t "Incorrect response. Enter your response (1 or 2) : " crlf)
		(bind ?resp (read))
   )
   (if (= ?resp 1)
      then
      (bind ?*T* (+ ?*T* 1))
      )
   (if (= ?resp 2)
      then
      (bind ?*F* (+ ?*F* 1))
      )
   )

(defrule q16
   (declare (salience 340))
   =>
   (printout t crlf "Q16) Is it preferable mostly to" crlf)
   (printout t "1 - make sure things are arranged" crlf)
   (printout t "2 - just let things happen" crlf)
   (printout t "Enter your response (1 or 2) : " crlf)
   (bind ?resp (read))
   (while (not (or (eq ?resp 1) (eq ?resp 2)) ) do
		(printout t "Incorrect response. Enter your response (1 or 2) : " crlf)
		(bind ?resp (read))
   )
   (if (= ?resp 1)
      then
      (bind ?*J* (+ ?*J* 1))
      )
   (if (= ?resp 2)
      then
      (bind ?*P* (+ ?*P* 1))
      )
   )

(defrule q17
   (declare (salience 330))
   =>
   (printout t crlf "Q17) Are you more inclined to be" crlf)
   (printout t "1 - easy to approach" crlf)
   (printout t "2 - somewhat reserved" crlf)
   (printout t "Enter your response (1 or 2) : " crlf)
   (bind ?resp (read))
   (while (not (or (eq ?resp 1) (eq ?resp 2)) ) do
		(printout t "Incorrect response. Enter your response (1 or 2) : " crlf)
		(bind ?resp (read))
   )
   (if (= ?resp 1)
      then
      (bind ?*E* (+ ?*E* 1))
      )
   (if (= ?resp 2)
      then
      (bind ?*I* (+ ?*I* 1))
      )
   )

(defrule q18
   (declare (salience 320))
   =>
   (printout t crlf "Q18) Are you more likely to trust your" crlf)
   (printout t "1 - experience" crlf)
   (printout t "2 - gut feeling / guess" crlf)
   (printout t "Enter your response (1 or 2) : " crlf)
   (bind ?resp (read))
   (while (not (or (eq ?resp 1) (eq ?resp 2)) ) do
		(printout t "Incorrect response. Enter your response (1 or 2) : " crlf)
		(bind ?resp (read))
   )
   (if (= ?resp 1)
      then
      (bind ?*S* (+ ?*S* 1))
      )
   (if (= ?resp 2)
      then
      (bind ?*N* (+ ?*N* 1))
      )
   )

(defrule q19
   (declare (salience 310))
   =>
   (printout t crlf "Q19) Which rules you more?" crlf)
   (printout t "1 - your brain" crlf)
   (printout t "2 - your heart" crlf)
   (printout t "Enter your response (1 or 2) : " crlf)
   (bind ?resp (read))
   (while (not (or (eq ?resp 1) (eq ?resp 2)) ) do
		(printout t "Incorrect response. Enter your response (1 or 2) : " crlf)
		(bind ?resp (read))
   )
   (if (= ?resp 1)
      then
      (bind ?*T* (+ ?*T* 1))
      )
   (if (= ?resp 2)
      then
      (bind ?*F* (+ ?*F* 1))
      )
   )

(defrule q20
   (declare (salience 300))
   =>
   (printout t crlf "Q20) Are you more comfortable with work that is" crlf)
   (printout t "1 - contracted" crlf)
   (printout t "2 - done on a casual basis" crlf)
   (printout t "Enter your response (1 or 2) : " crlf)
   (bind ?resp (read))
   (while (not (or (eq ?resp 1) (eq ?resp 2)) ) do
		(printout t "Incorrect response. Enter your response (1 or 2) : " crlf)
		(bind ?resp (read))
   )
   (if (= ?resp 1)
      then
      (bind ?*J* (+ ?*J* 1))
      )
   (if (= ?resp 2)
      then
      (bind ?*P* (+ ?*P* 1))
      )
   )

(defrule assertHelper
   (declare (salience 295))
   =>
   (assert (EValue ?*E*))
   (assert (IValue ?*I*))
   (assert (SValue ?*S*))
   (assert (NValue ?*N*))
   (assert (TValue ?*T*))
   (assert (FValue ?*F*))
   (assert (JValue ?*J*))
   (assert (PValue ?*P*))
   )

(defrule isESFJ
   (declare (salience 290))
   (EValue ?Ev) (SValue ?Sv) (FValue ?Fv) (JValue ?Jv)
   (IValue ?Iv) (NValue ?Nv) (TValue ?Tv) (PValue ?Pv)
   (test (> ?Ev ?Iv))
   (test (> ?Sv ?Nv))
   (test (> ?Fv ?Tv))
   (test (> ?Jv ?Pv))
   =>
   (printout t crlf "Your MBTI type is ESFJ." crlf)
   (assert (mbtiType ESFJ))
   )

(defrule isESFP
   (declare (salience 280))
   (EValue ?Ev) (SValue ?Sv) (FValue ?Fv) (JValue ?Jv)
   (IValue ?Iv) (NValue ?Nv) (TValue ?Tv) (PValue ?Pv)
   (test (> ?Ev ?Iv))
   (test (> ?Sv ?Nv))
   (test (> ?Fv ?Tv))
   (test (> ?Pv ?Jv))
   =>
   (printout t crlf "Your MBTI type is ESFP." crlf)
   (assert (mbtiType ESFP))
   )

(defrule isESTJ
   (declare (salience 270))
   (EValue ?Ev) (SValue ?Sv) (FValue ?Fv) (JValue ?Jv)
   (IValue ?Iv) (NValue ?Nv) (TValue ?Tv) (PValue ?Pv)
   (test (> ?Ev ?Iv))
   (test (> ?Sv ?Nv))
   (test (> ?Tv ?Fv))
   (test (> ?Jv ?Pv))
   =>
   (printout t crlf "Your MBTI type is ESTJ." crlf)
   (assert (mbtiType ESTJ))
   )

(defrule isESTP
   (declare (salience 260))
   (EValue ?Ev) (SValue ?Sv) (FValue ?Fv) (JValue ?Jv)
   (IValue ?Iv) (NValue ?Nv) (TValue ?Tv) (PValue ?Pv)
   (test (> ?Ev ?Iv))
   (test (> ?Sv ?Nv))
   (test (> ?Tv ?Fv))
   (test (> ?Pv ?Jv))
   =>
   (printout t crlf "Your MBTI type is ESTP." crlf)
   (assert (mbtiType ESTP))
   )

(defrule isENFJ
   (declare (salience 250))
   (EValue ?Ev) (SValue ?Sv) (FValue ?Fv) (JValue ?Jv)
   (IValue ?Iv) (NValue ?Nv) (TValue ?Tv) (PValue ?Pv)
   (test (> ?Ev ?Iv))
   (test (> ?Nv ?Sv))
   (test (> ?Fv ?Tv))
   (test (> ?Jv ?Pv))
   =>
   (printout t crlf "Your MBTI type is ENFJ." crlf)
   (assert (mbtiType ENFJ))
   )

(defrule isENFP
   (declare (salience 240))
   (EValue ?Ev) (SValue ?Sv) (FValue ?Fv) (JValue ?Jv)
   (IValue ?Iv) (NValue ?Nv) (TValue ?Tv) (PValue ?Pv)
   (test (> ?Ev ?Iv))
   (test (> ?Nv ?Sv))
   (test (> ?Fv ?Tv))
   (test (> ?Pv ?Jv))
   =>
   (printout t crlf "Your MBTI type is ENFP." crlf)
   (assert (mbtiType ENFP))
   )

(defrule isENTJ
   (declare (salience 230))
   (EValue ?Ev) (SValue ?Sv) (FValue ?Fv) (JValue ?Jv)
   (IValue ?Iv) (NValue ?Nv) (TValue ?Tv) (PValue ?Pv)
   (test (> ?Ev ?Iv))
   (test (> ?Nv ?Sv))
   (test (> ?Tv ?Fv))
   (test (> ?Jv ?Pv))
   =>
   (printout t crlf "Your MBTI type is ENTJ." crlf)
   (assert (mbtiType ENTJ))
   )

(defrule isENTP
   (declare (salience 220))
   (EValue ?Ev) (SValue ?Sv) (FValue ?Fv) (JValue ?Jv)
   (IValue ?Iv) (NValue ?Nv) (TValue ?Tv) (PValue ?Pv)
   (test (> ?Ev ?Iv))
   (test (> ?Nv ?Sv))
   (test (> ?Tv ?Fv))
   (test (> ?Pv ?Jv))
   =>
   (printout t crlf "Your MBTI type is ENTP." crlf)
   (assert (mbtiType ENTP))
   )

(defrule isISFJ
   (declare (salience 210))
   (EValue ?Ev) (SValue ?Sv) (FValue ?Fv) (JValue ?Jv)
   (IValue ?Iv) (NValue ?Nv) (TValue ?Tv) (PValue ?Pv)
   (test (> ?Iv ?Ev))
   (test (> ?Sv ?Nv))
   (test (> ?Fv ?Tv))
   (test (> ?Jv ?Pv))
   =>
   (printout t crlf "Your MBTI type is ISFJ." crlf)
   (assert (mbtiType ISFJ))
   )

(defrule isISFP
   (declare (salience 200))
   (EValue ?Ev) (SValue ?Sv) (FValue ?Fv) (JValue ?Jv)
   (IValue ?Iv) (NValue ?Nv) (TValue ?Tv) (PValue ?Pv)
   (test (> ?Iv ?Ev))
   (test (> ?Sv ?Nv))
   (test (> ?Fv ?Tv))
   (test (> ?Pv ?Jv))
   =>
   (printout t crlf "Your MBTI type is ISFP." crlf)
   (assert (mbtiType ISFP))
   )

(defrule isISTJ
   (declare (salience 190))
   (EValue ?Ev) (SValue ?Sv) (FValue ?Fv) (JValue ?Jv)
   (IValue ?Iv) (NValue ?Nv) (TValue ?Tv) (PValue ?Pv)
   (test (> ?Iv ?Ev))
   (test (> ?Sv ?Nv))
   (test (> ?Tv ?Fv))
   (test (> ?Jv ?Pv))
   =>
   (printout t crlf "Your MBTI type is ISTJ." crlf)
   (assert (mbtiType ISTJ))
   )

(defrule isISTP
   (declare (salience 180))
   (EValue ?Ev) (SValue ?Sv) (FValue ?Fv) (JValue ?Jv)
   (IValue ?Iv) (NValue ?Nv) (TValue ?Tv) (PValue ?Pv)
   (test (> ?Iv ?Ev))
   (test (> ?Sv ?Nv))
   (test (> ?Tv ?Fv))
   (test (> ?Pv ?Jv))
   =>
   (printout t crlf "Your MBTI type is ISTP." crlf)
   (assert (mbtiType ISTP))
   )

(defrule isINFJ
   (declare (salience 170))
   (EValue ?Ev) (SValue ?Sv) (FValue ?Fv) (JValue ?Jv)
   (IValue ?Iv) (NValue ?Nv) (TValue ?Tv) (PValue ?Pv)
   (test (> ?Iv ?Ev))
   (test (> ?Nv ?Sv))
   (test (> ?Fv ?Tv))
   (test (> ?Jv ?Pv))
   =>
   (printout t crlf "Your MBTI type is INFJ." crlf)
   (assert (mbtiType INFJ))
   )

(defrule isINFP
   (declare (salience 160))
   (EValue ?Ev) (SValue ?Sv) (FValue ?Fv) (JValue ?Jv)
   (IValue ?Iv) (NValue ?Nv) (TValue ?Tv) (PValue ?Pv)
   (test (> ?Iv ?Ev))
   (test (> ?Nv ?Sv))
   (test (> ?Fv ?Tv))
   (test (> ?Pv ?Jv))
   =>
   (printout t crlf "Your MBTI type is INFP." crlf)
   (assert (mbtiType INFP))
   )

(defrule isINTJ
   (declare (salience 150))
   (EValue ?Ev) (SValue ?Sv) (FValue ?Fv) (JValue ?Jv)
   (IValue ?Iv) (NValue ?Nv) (TValue ?Tv) (PValue ?Pv)
   (test (> ?Iv ?Ev))
   (test (> ?Nv ?Sv))
   (test (> ?Tv ?Fv))
   (test (> ?Jv ?Pv))
   =>
   (printout t crlf "Your MBTI type is INTJ." crlf)
   (assert (mbtiType INTJ))
   )

(defrule isINTP
   (declare (salience 140))
   (EValue ?Ev) (SValue ?Sv) (FValue ?Fv) (JValue ?Jv)
   (IValue ?Iv) (NValue ?Nv) (TValue ?Tv) (PValue ?Pv)
   (test (> ?Iv ?Ev))
   (test (> ?Nv ?Sv))
   (test (> ?Tv ?Fv))
   (test (> ?Pv ?Jv))
   =>
   (printout t crlf "Your MBTI type is INTP." crlf)
   (assert (mbtiType INTP))
   )

(defrule preGetScore
   (declare (salience 135))
   =>
   (printout t crlf "Now, enter your average performance score in the following subjects, on a scale from 0(very poor) to 5(excellent) :" crlf)
   )

(defrule getLanguageScore
   (declare (salience 130))
   =>
   (printout t "Language(s): ")
   (bind ?response (read))
   (while (not (or (eq ?response 0) (eq ?response 1) (eq ?response 2) (eq ?response 3) (eq ?response 4) (eq ?response 5)) ) do
		(printout t "Incorrect response. Enter your response (0-5) : ")
		(bind ?response (read))
   )
   (if (> ?response 3)
      then (assert (langScore high))
      )
   )

(defrule getMathematicsScore
  (declare (salience 129))
   =>
   (printout t "Mathematics: ")
   (bind ?response (read))
   (while (not (or (eq ?response 0) (eq ?response 1) (eq ?response 2) (eq ?response 3) (eq ?response 4) (eq ?response 5)) ) do
		(printout t "Incorrect response. Enter your response (0-5) : ")
		(bind ?response (read))
   )
   (if (> ?response 3)
      then (assert (mathScore high))
      )
   )

(defrule getPhysicsScore
  (declare (salience 128))
   =>
   (printout t "Physics: ")
   (bind ?response (read))
   (while (not (or (eq ?response 0) (eq ?response 1) (eq ?response 2) (eq ?response 3) (eq ?response 4) (eq ?response 5)) ) do
		(printout t "Incorrect response. Enter your response (0-5) : ")
		(bind ?response (read))
   )
   (if (> ?response 3)
      then (assert (phyScore high))
      )
   )

(defrule getChemistryScore
  (declare (salience 127))
   =>
   (printout t "Chemistry: ")
   (bind ?response (read))
   (while (not (or (eq ?response 0) (eq ?response 1) (eq ?response 2) (eq ?response 3) (eq ?response 4) (eq ?response 5)) ) do
		(printout t "Incorrect response. Enter your response (0-5) : ")
		(bind ?response (read))
   )
   (if (> ?response 3)
      then (assert (chemScore high))
      )
   )

(defrule getBiologyScore
  (declare (salience 126))
   =>
   (printout t "Biology: ")
   (bind ?response (read))
   (while (not (or (eq ?response 0) (eq ?response 1) (eq ?response 2) (eq ?response 3) (eq ?response 4) (eq ?response 5)) ) do
		(printout t "Incorrect response. Enter your response (0-5) : ")
		(bind ?response (read))
   )
   (if (> ?response 3)
      then (assert (bioScore high))
      )
   )

(defrule getCSScore
  (declare (salience 125))
   =>
   (printout t "Computer Science / Programming: ")
   (bind ?response (read))
   (while (not (or (eq ?response 0) (eq ?response 1) (eq ?response 2) (eq ?response 3) (eq ?response 4) (eq ?response 5)) ) do
		(printout t "Incorrect response. Enter your response (0-5) : ")
		(bind ?response (read))
   )
   (if (> ?response 3)
      then (assert (csScore high))
      )
   )

(defrule getSocialScore
  (declare (salience 124))
   =>
   (printout t "Social Sciences: ")
   (bind ?response (read))
   (while (not (or (eq ?response 0) (eq ?response 1) (eq ?response 2) (eq ?response 3) (eq ?response 4) (eq ?response 5)) ) do
		(printout t "Incorrect response. Enter your response (0-5) : ")
		(bind ?response (read))
   )
   (if (> ?response 3)
      then (assert (socialScore high))
      )
   )

(defrule getArtScore
  (declare (salience 123))
   =>
   (printout t "Painting / Sketching: ")
   (bind ?response (read))
   (while (not (or (eq ?response 0) (eq ?response 1) (eq ?response 2) (eq ?response 3) (eq ?response 4) (eq ?response 5)) ) do
		(printout t "Incorrect response. Enter your response (0-5) : ")
		(bind ?response (read))
   )
   (if (> ?response 3)
      then (assert (artScore high))
      )
   )

(defrule getActDanceScore
  (declare (salience 122))
   =>
   (printout t "Acting / Dancing: ")
   (bind ?response (read))
   (while (not (or (eq ?response 0) (eq ?response 1) (eq ?response 2) (eq ?response 3) (eq ?response 4) (eq ?response 5)) ) do
		(printout t "Incorrect response. Enter your response (0-5) : ")
		(bind ?response (read))
   )
   (if (> ?response 3)
      then (assert (actdanceScore high))
      )
   )

(defrule getMusicScore
  (declare (salience 121))
   =>
   (printout t "Music: ")
   (bind ?response (read))
   (while (not (or (eq ?response 0) (eq ?response 1) (eq ?response 2) (eq ?response 3) (eq ?response 4) (eq ?response 5)) ) do
		(printout t "Incorrect response. Enter your response (0-5) : ")
		(bind ?response (read))
   )
   (if (> ?response 3)
      then (assert (musicScore high))
      )
   )

(defrule preDisplayResult
   (declare (salience 120))
   =>
   (printout t crlf "The best careers for you, in descending order of match are :" crlf)
   )

(defrule ESFJ_Doc
   (declare (salience 119))
   (mbtiType ESFJ)
   (langScore high) (phyScore high) (bioScore high) (chemScore high)
   =>
   (printout t "Family Doctor / Dentist" crlf)
   )

(defrule ESFJ_Counselor
   (declare (salience 118))
   (mbtiType ESFJ)
   (langScore high) (bioScore high) (socialScore high)
   =>
   (printout t "Counselor" crlf)
   )

(defrule ESFJ_HR
   (declare (salience 117))
   (mbtiType ESFJ)
   (langScore high) (mathScore high) (socialScore high)
   =>
   (printout t "Human Resources / Marketing" crlf)
   )

(defrule ESFJ_Admin
   (declare (salience 116))
   (mbtiType ESFJ)
   (langScore high) (mathScore high) (socialScore high) (phyScore high)
   =>
   (printout t "Administrative Work" crlf)
   )

(defrule ESFJ_Nurse
   (declare (salience 115))
   (mbtiType ESFJ)
   (langScore high) (bioScore high) (chemScore high)
   =>
   (printout t "Nursing" crlf)
   )

(defrule ESFJ_Acc
   (declare (salience 114))
   (mbtiType ESFJ)
   (langScore high) (mathScore high)
   =>
   (printout t "Accountant" crlf)
   )

(defrule ESFJ_Teach
   (declare (salience 113))
   (mbtiType ESFJ)
   =>
   (printout t "Teacher / Social Worker" crlf)
   )

(defrule ESFP_Actor
   (declare (salience 112))
   (mbtiType ESFP)
   (actdanceScore high)
   =>
   (printout t "Actor / Comedian" crlf)
   )

(defrule ESFP_Artist
   (declare (salience 111))
   (mbtiType ESFP)
   (artScore high)
   =>
   (printout t "Artist / Painter" crlf)
   )

(defrule ESFP_Admin
   (declare (salience 110))
   (mbtiType ESFP)
   (langScore high) (mathScore high) (socialScore high)
   =>
   (printout t "Administrative Work" crlf)
   )

(defrule ESFP_Social
   (declare (salience 109))
   (mbtiType ESFP)
   (langScore high) (socialScore high)
   =>
   (printout t "Social Worker / Counselor" crlf)
   )

(defrule ESFP_Fashion
   (declare (salience 108))
   (mbtiType ESFP)
   (artScore high) (socialScore high)
   =>
   (printout t "Fashion Designer" crlf)
   )

(defrule ESFP_Photographer
   (declare (salience 107))
   (mbtiType ESFP)
   (artScore high) (phyScore high)
   =>
   (printout t "Photographer" crlf)
   )

(defrule ESFP_Interior
   (declare (salience 106))
   (mbtiType ESFP)
   (artScore high) (phyScore high)
   =>
   (printout t "Interior Decorator" crlf)
   )

(defrule ESFP_Musician
   (declare (salience 105))
   (mbtiType ESFP)
   (musicScore high)
   =>
   (printout t "Musician" crlf)
   )

(defrule ESFP_Teacher
   (declare (salience 104))
   (mbtiType ESFP)
   =>
   (printout t "Teacher / Trainer / Coach" crlf)
   )

(defrule ESTJ_Management
   (declare (salience 103))
   (mbtiType ESTJ)
   (langScore high) (mathScore high) (socialScore high)
   =>
   (printout t "Management" crlf)
   )

(defrule ESTJ_Eco
   (declare (salience 102))
   (mbtiType ESTJ)
   (mathScore high) (socialScore high)
   =>
   (printout t "Economist / Business Analyst" crlf)
   )

(defrule ESTJ_Bank
   (declare (salience 101))
   (mbtiType ESTJ)
   (mathScore high)
   =>
   (printout t "Banker / Auditor" crlf)
   )

(defrule ESTJ_Detective
   (declare (salience 100))
   (mbtiType ESTJ)
   (phyScore high) (socialScore high)
   =>
   (printout t "Detective" crlf)
   )

(defrule ESTJ_Judge
   (declare (salience 99))
   (mbtiType ESTJ)
   (socialScore high)
   =>
   (printout t "Judge" crlf)
   )

(defrule ESTJ_Military_Teacher
   (declare (salience 98))
   (mbtiType ESTJ)
   =>
   (printout t "Military / Police" crlf)
   (printout t "Teacher / Lecturer" crlf)
   )

(defrule ESTP_Entrepreneur
   (declare (salience 97))
   (mbtiType ESTP)
   (mathScore high) (socialScore high)
   =>
   (printout t "Entrepreneur" crlf)
   )

(defrule ESTP_Sales
   (declare (salience 96))
   (mbtiType ESTP)
   (langScore high) (socialScore high)
   =>
   (printout t "Sales / Marketing" crlf)
   )

(defrule ESTP_Actor
   (declare (salience 95))
   (mbtiType ESTP)
   (actdanceScore high)
   =>
   (printout t "Actor / Dancer / Comedian" crlf)
   )

(defrule ESTP_CompTech
   (declare (salience 94))
   (mbtiType ESTP)
   (phyScore high) (csScore high)
   =>
   (printout t "Computer Technician" crlf)
   )

(defrule ESTP_Military
   (declare (salience 93))
   (mbtiType ESTP)
   =>
   (printout t "Military / Police" crlf)
   )

(defrule ENFJ_Psychologist
   (declare (salience 92))
   (mbtiType ENFJ)
   (langScore high) (bioScore high) (socialScore high)
   =>
   (printout t "Psychologist / Counselor" crlf)
   )

(defrule ENFJ_Diplomat_Editor
   (declare (salience 91))
   (mbtiType ENFJ)
   (langScore high) (socialScore high)
   =>
   (printout t "Diplomat" crlf)
   (printout t "Editor" crlf)
   )

(defrule ENFJ_Politician
   (declare (salience 90))
   (mbtiType ENFJ)
   (socialScore high)
   =>
   (printout t "Politician" crlf)
   )

(defrule ENFJ_Writer
   (declare (salience 89))
   (mbtiType ENFJ)
   (langScore high)
   =>
   (printout t "Writer" crlf)
   )

(defrule ENFJ_Teacher
   (declare (salience 88))
   (mbtiType ENFJ)
   =>
   (printout t "Teacher / Professor / Trainer" crlf)
   )

(defrule ENFP_Psychologist
   (declare (salience 87))
   (mbtiType ENFP)
   (langScore high) (bioScore high) (socialScore high)
   =>
   (printout t "Psychologist / Counselor" crlf)
   )

(defrule ENFP_Lawyer_Diplomat
   (declare (salience 86))
   (mbtiType ENFP)
   (langScore high) (socialScore high)
   =>
   (printout t "Lawyer / Attorney" crlf)
   (printout t "Diplomat" crlf)
   )

(defrule ENFP_Writer_Journalist
   (declare (salience 85))
   (mbtiType ENFP)
   (langScore high)
   =>
   (printout t "Writer" crlf)
   (printout t "Journalist" crlf)
   )

(defrule ENFP_Politician_SW
   (declare (salience 84))
   (mbtiType ENFP)
   (socialScore high)
   =>
   (printout t "Politician" crlf)
   (printout t "Social Worker" crlf)
   )

(defrule ENFP_Teacher
   (declare (salience 83))
   (mbtiType ENFP)
   =>
   (printout t "Teacher / Professor" crlf)
   )

(defrule ENTJ_Scientist
	(declare (salience 82))
	(mbtiType ENTJ)
	(mathScore high) (phyScore high) (chemScore high)
	=>
	(printout t "Scientist" crlf)
	)

(defrule ENTJ_Corporate_Entrepreneur
	(declare (salience 81))
	(mbtiType ENTJ)
	(mathScore high) (socialScore high)
	=>
	(printout t "Corporate Executive" crlf)
	(printout t "Entrepreneur" crlf)
	)

(defrule ENTJ_SysAn
	(declare (salience 80))
	(mbtiType ENTJ)
	(mathScore high) (langScore high)
	=>
	(printout t "Systems Analyst" crlf)
	)

(defrule ENTJ_Politician
	(declare (salience 79))
	(mbtiType ENTJ)
	(socialScore high)
	=>
	(printout t "Politician" crlf)
	)

(defrule ENTJ_Teacher
	(declare (salience 78))
	(mbtiType ENTJ)
	=>
	(printout t "Teacher / Professor" crlf)
	)

(defrule ENTP_Scientist
	(declare (salience 77))
	(mbtiType ENTP)
	(mathScore high) (phyScore high) (chemScore high)
	=>
	(printout t "Scientist" crlf)
	)

(defrule ENTP_Entrepreneur
	(declare (salience 76))
	(mbtiType ENTP)
	(mathScore high) (socialScore high)
	=>
	(printout t "Entrepreneur" crlf)
	)

(defrule ENTP_Lawyer
	(declare (salience 75))
	(mbtiType ENTP)
	(langScore high) (socialScore high)
	=>
	(printout t "Lawyer / Attorney" crlf)
	)

(defrule ENTP_ActDance
	(declare (salience 74))
	(mbtiType ENTP)
	(actdanceScore high)
	=>
	(printout t "Actor / Dancer" crlf)
	)

(defrule ENTP_ArtPhoto
	(declare (salience 73))
	(mbtiType ENTP)
	(artScore high)
	=>
	(printout t "Artist / Designer" crlf)
	(printout t "Photographer" crlf)
	)

(defrule ENTP_CompEng
	(declare (salience 72))
	(mbtiType ENTP)
	(csScore high)
	=>
	(printout t "Computer Engineer" crlf)
	)

(defrule ENTP_Musician
	(declare (salience 71))
	(mbtiType ENTP)
	(musicScore high)
	=>
	(printout t "Musician" crlf)
	)

(defrule ENTP_Writer
	(declare (salience 70))
	(mbtiType ENTP)
	(langScore high)
	=>
	(printout t "Writer" crlf)
	)

(defrule ENTP_Teacher
	(declare (salience 69))
	(mbtiType ENTP)
	=>
	(printout t "Teacher / Professor" crlf)
	)

(defrule ISFJ_Doctor
	(declare (salience 68))
	(mbtiType ISFJ)
	(langScore high) (bioScore high) (chemScore high)
	=>
	(printout t "Doctor" crlf)
	)

(defrule ISFJ_Nurse
	(declare (salience 67))
	(mbtiType ISFJ)
	(langScore high) (bioScore high)
	=>
	(printout t "Nurse / Health Service" crlf)
	)

(defrule ISFJ_Psycho
	(declare (salience 66))
	(mbtiType ISFJ)
	(langScore high) (bioScore high) (socialScore high)
	=>
	(printout t "Psychologist / Counselor" crlf)
	)

(defrule ISFJ_Military
	(declare (salience 65))
	(mbtiType ISFJ)
	(socialScore high)
	=>
	(printout t "Military / Police" crlf)
	)

(defrule ISFJ_Teacher
	(declare (salience 64))
	(mbtiType ISFJ)
	=>
	(printout t "Teacher / Professor" crlf)
	)

(defrule ISFP_Editor
	(declare (salience 63))
	(mbtiType ISFP)
	(langScore high)
	=>
	(printout t "Editor" crlf)
	(printout t "Writer" crlf)
	)

(defrule ISFP_Artist
	(declare (salience 62))
	(mbtiType ISFP)
	(artScore high)
	=>
	(printout t "Artist / Designer" crlf)
	)

(defrule ISFP_Musician
	(declare (salience 61))
	(mbtiType ISFP)
	(musicScore high)
	=>
	(printout t "Composer / Musician" crlf)
	)

(defrule ISFP_ChefRanger
	(declare (salience 60))
	(mbtiType ISFP)
	=>
	(printout t "Chef" crlf)
	(printout t "Forest Ranger" crlf)
	)

(defrule ISTJ_Scientist
	(declare (salience 59))
	(mbtiType ISTJ)
	(mathScore high) (phyScore high) (chemScore high)
	=>
	(printout t "Scientist" crlf)
	)

(defrule ISTJ_Doctor
	(declare (salience 58))
	(mbtiType ISTJ)
	(bioScore high) (chemScore high)
	=>
	(printout t "Doctor" crlf)
	)

(defrule ISTJ_Engineer
	(declare (salience 57))
	(mbtiType ISTJ)
	(mathScore high) (phyScore high)
	=>
	(printout t "Engineer" crlf)
	)

(defrule ISTJ_Law
	(declare (salience 56))
	(mbtiType ISTJ)
	(langScore high) (socialScore high)
	=>
	(printout t "Judge" crlf)
	(printout t "Lawyer / Attorney" crlf)
	)

(defrule ISTJ_Accountant
	(declare (salience 55))
	(mbtiType ISTJ)
	(mathScore high)
	=>
	(printout t "Accountant / Auditor" crlf)
	)

(defrule ISTJ_Admin
	(declare (salience 54))
	(mbtiType ISTJ)
	(mathScore high) (socialScore high)
	=>
	(printout t "Administrative Writer" crlf)
	)

(defrule ISTJ_ComputerEngineer
	(declare (salience 53))
	(mbtiType ISTJ)
	(mathScore high) (csScore high)
	=>
	(printout t "Computer Engineer" crlf)
	)

(defrule ISTJ_Detective
	(declare (salience 52))
	(mbtiType ISTJ)
	(socialScore high)
	=>
	(printout t "Detective" crlf)
	)

(defrule ISTJ_Military_Teacher
	(declare (salience 51))
	(mbtiType ISTJ)
	=>
	(printout t "Military / Police" crlf)
	(printout t "Teacher / Professor" crlf)
	)

(defrule ISTP_Business
	(declare (salience 50))
	(mbtiType ISTP)
	(mathScore high) (socialScore high)
	=>
	(printout t "Business Analyst" crlf)
	)

(defrule ISTP_Pilot
	(declare (salience 49))
	(mbtiType ISTP)
	(mathScore high) (phyScore high)
	=>
	(printout t "Pilot" crlf)
	)

(defrule ISTP_CompEngineer
	(declare (salience 48))
	(mbtiType ISTP)
	(mathScore high) (csScore high)
	=>
	(printout t "Computer Engineer" crlf)
	)

(defrule ISTP_Scientist
	(declare (salience 47))
	(mbtiType ISTP)
	(mathScore high) (phyScore high) (chemScore high)
	=>
	(printout t "Scientist" crlf)
	)

(defrule ISTP_Engineer
	(declare (salience 46))
	(mbtiType ISTP)
	(mathScore high) (phyScore high)
	=>
	(printout t "Engineer" crlf)
	)

(defrule ISTP_RestAll
	(declare (salience 45))
	(mbtiType ISTP)
	=>
	(printout t "Farmer / Planter" crlf)
	(printout t "Athlete" crlf)
	(printout t "Military / Police" crlf)
	(printout t "Teacher / Professor" crlf)
	)

(defrule INFJ_Actor
	(declare (salience 44))
	(mbtiType INFJ)
	(actdanceScore high)
	=>
	(printout t "Actor" crlf)
	)

(defrule INFJ_Photographer
	(declare (salience 43))
	(mbtiType INFJ)
	(artScore high)
	=>
	(printout t "Photographer" crlf)
	(printout t "Artist / Designer" crlf)
	)

(defrule INFJ_Doctor
	(declare (salience 42))
	(mbtiType INFJ)
	(bioScore high) (chemScore high)
	=>
	(printout t "Doctor / Dentist" crlf)
	)

(defrule INFJ_Writer
	(declare (salience 41))
	(mbtiType INFJ)
	(langScore high)
	=>
	(printout t "Writer" crlf)
	)

(defrule INFJ_Musician
	(declare (salience 40))
	(mbtiType INFJ)
	(musicScore high)
	=>
	(printout t "Musician" crlf)
	)

(defrule INFJ_Teacher
	(declare (salience 39))
	(mbtiType INFJ)
	=>
	(printout t "Teacher / Professor" crlf)
	)

(defrule INFP_Musician
	(declare (salience 38))
	(mbtiType INFP)
	(musicScore high)
	=>
	(printout t "Musician" crlf)
	)

(defrule INFP_Filmmaker
	(declare (salience 37))
	(mbtiType INFP)
	=>
	(printout t "Film maker" crlf)
	)

(defrule INFP_Photographer
	(declare (salience 36))
	(mbtiType INFP)
	(artScore high)
	=>
	(printout t "Photographer" crlf)
	(printout t "Artist / Designer" crlf)
	)

(defrule INFP_Psychologist
	(declare (salience 35))
	(mbtiType INFP)
	(langScore high) (bioScore high)
	=>
	(printout t "Psychologist / Counselor" crlf)
	)

(defrule INFP_Social
	(declare (salience 34))
	(mbtiType INFP)
	(socialScore high) (langScore high)
	=>
	(printout t "Social Worker / Activist" crlf)
	)

(defrule INFP_Writer
	(declare (salience 33))
	(mbtiType INFP)
	(langScore high)
	=>
	(printout t "Writer / Journalist" crlf)
	)

(defrule INFP_Fashion
	(declare (salience 32))
	(mbtiType INFP)
	(artScore high) (socialScore high)
	=>
	(printout t "Fashion Designer" crlf)
	)

(defrule INFP_Web
	(declare (salience 31))
	(mbtiType INFP)
	(artScore high) (csScore high)
	=>
	(printout t "Web Designer" crlf)
	)

(defrule INFP_Actor
	(declare (salience 30))
	(mbtiType INFP)
	(actdanceScore high)
	=>
	(printout t "Actor / Dancer" crlf)
	)

(defrule INFP_Teacher
	(declare (salience 29))
	(mbtiType INFP)
	=>
	(printout t "Teacher / Professor" crlf)
	)

(defrule INTJ_Business
	(declare (salience 28))
	(mbtiType INTJ)
	(mathScore high)
	=>
	(printout t "Business Administrator" crlf)
	(printout t "Corporate Executive" crlf)
	)

(defrule INTJ_Entrepreneur
	(declare (salience 27))
	(mbtiType INTJ)
	(mathScore high) (socialScore high)
	=>
	(printout t "Entrepreneur" crlf)
	)

(defrule INTJ_Law
	(declare (salience 26))
	(mbtiType INTJ)
	(langScore high) (socialScore high)
	=>
	(printout t "Lawyer / Attorney" crlf)
	)

(defrule INTJ_Politician
	(declare (salience 25))
	(mbtiType INTJ)
	(socialScore high)
	=>
	(printout t "Politician" crlf)
	)

(defrule INTJ_Scientist
	(declare (salience 24))
	(mbtiType INTJ)
	(mathScore high) (phyScore high) (chemScore high)
	=>
	(printout t "Scientist" crlf)
	)

(defrule INTJ_SysAnalyst
	(declare (salience 23))
	(mbtiType INTJ)
	(mathScore high) (csScore high)
	=>
	(printout t "Systems Analyst" crlf)
	)

(defrule INTJ_Teacher
	(declare (salience 22))
	(mbtiType INTJ)
	=>
	(printout t "Teacher / Professor" crlf)
	)

(defrule INTP_Actor
	(declare (salience 21))
	(mbtiType INTP)
	(actdanceScore high)
	=>
	(printout t "Actor / Dancer" crlf)
	)

(defrule INTP_Architect
	(declare (salience 20))
	(mbtiType INTP)
	(artScore high) (mathScore high)
	=>
	(printout t "Architect" crlf)
	)

(defrule INTP_Artist
	(declare (salience 19))
	(mbtiType INTP)
	(artScore high)
	=>
	(printout t "Artist / Designer" crlf)
	)

(defrule INTP_Scientist
	(declare (salience 18))
	(mbtiType INTP)
	(mathScore high) (phyScore high) (chemScore high)
	=>
	(printout t "Scientist" crlf)
	)

(defrule INTP_EngineerInventor
	(declare (salience 17))
	(mbtiType INTP)
	(phyScore high) (mathScore high)
	=>
	(printout t "Engineer" crlf)
	(printout t "Inventor" crlf)
	)

(defrule INTP_EcoMath
	(declare (salience 16))
	(mbtiType INTP)
	(mathScore high)
	=>
	(printout t "Economist" crlf)
	(printout t "Mathematician" crlf)
	)

(defrule INTP_CompEngineer
	(declare (salience 15))
	(mbtiType INTP)
	(csScore high) (mathScore high)
	=>
	(printout t "Computer Engineer" crlf)
	)

(defrule INTP_Investigator
	(declare (salience 14))
	(mbtiType INTP)
	(socialScore high)
	=>
	(printout t "Investigator" crlf)
	)

(defrule INTP_Musician
	(declare (salience 13))
	(mbtiType INTP)
	(musicScore high)
	=>
	(printout t "Musician" crlf)
	)

(defrule INTP_Strategist
	(declare (salience 12))
	(mbtiType INTP)
	(socialScore high)
	=>
	(printout t "Strategist" crlf)
	)

(defrule INTP_Teacher
	(declare (salience 11))
	(mbtiType INTP)
	=>
	(printout t "Teacher / Professor" crlf)
	)