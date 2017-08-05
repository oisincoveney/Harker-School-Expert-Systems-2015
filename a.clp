(clear)
(reset)


(deffunction doc()
   (printout t crlf
             
             
"**************************************************************************
              Welcome to the Backward Chaining Animals Game!   

                              Name: Oisin Coveney                        
                      Date Created: October 28, 2015                                        
                    Date Submitted: November 5, 2015                                                                                                                    
     This Animals game is based off the game Twenty Questions, where
     system tries to determine what animal a person is thinking of
     by asking questions relating to certain traits, and narrowing
     down its animal search using those traits.
             
     In this Animals game, the system uses backward chaining to ask
     questions and determine the animal being thought of. This game
     will find nine animals using basic traits such as diet, habitat,
     location, body structure, and some specific details.
             
     These animals are:
             
             Polar Bear      Rabbit                  
             Bird            Zebra             
             Octopus         Kangaroo                      
             House Fly       Frog  
             Human

             
      Because of the nature of obtaining information, some details
      may not be accurate. I tried my best to make sure information
      is accurate, but our group may have missed some knowledge.
      
             
      The system will ask the user a series of YES and NO questions,
      which the user is expected to answer with only YES or NO. If
      the user tries to answer with anything else, including a
      variant of those two words, nothing will be asserted and
      the system will prompt the user again with the same question.
             
      If the user determines that the traits do not match an animal,
      the system will return with 
                                                                                   
                                                                                   
                                                                                   
                                                                                  
                                                                                   
 **************************************************************************"
      
             
   crlf
   )
)


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
(deffunction ask (?q)
   (printout t ?q)                ;prompts the user for a word
   (bind ?x (read))               ;put user input into variable ?x
   (return ?x)                    ;returns the user input
) ;deffunction ask()


(deffunction assertTrait(?token)
   (bind ?x (str-cat "(" ?token ")"))
   (assert-string ?x)
   (return)
)


(deffunction findTrait (?question ?trait)
   
   (bind ?x (ask (str-cat ?question "  ANSWER: ")))
   (bind ?boolean FALSE)
   
   (if (eq ?x YES) then
      (assertTrait ?trait)
      (bind ?boolean TRUE)
      
    else
    
      (if (not (eq ?x NO)) then
         (printout t "Please answer with YES or NO (and don't forget to match case). " crlf)
         (findTrait ?question ?trait)
       
      )
   )
   
   (return ?boolean)
)


(deffunction vIsIt (?vNoun)
   (return (str-cat "Is it an " ?vNoun "?"))
)

(deffunction isIt (?noun)
   (return (str-cat "Is it a " ?noun "?"))
)

(deffunction have (?noun)
   (return (doesIt (str-cat "have " ?noun)))
)

(deffunction doesIt (?end)
   (return (str-cat "Does it " ?end "?"))
)

;diet rules

(defrule diet
   =>
   (if (eq (findTrait (isIt "carnivore") carnivore) FALSE) then
      (if (eq (findTrait (isIt "herbivore") herbivore) FALSE) then
        (findTrait (isIt "omnivore") omnivore)
      )
   )
)



;do-backward-chaining functions

(do-backward-chaining land)
(do-backward-chaining water)
(do-backward-chaining legs)
(do-backward-chaining vertebrate)
(do-backward-chaining mammal)
(do-backward-chaining hair)
(do-backward-chaining tentacles)
(do-backward-chaining domesticated)
(do-backward-chaining flies)
(do-backward-chaining crawl)
(do-backward-chaining fur)
(do-backward-chaining wings)
(do-backward-chaining insect)
(do-backward-chaining mollusk)
(do-backward-chaining specificLand)



;habitat rules

(defrule land
   (need-land)
   =>
   (findTrait (doesIt "live on land") land)
)

(defrule water
   (need-water)
   =>
   (findTrait (doesIt "live in water") water)
)

(defrule amphibian
   (land)
   (water)
   =>
   (findTrait (vIsIt "amphibian") amphibian)
)

(defrule wings
   (land)
   (need-wings)
   =>
   (findTrait (have "wings") wings)
)

(defrule flies
   (land)
   (need-flies)
   =>
   (findTrait (doesIt "fly") flies)
)


(defrule crawl
   (land)
   (need-crawl)
   =>
   (findTrait (doesIt "crawl") crawl)
)




(defrule vertebrate
   (need-vertebrate)
   =>
   (findTrait (isIt "vertebrate") vertebrate)
)

(defrule legs
   (land)
   (need-legs)
   =>
   (if (eq (findTrait (have "legs") legs) TRUE) then
       (if (eq (findTrait (have "two legs") twoLegs) FALSE) then
           (if (eq (findTrait (have "four legs") fourLegs) FALSE) then
               (findTrait (have "six legs") sixLegs)
            )
       )
   )
)

(defrule fur
   (mammal)
   (need-fur)
   =>
   (findTrait (have "fur") fur)
)

(defrule mammal
   (vertebrate)
   (need-mammal)
   =>
   (findTrait (isIt "mammal") mammal)
)

(defrule hair
   (mammal)
   (need-hair)
   =>
   (findTrait (have "hair") hair)
)

(defrule tentacles
   (water)
   (need-tentacles)
   =>
   (findTrait (have "tentacles") tentacles)
)

(defrule domesticated
   (land)
   (need-domesticated)
   =>
   (findTrait (isIt "domesticated animal") domesticated)
)

(defrule specificLand
   (land)
   (need-specificLand)
   =>
   (findTrait (doesIt "live in Africa") Africa)
   (findTrait (doesIt "live in Australia") Australia)
   (findTrait (doesIt "live in the tundra") tundra)
   (findTrait (doesIt "live in the tropics") tropics)
)

(defrule mollusk
   (need-mollusk)
   =>
   (findTrait (isIt "mollusk") mollusk)
)

(defrule insect
   (land)
   (need-insect)
   =>
   (findTrait (vIsIt "insect") insect)
)


;Final rules that define the animal

(defrule frog
   (amphibian)
   (fourLegs)
   (carnivore)
   =>
   (findTrait (isIt "frog") end)
)


(defrule zebra
   (land)
   
   (herbivore)
   
   (mammal)
   
   (fourLegs)
   (specificLand)
   (Africa)
   =>
   (findTrait (isIt "zebra") end)
)

(defrule fly
   
   (land)
   (carnivore)
   
   (flies)
   
   (insect)
   (specificLand)
   (tropics)
   (Africa)
   (Australia)
   
   (sixLegs)
   
   =>
   (findTrait (isIt "fly") end)
)


(defrule octopus
   (water)
   (carnivore)
   (mollusk)
   (tentacles)
   =>
   (findTrait (vIsIt "octopus") end)
)

(defrule bird
   (land)
   (flies)
   (twoLegs)
   (wings)
   =>
   (findTrait (isIt "bird") end)
)

(defrule kangaroo
   (land)
   (fourLegs)
   (vertebrate)
   (herbivore)
   (specificLand)
   (Australia)
   =>
   (findTrait (isIt "kangaroo") end)
)

(defrule polarBear
   (land)
   (fourLegs)
   (carnivore)
   (specificLand)
   (mammal)
   (tundra)
   (fur)
   (crawl)
   =>
   (findTrait (isIt "polar bear") end)
)

(defrule rabbit
   (land)
   (fourLegs)
   (mammal)
   (hair)
   (fur)
   (herbivore)
   (specificLand)
   (tundra)
   =>
   (findTrait (isIt "rabbit") end)
)


;end rules

(defrule goodEnding
   (end)
   =>
   (printout t crlf "I found the animal!" crlf)
)

(run)