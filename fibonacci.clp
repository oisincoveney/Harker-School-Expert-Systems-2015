/*
* Name: Oisin Coveney
* Date of Creation: September 11, 2015
* Description of Module:
*    Fibonacci takes in a number ?num, which refers to the number of values
*    to be generated in the Fibonacci sequence, a mathematical sequence of
*    numbers starting from 1 and 1, and adding the previous two numbers
*    for the next value of the sequance. These values are returned in
*    a list ().
*
*    For example, if the value 4 is inputted, the Fibonacci sequence
*    (1 1 2 3) will be returned.
*/



/*
* The fibonacci method will compute the fibonacci sequence,
* where the previous two numbers are added to get the next
* value, starting with 1 and 1. To get a number from the user, the method
* uses the (ask) function which will prompt the user for a number. This number
* is passed to the method as ?num, which is the number of values of the
* fibonacci sequence which will be created iteratively and returned to the user.
* If a user gives a number that is less than or equal to 0, the method will
* either "No negative numbers!" or "There are no numbers." respectively.
* If a user gives a number more than 46, the computer will return
* "Computer limitations do not allow numbers > 46." because integers
* cannot be larger than 2^64. If a double is passed through the method,
* the method will truncate the number to its first integer. For example, if
* 2.31 is given by the user, the method will compute the fibonacci sequence
* as 2.
*/
(deffunction fibonacci()

   (bind ?num (ask))                                               ;uses the ask method to prompt the user for a number
   (bind ?maxInt 46)                                               ;the largest number a fibonacci sequence can be due to integer limits
   (bind ?firstNum 1)                                              ;the first number of the fibonacci sequence
   (bind ?secondNum 1)                                             ;the second number of the fibonacci sequence

   (
      if (> ?num ?maxInt) then                                          ;if the number is larger than 46, the method cannot compute it
         (printout t "Computer limitations do not allow numbers > 46.") ;message telling the user to not use numbers larger than 46
         (return)
      elif (= ?num 0) then                                            ;using zero will return an empty list, so a
                                                                      ;text output for zero will allow the user
                                                                      ;to understand what really happened.
         (printout t "There are no numbers!" crlf)
         (return)                                                     ;get out of the method if the number cannot be computed
      elif (< ?num 0) then                                            ;negative numbers cannot be used in the method
        (printout t "No negative numbers!" crlf)                      ;shouts at user to not give negative numbers
        (return)
   ) ;if (> ?num ?maxInt) then

   (
      if (> ?num 0) then                                              ;the number has passed through the other parameters, it can be computed
         (bind ?list (create$))                                       ;creates the fibonacci list that will be returned to the user
         (bind ?final 0)                                              ;the number that will contain the next value of the list
         (bind ?x ?firstNum)                                          ;first number of the fibonacci sequence - 1
         (bind ?y ?secondNum)                                         ;second number of the fibonacci sequence - also 1

     (

        for (bind ?i 1) (<= ?i ?num) (bind ?i (+ ?i 1))            ;iterates through the user given number to find
                                                                   ;all the values in the fibonacci sequence up to ?num

                                                                   ;the next three lines move the numbers down, so ?y value moves to ?x value, and ?x value moves to ?final value
                                                                   ;and ?final is inserted into the list. ?y becomes ?x + ?final
          (bind ?final ?x)                                         ;?final becomes ?x
          (bind ?x ?y)                                             ;?x becomes ?y

          (bind ?y (+ ?x ?final))                                  ;?y becomes ?x + ?final

          (bind ?list (insert$ ?list ?i ?final))                   ;adds ?final to the end of the list

     ) ;for (bind ?i 1) (<= ?i ?num) (bind ?i (+ ?i 1))


     (printout t "The fibonacci sequence is: ")                    ;prints out the fibonacci list
     (return ?list)                                                ;returns the list.
   ) ;end: if (> ?num 0) then
) ;deffunction fibonacci()

/*
*
* The ask method uses (printout) and (read) to prompt the user for a number
* to use in the fibonacci method. After receiving a number from (read),
* the method returns ?x to use for fibonacci.
*
*/
(deffunction ask()
  (printout t "Choose a number: ") ;use (printout) to prompt the user for a number
  (bind ?x (read))                 ;puts the user input into ?x
  (return ?x)                      ;returns the user input
) ;deffunction ask()

