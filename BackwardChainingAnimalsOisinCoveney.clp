(clear)
(reset)


/*
*  The (doc) method displays the top level documentation required
*  by the style guide. This documentation can also be seen in-game
*  at the beginning, when the system will prompt the user if
*  they would like to see the documentation for the game.
*/
(deffunction doc()
   (printout t crlf
             
"***************************************************************************
*                                                                         *
*                      Backward Chaining Animals Game                     *
*                              Name: Oisin Coveney                        * 
*                      Date Created: October 28, 2015                     *
*                Date Last Modified: November 7, 2015                     *
*                    Date Submitted: November 7, 2015                     * 
*                                                                         * 
*     This Animals game is based off the game Twenty Questions, where     * 
*     system tries to determine what animal a person is thinking of       * 
*     by asking questions relating to certain traits, and narrowing       * 
*     down its animal search using those traits.                          * 
*                                                                         * 
*     In this Animals game, the system uses backward chaining to ask      * 
*     questions and determine the animal being thought of. This game      * 
*     will find eight animals using basic traits such as diet, habitat,   * 
*     location, body structure, and some specific details.                * 
*                                                                         * 
*     These animals are:                                                  * 
*                                                                         * 
*             Polar Bear      Rabbit                                      * 
*             Human           Zebra                                       * 
*             Octopus         Kangaroo                                    * 
*             House Fly       Frog                                        * 
*                                                                         * 
*                                                                         * 
*      Because of the nature of obtaining information, some details       * 
*      may not be accurate. I tried my best to make sure information      * 
*      is accurate, but our group may have missed some knowledge.         * 
*                                                                         * 
*                                                                         * 
*      Using the (findTrait) and (assertTrait) methods,the                *
*      system will ask the user a series of yes and no questions,         *
*      which the user is expected to answer with only \"yes\" or \"no\".      * 
*      If the user tries to answer with anything else, including a        * 
*      variant of those two words, nothing will be asserted and           * 
*      the system will prompt the user again with the same question.      * 
*                                                                         * 
*      If the user determines that the traits do not match an animal      * 
*      and all possible rules have fired, the system will return with:    * 
*                                                                         * 
*           \"Sorry, I couldn't find a match for your animal.\"             *
*                                                                         * 
*      Because of the possible inaccuracies of the information, some      * 
*      behavior might be unexpected in finding an animal, and this        * 
*      error message will show if none of the rules that I have           * 
*      assigned to the animal do not match the answers to the questions.  * 
*                                                                         * 
*                               Have fun!                                 * 
*                                                                         * 
***************************************************************************"
      
             
   crlf
   )
   (return)
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






/*
*  (assertTrait ?token) takes ?token for a rule that
*  should be asserted using the (assert-string) function.
*  
*  For example, if the rule "assignment late" must be
*  asserted, (assertTrait "assignment late") will assert
*  the rule (assignment late).
*  
*  The function is used in the (findTrait) function, to assert
*  any rules that define the traits of an animal.
* 
*/
(deffunction assertTrait(?token)
   (bind ?x (str-cat "(" ?token ")"))  ;creates the rule in a string of (?token)
   (assert-string ?x)                  ;asserts the string using (assert-string)
   (return)
) ;deffunction assertTrait(?token)


/*
*  
*  (findTrait ?question ?trait) takes in ?question, a
*  question that asks the user about the trait of an animal,
*  created by the (vIsit), (isIt), (have), or (doesIt) methods
*  depending on the question that must be asked.
*  
*  There are extra spaces in the string to help with the user interface,
*  centering the question and answer into the middle of the space.
*  
*  The function will ask the user ?question,
*  and provide a space for an answer after
*  "ANSWER: ", either "yes" or "no" case-sensitive.
*  
*  If the user answers "yes", the function will assert ?trait
*  and return TRUE, if "no" will return FALSE and not assert anything.
*  If the user does not answer either "yes" or "no", then
*  the function will print out a message telling the user to answer
*  "yes" or "no", and reprompt the user through recursion. 
*  
*  variable ?question - a string that contains a question to ask the
*                       user about ?trait
*  variable ?trait - a rule that will be asserted using the (assertTrait)
*                    method if the user answers "yes"
*  return @boolean - returns TRUE if the user answers "yes", false if "no"
*  
*/
(deffunction findTrait (?question ?trait)
   
   (bind ?x (ask (str-cat 
"
                          " ?question
"
                            ANSWER: "                           ;first, there is extra space for formatting,
                                                               ;then the question is added to the string
                                                               ;then the prompt for the answer is placed
                                                               ;into the concatenation. Then, the next space
                                                               ;creates a new line for the ensuing question.
                  )
            )
   )
   
   (bind ?boolean FALSE)                                       ;default behavior for the boolean is FALSE
                                                               ;until it is determined to be TRUE
   
   (if (eq ?x yes) then                                        ;User must answer "yes" exactly
      (assertTrait ?trait)                                     ;to assert the rule.
      (bind ?boolean TRUE)                                     ;Once the rule is asserted, boolean becoemes TRUE.
      
    else
    
      (if (not (eq ?x no)) then                                              ;If the user answers "no", boolean returns FALSE
                                                                             ;Otherwise, if there is any other answer,
         (printout t crlf 
          "           Please answer with \"yes\" or \"no\" (case-sensitive). "
                   crlf)                                                     ;a printout will tell the user to answer with
                                                                             ;either "yes" or "no", then the
         (return (findTrait ?question ?trait))                               ;function will reprompt using recursion.
       
      )
   )
   
   (return ?boolean)                                           ;Returns TRUE if the answer is "yes", otherwise FALSE
) ;deffunction findTrait (?question ?trait)


/*
*  
*  isIt creates a string that asks the question "Is it a " ?noun "?" 
*  using the ?noun passed into the function. This noun should begin with
*  a consonant or use the article "a", otherwise the method 
*  (vIsIt) should be used.
*
*  For example, if the noun "football" is passed, the function will return
*  "Is it a football?"
*
*  variable ?noun - a noun whose first letter is a consonant
*  return - a string containing the question "Is it a " ?noun "?"
*  
*/
(deffunction isIt (?noun)
   (return (str-cat "Is it a " ?noun "?")) ;"Is it a...?"
) ;deffunction isIt (?noun)


/*
* 
*  vIsIt (vowel isIt) takes ?vNoun, a noun beginning with a vowel, and creates
*  a string with a question that asks about ?vNoun with the article "an".
*
*  For example, if the noun "egg" is passed, the function will return
*  "Is it an egg?"
*  
*  variable ?vNoun - a noun beginning with a vowel that will
*                    be placed into a question asking
*                    "Is it an " ?vNoun "?"
*  return - a string containing the question "Is it an " ?vNoun "?"
*  
*/
(deffunction vIsIt (?vNoun)
   (return (str-cat "Is it an " ?vNoun "?")) ;"Is it an.."
) ;deffunction vIsIt (?vNoun)



/*
*  
*  (have) takes ?noun and creates a string with the question
*  "Does it have " ?noun "?" using the (doesIt) method.
*  
*  This function is used heavily if animals have certain features
*  such as hair, legs, or tentacles.
*
*  For example, if the noun "fur" is passed, the function will 
*  return a string containing "Does it have fur?"
*
*  
*  variable ?noun - a noun that refers to a specific trait that will
*                   be asked with the question structure
*                   "Does it have " ?noun "?" using the (doesIt) function
*  
*  return - a string created by the (doesIt) function that contains
*           "Does it have " ?noun "?" 
* 
*/
(deffunction have (?noun)
   (return (doesIt (str-cat "have " ?noun))) ;"Does it have...?"
) ;deffunction have (?noun)


/*
*  
*  (doesIt) takes a verb or verb-direct object phrase ?end and 
*  creates a string that contains the question "Does it " ?end "?"
*  
*  This function is primarily used when asking about the animal's
*  lifestyle, such as its habitat, location, 
*  or features (using the (have) function).
*  
*  For example, if the word "run" is passed, the function will 
*  return a string containing "Does it run?"
*  
*  variable ?end - the ending of the question "Does it ..." that will
*                  be used to ask the user about the animal's lifestyle
*                  or specificities.
*  
*  return - a string that contains "Does it " ?end "?"
*  
*/
(deffunction doesIt (?end)
   (return (str-cat "Does it " ?end "?")) ;"Does it..?"
) ;deffunction doesIt (?end)



/* 
*  
*  do-backward-chaining functions
*  
*  The following lines express (do-backward-chaining) functions, which enable
*  backward chaining for their specified templates.
*  
*  For example, the (do-backward-chaining habitat) function enables
*  backward chaining for the habitat template. If another rule activates
*  and contains (habitat), the (habitat) rule will fire and determine
*  what habitat the animal lives in.
*  
*/

(do-backward-chaining habitat)
(do-backward-chaining type)
(do-backward-chaining legs)
(do-backward-chaining diet)
(do-backward-chaining location)
(do-backward-chaining moves)
(do-backward-chaining fur)
(do-backward-chaining hair)
(do-backward-chaining tentacles)




/*
*  
*  Specific Trait Rules
*  
*  The following rules use the (findTrait) method to ask the user
*  about the following traits about the user's animal.
*  
*  Through backward chaining, these rules will fire depending on
*  how the user narrows down the template search through their
*  answers to each question. Most of these rules can be activated
*  through backward chaining, while a few only fire as dependencies
*  on other fired rules.
*  
*/




/*
*  
*  The rule (habitat ?) contains a procedural question sequence asking
*  about the habitat the animal lives in. The sequences moves from 
*  asking if the animal is an amphibian (lives on land and in water),
*  then land, then water. 
*  
*  If the user answers "yes" to a question,
*  the rest of the sequence will not be assessed, but if the user answers
*  "no", no trait will be asserted and the sequence will continue until
*  all the questions have been asked.
*
*
*  This rule is activated through backward chaining. If the system activates another
*  rule that contains the (habitat) rule, this rule will be fired to determine
*  the specific trait needed about the animal's habitat.
*  
*/
(defrule habitat
   (need-habitat ?)                                                           ;other rules must need (habitat) for this to run
   =>
   (if (eq (findTrait (vIsIt "amphibian") "habitat both") FALSE) then         ;checks first for amphibian
      (if (eq (findTrait (doesIt "live on land") "habitat land") FALSE) then  ;otherwise checks for life on land if FALSE
         (findTrait (doesIt "live in water") "habitat water")                 ;then life on water if last two are FALSE
      )
   )
) ;defrule habitat

/*
*  
*  (type ?) specifies the classification of an animal between invertebrates
*  and vertebrates. This rule contains a procedural sequence in which the 
*  system moves through the two questions, first asking the user if it is
*  an invertebrate, then if it is a vertebrate. However, if the user answers "yes"
*  to the invertebrate question, the system will not continue to ask the vertebrate
*  question.
*  
*
*  This rule is activated through backward chaining. If the system activates another
*  rule that contains the (type ?) rule, this rule will be fired to determine
*  whether or not the animal has vertebrae.
*  
*/
(defrule type
   (need-type ?)                                                              ;other rules must need the type for this to run
   =>
   (if (eq (findTrait (vIsIt "invertebrate") "type invertebrate") FALSE) then ;will assert (type invertebrate) if true, otherwise moves on
         (findTrait (isIt "vertebrate") "type vertebrate")                    ;asserts (type vertebrate) if true, otherwise nothing
   )
) ;defrule type
   

/*
*  
*  (invertType) fires only if (type invertebrate) is asserted from the (type ?)
*  rule. Even though there are more than two invertebrate types, this rule only
*  contains the two types that were used in our group's game, insect and mollusk.
*  
*  The rule moves asks the two questions procedurally, asking if the animal
*  is an insect first, then asks if it is a mollusk. If the user answers "yes"
*  to "insect", the system will not ask the user if the animal is a mollusk.
*  
*/
(defrule invertType
   (type invertebrate)                                                  ;must be an invertebrate for this rule to fire
                                                                        ;(forward chaining rather than backward chaining for this)
   =>
   (if (eq (findTrait (vIsIt "insect") "invertType insect") FALSE) then ;will assert (invertType insect) if true, otherwise moves on
      (findTrait (isIt "mollusk") "invertType mollusk")                 ;asserts (invertType mollusk) if true, otherwise nothing
   )
) ;defrule invertType


/*
*  
*  (legs ?) fires if the animal lives on land or is an amphibian (since our
*  group did not determine that there were sea animals with legs), and if
*  the system must fire another rule containing the (legs ?) rule.
*
*  The system moves through the number of legs procedurally, asking first if the animal
*  has two, four, then six legs. If the user answers "yes" to any of these
*  questions, the system will stop and assert the number of legs found through
*  the rule in the format (legs $numberOfLegs).
*  
*  
*  This rule is activated through backward chaining. If the system fires another
*  rule that contains the (legs ?) rule, this rule will be fired to find how many
*  legs the animal has.
*  
*/
(defrule legs
   (not (habitat water))                                             ;sea animals don't have legs (?)
   (need-legs ?)                                                     ;other rules must need legs for this to run
   =>
   (if (eq (findTrait (have "two legs") "legs two") FALSE) then      ;checks if animal has two legs
      (if (eq (findTrait (have "four legs") "legs four") FALSE) then ;otherwise moves to four legs if two is FALSE
         (findTrait (have "six legs") "legs six")                    ;then to six legs if last two are FALSE
      )
   )
) ;defrule legs


/*
*  
*  (diet ?) fires through backward chaining. If the system fires another rule
*  containing (diet ?), this rule will also fire to determine if those other
*  rules will complete.
*  
*  This rule moves through the questions procedurally, asking if the animal
*  is a carnivore, herbivore, then omnivore. If the user answers "yes" to any
*  of these questions, the system will stop and assert the rule that the user
*  affirms in the format (diet $typeOfDiet).
*  
*  
*/
(defrule diet
   (need-diet ?)                                                           ;backward chaining element
   =>
   (if (eq (findTrait (isIt "carnivore") "diet carnivore") FALSE) then     ;checks if animal is a carnivore
      (if (eq (findTrait (isIt "herbivore") "diet herbivore") FALSE) then  ;then if herbivore if last check is FALSE
        (findTrait (isIt "omnivore") "diet omnivore")                      ;then omnivore if the last two checks are FALSE
      )
   )
) ;defrule diet



/*
*  
*  (location ?) fires if the animal lives on land, and if the system activates
*  another rule that requires the (location ?) rule.
*  
*  This rule uses the (findTrait) function to ask four different questions
*  which will always be asked regardless of the answers to the other
*  questions in the series. The rule asks the user about specific locations
*  of where the animal lives, asking if the animal lives in Africa, Australia,
*  the tropics, and the tundra.
*  
*  While these four places are not consistent in their own types of land
*  (Africa and Australia are continents, while the tundra and tropics
*  are general regions), these locations were vital to our group's
*  Animals game, where were asked these four questions to determine
*  different animals.
*
*  This rule activates through backward chaining, and will fire
*  if the system activates another rule containing the (location ?) template.
*  
*/
(defrule location
   (habitat land)                                                   ;lives only on land
   (need-location ?)                                                ;must need a location for this rule to fire
   =>
   (findTrait (doesIt "live in Africa") "location Africa")          ;checks if the animal lives in Africa
   (findTrait (doesIt "live in Australia") "location Australia")    ;then Australia
   (findTrait (doesIt "live in the tundra") "location tundra")      ;then the tundra
   (findTrait (doesIt "live in the tropics") "location tropics")    ;then the tropics
) ;defrule location



/*
*  
*  (transportMethod ?) fires if the animal lives on land, and if the system
*  activates another rule that requires the (moves ?) template.
*  
*  Like the (location ?) rule, the (transportMethod) rule asks three
*  non-exclusive question that are asked regardless of the answer
*  to the other questions in the series. The questions here ask about
*  the animal's mode of transport, asking if it flies, runs, or crawls.
*  
*  This rule activates through backward chaining, and will fire
*  if the system activates another rule containing the (moves ?) template.
*  
*/
(defrule transportMethod
   (habitat land)                                   ;only applies to animals on land
   (need-moves ?)                                   ;only fires if an animal requires (moves)
   =>
   (findTrait (doesIt "fly") "moves flies")         ;checks if the animal can fly
   (findTrait (doesIt "run") "moves runs")          ;then if it runs
   (findTrait (doesIt "crawl") "moves crawls")      ;then if it crawls
) ;defrule transportMethod
   


/*
*  
*  (hair) fires if another rule requires the (hair) template through
*  backward chaining.
*  
*  Because we determined that fur and hair are essentially the same
*  on animals (they both have the same chemical makeup, so the only
*  difference is body placement), the (hair) and (fur) templates
*  were condensed into one.
*  
*  This rule activates through backward chaining, and will fire
*  if the system activates another rule containing the (hair) template.
*  
*/
(defrule hair
   (need-hair)                               ;only fires if another rule requires (hair)
   =>
   (findTrait (have "fur or hair") "hair")   ;checks if the animal has fur or hair
) ;defrule hair



/*
*  
*  (tentacles) fires if another rule (in this specific case, the (octopus) rule)
*  requires the (tentacles) template.
*
*/
(defrule tentacles
   (need-tentacles)                           ;only fires if another rule requires (tentacles)
   =>
   (findTrait (have "tentacles") "tentacles") ;checks if the animal has tentacles
) ;defrule tentacles






/*

Animal Rules

These rules contain the group's determined characteristics for each animal,
containing all the specificities needed to find a specific animal by activating
the Specific Trait Rules through backward chaining.

When the templates found match all the patters for a specific animal,
the RHS of the animal rule will fire, asking the user if that specific
animal is the desired result. If the user answers "yes", (findTrait)
will assert the rule (end), which will stop the questions and display
a success message. 

Otherwise, the system will continue to query the user for matches until 
the found templates do not align with one of these animals. After all
possible rules have been exhausted, the system will display a
message that says that the animal has not been found and will end.

The following rules contain characteristics for the following animals:

                        Polar Bear      Rabbit  
                        Human           Zebra   
                        Octopus         Kangaroo
                        House Fly       Frog    

*/


/*
*  
*  The (frog) rule contains basic characteristics for a frog, which are:
*  
*           a habitat in both land and water
*           four legs
*           carnivorous diet
*           vertebrae
*  
*/
(defrule frog
   (habitat both)                   ;lives both in land and water - amphibian
   (legs four)                      ;has four legs
   (diet carnivore)                 ;carnivore - eats flies
   (type vertebrate)                ;has vertebrae

   =>
   (findTrait (isIt "frog") end)
) ;defrule frog



/*
*  
*  The (zebra) rule contains basic characteristics for a zebra, which are:
*  
*              Lives only on land
*              Herbivore - eats leaves and grass
*              Has vertebrae
*              Has four legs
*              Lives in Africa
*              Has fur/hair on its body
*  
*/
(defrule zebra
   (habitat land)                   ;lives only on land
   (diet herbivore)                 ;herbivore - eats leaves and grass
   (type vertebrate)                ;has vertebrae
   (legs four)                      ;has four legs
   (location Africa)                ;lives in Africa
   (hair)                           ;has fur/hair on its body
   =>
   (findTrait (isIt "zebra") end)
) ;defrule zebra



/*
*  
*  The (fly) rule contains basic characteristics of a fly, which are:
*  
*                 Lives only on land
*                 Carnivore - scavenger
*                 Flies
*                 Crawls when not flying
*                 Insect - Class insecta
*                 Found in tropics, Africa, and Australia.
*                 Has six legs
*  
*/
(defrule fly
   
   (habitat land)                   ;lives only on land
   (diet carnivore)                 ;carnivore - scavenger
   (moves flies)                    ;flies around
   (moves crawls)                   ;crawls when not flying
   (invertType insect)              ;insect - Class insecta
   (location tropics)               ;found in tropics,
   (location Africa)                ;Africa,
   (location Australia)             ;and Australia.
   (legs six)                       ;Has six legs
   =>
   (findTrait (isIt "fly") end)
) ;defrule fly



/*
*  
*  The (octopus) rule contains an octopus's basic characteristics, which are:
*  
*                 Lives only on water
*                 Carnivore: eats snails, clams, shellfish, etc.
*                 In the Phylum Mollusca
*                 Has tentacles
*  
*  
*/
(defrule octopus
   (habitat water)                     ;lives only on water
   (diet carnivore)                    ;carnivore: eats snails,clams, etc.
   (invertType mollusk)                ;part of the phylum Mollusca
   (tentacles)                         ;has tentacles
   =>
   (findTrait (vIsIt "octopus") end)
) ;defrule octopus


/*
*  
*  The (kangaroo) rule contains a kangaroo's basic characteristics, which are:
*  
*                 Lives only on land (in Australia)
*                 Has four legs: two strong hind legs and two small forelegs
*                 Has vertebrae
*                 Eats mainly grass
*                 Has fur/hair on body
*                 Lives in Australia, the land of marsupials
*  
*  
*/
(defrule kangaroo
   (habitat land)                   ;lives only on land
   (legs four)                      ;strong hind legs, two small forelegs
   (type vertebrate)                ;has vertebrae
   (diet herbivore)                 ;eats mainly grass
   (hair)                           ;has fur/hair on body
   (location Australia)             ;lives in Australia, land of marsupials
   =>
   (findTrait (isIt "kangaroo") end)
) ;defrule kangaroo


/*
*  
*  The (polarBear) rule contains a polar bear's basic characteristics, which are:
*  
*                 Lives only on land
*                 Four legs
*                 Eats mainly seals
*                 Has vertebrae
*                 Lives in tundra (and on Arctic ice)
*                 Has very effective fur
*                 Crawls on four legs
*  
*  
*/
(defrule polarBear
   (habitat land)                   ;lives only on land
   (legs four)                      ;four legs
   (diet carnivore)                 ;eats mainly seals
   (type vertebrate)                ;has vertebrae
   (location tundra)                ;lives in tundra (Arctic)
   (hair)                           ;has lots of fur
   (moves crawls)                   ;crawls on four legs
   =>
   (findTrait (isIt "polar bear") end)
) ;defrule polarBear


/*
*  
*  The (rabbit) rule contains a rabbit's basic characteristics, which are:
*  
*                 Lives only on land
*                 Two small forelegs and two hind legs
*                 Has vertebrae
*                 Has fur on its body
*                 Eats hay and grass
*                 Live all over the world, including the tundra, Africa,
*                      Australia, and the tropics
*  
*/
(defrule rabbit
   (habitat land)                   ;lives only on land
   (legs four)                      ;small forelegs, two hind legs
   (type vertebrate)                ;has vertebrae
   (hair)                           ;fur/hair on body
   (diet herbivore)                 ;eats hay/grass
   
   (location tundra)                ;rabbits live all over the world
   (location Australia)             ;including the tundra, Africa,
   (location Africa)                ;Australia, and the tropics
   (location tropics)
   =>
   (findTrait (isIt "rabbit") end)
) ;defrule rabbit


/*
*  
*  The (human) rule contains a human's basic characteristics, which are:
*  
*                 Lives only on land
*                 Has vertebrae
*                 Eats both meat and vegetables
*                 Walks on two legs
*                 Live everywhere, including Africa, Australia,
*                       the tropics, and the tundra
*                 Runs on two legs when needed
*  
*  
*/
(defrule human
   (habitat land)                   ;lives only on land
   
   (type vertebrate)                ;has vertebrae
   
   (diet omnivore)                  ;eats both meat and vegetables
   
   (legs two)                       ;walks on two legs
   
   (location tropics)               ;humans live everywhere in
   (location tundra)                ;the world, including these
   (location Africa)                ;four places.
   (location Australia)
   
   (moves runs)                     ;runs on two legs when needed
   =>
   (findTrait (isIt "human") end)
) ;defrule human





/*
*  
*  End Rules
*  
*  
*  These two rules are run either when an animal rule is fired and (end) is asserted
*  or the user has inputted a combination of traits that do not match up to an
*  animal, and the noMatch rule is fired.
*
*/

/*
* 
*  The (end) rule fires when the RHS of an animal rule fires, and the user answers
*  "yes" to a question asking about a specific animal. If (end) is fired, the
*  system will print out a success message, then will stop firing any remaining rules
*  with the (halt) function.
* 
*/
(defrule end
   (end)                                                                       ;rule asserted when an animal is found
   =>
   (printout t crlf "                      Your animal has been found!" crlf)  ;success message! (with spaces for formatting)
   (halt)                                                                      ;stops any remaining rules from firing
) ;defrule end


/*
*  
*  The (noMatch) rule will fire when no animals have been found (the (end) rule has not fired)
*  and every possible rule and combination has fired based on the user's input.
*  
*  To get the desired output of being the very last rule fired, (declare (salience -100))
*  will force the priority of the (noMatch) rule to be the lowest possible, firing every
*  rule until nothing else fires. If an end match is found, this rule will not fire. Otherwise,
*  if the system cannot find anymore matches, then the message 
*  "Sorry, I couldn't find a match for your animal" will display.
*  
*/
(defrule noMatch
   (declare (salience -100))                                                                  ;forces the noMatch rule to be
                                                                                              ;the lowest priority rule, only
                                                                                              ;activating if all the other rules
                                                                                              ;have fired
   
   (not (end))                                                                                ;only fires if an animal hasn't been found
   =>
   (printout t crlf "                 Sorry, I couldn't find a match for your animal." crlf)  ;the system cannot find an animal
                                                                                              ;and must display an unsuccessful message
                                                                                              ;(with spaces for formatting)
) ;defrule noMatch 






/*
*  
*  User Interface and Start of Game
*  
*  When the user runs this file, they will see a small user interface that
*  will allow them to see the documentation before they play the game.
*  
*  Otherwise, they can continue onto the game by typing anything else and
*  pressing ENTER.
*  
*/


(bind ?answer (ask                                                           ;takes the answer from the user to determine whether
                                                                             ;or not to display the documentation

"
***************************************************************************
*             Welcome to the Backward Chaining Animals Game!              *
*           Type YES if you would like to see the documentation.          *
*         Otherwise, type anything else, then press ENTER to begin!       * 
*                                                                         *
                                     "                                       ;first part of the user interface, welcoming user and
                                                                             ;asking if they want to see the documentation
               )
)

(if (eq ?answer YES) then                                                    ;will display documenation using (doc) if user says YES
    (doc)
)


(printout t                                                                  ;if YES, doc is displayed then the game starts. Otherwise,
                                                                             ;the game starts anyway.
"***************************************************************************


           Please answer with \"yes\" or \"no\", case-sensitive

")                                                                           ;tells user how to answer each question
(run)                                                                        ;runs the game