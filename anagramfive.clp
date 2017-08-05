(clear)
(reset)

(deftemplate letter (slot char) (slot pos))

(deffunction ask()
  (printout t "Choose a word." crlf)
  (bind ?x (read))
   (return ?x)
)

(deffunction explodingWords (?a)

  (bind ?x "")

  (
    for (bind ?i 1) (<= ?i (str-length ?a)) (++ ?i)

      (bind ?x (sym-cat ?x (sub-string ?i ?i ?a) " "))
  )

  (bind ?list (explode$ ?x))
  (return ?list)

)


(deffunction createRule(?listLength)
   (bind ?pre "(defrule gramRule")
   (bind ?post " => (printout t")
   
   (for (bind ?i 1) (<= ?i ?listLength) (bind ?i (+ ?i 1))
   
      (bind ?pre (str-cat ?pre " (letter (char ?C" ?i ") (pos ?P" ?i))
      
      (for (bind ?j 1) (< ?j ?i) (++ ?j)
         (bind ?pre (str-cat ?pre " &~?P" ?j))
      )
      
      (bind ?pre (str-cat ?pre "))"))
      
      
      
      (bind ?post (str-cat ?post " ?C" ?i))
      (printout t "i: " ?i crlf "PRE: " ?pre crlf "POST: " ?post crlf crlf)
   )

   (bind ?code (str-cat ?pre (str-cat ?post "))")))
   (printout t ?code crlf))
   (return ?code)
)


(bind ?list (explodingWords ?word))
(bind ?length (length$ ?list))

(deffunction assertElem(?char ?pos)
   (assert (letter (char ?char) (pos ?pos)))
   (return)
)

(deffunction assertList(?list)
   (for (bind ?i 1) (< ?i= (length$ ?list)) (++ ?i)
      (assertElem (nth$ ?i ?list) ?i)
   )
   (return)
)