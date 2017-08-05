(do-backward-chaining modern)

(defrule modernBackward "Rule to Backward-Chain the characteristic Modern"
    (need-modern ?)
    =>
    (printout t "asserting modern to no" crlf)
    (assert (modern no))
)

(defrule rule1  "match modern and classical patterns, comment out classical and it will still fire"
    (modern no)
    (classical yes)
    =>
    (printout t "modern no classical yes" crlf)
)

(defrule rule2 "match on modern yes"
    (modern yes)
    =>
    (printout t "modern yes" crlf)
)

(defrule rule3 "match on modern no"
    (modern no)
    =>
    (printout t "modern no" crlf)
)

(defrule rule4 "match on classical yes"
    (classical yes)
    =>
    (printout t "classical yes" crlf)
)

(reset)

(assert (classical yes))

(run)
