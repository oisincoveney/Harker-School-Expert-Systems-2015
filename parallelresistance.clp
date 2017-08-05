/*
* (ask) prompts the user for a word, using 
* (printout) to display a prompt, then
* binding that word to variable ?x.
* ?x is then returned.
*
* This method is nested inside the
* (getWord) function, so a word passed through this
* function will be validated before the word causes
* OutOfMemory errors in the JVM.
*
*/
(deffunction ask()
   (printout t "Resistor:") ;prompts the user for a word
   (bind ?x (read))               ;put user input into variable ?x
   (return ?x)                    ;returns the user input
) ;deffunction ask()


(bind ?r1 (/ 1 (ask)))
(bind ?r2 (/ 1 (ask)))
(bind ?r3 (/ 1 (ask)))
(bind ?rt (+ ?r1 (+ ?r2 ?r3)))

(printout t "R1: " ?r1 crlf "R2: " ?r2 crlf "R3:" ?r3 crlf "TOTAL: " ?rt crlf)

(printout t "FINAL RESISTANCE:" (/ 1 ?rt) crlf)