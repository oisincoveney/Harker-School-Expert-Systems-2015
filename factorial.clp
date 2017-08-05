(deffunction fact(?a)
  (if (= ?a 1) then
    (return 1)
  else
    (return (* ?a (fact(- ?a 1))))
  )
)

(printout t "Choose a number: ")
(bind ?x (read))
(printout t "The factorial is: " (fact ?x) crlf)
