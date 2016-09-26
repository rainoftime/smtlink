(in-package "ACL2")
(defun ACL22SMT () 
  (list
    (list #\# #\Space "Copyright" #\Space #\( "C" #\) #\Space "2015" #\, #\Space "University" #\Space "of" #\Space "British" #\Space "Columbia"  #\Newline )
    (list #\# #\Space "Written" #\Space #\( "originally" #\) #\Space "by" #\Space "Mark" #\Space "Greenstreet" #\Space #\( "13th" #\Space "March" #\, #\Space "2014" #\)  #\Newline )
    (list #\#  #\Newline )
    (list #\# #\Space "License" #\: #\Space "A" #\Space "3" "-" "clause" #\Space "BSD" #\Space "license" #\.  #\Newline )
    (list #\# #\Space "See" #\Space "the" #\Space "LICENSE" #\Space "file" #\Space "distributed" #\Space "with" #\Space "this" #\Space "software"  #\Newline )
    (list  #\Newline )
    (list "from" #\Space "z3" #\Space "import" #\Space "*" #\# #\Space "Solver" #\, #\Space "Bool" #\, #\Space "Int" #\, #\Space "Real" #\, #\Space "BoolSort" #\, #\Space "IntSort" #\, #\Space "RealSort" #\, #\Space "And" #\, #\Space "Or" #\, #\Space "Not" #\, #\Space "Implies" #\, #\Space "sat" #\, #\Space "unsat" #\, #\Space "Array" #\, #\Space "Select" #\, #\Space "Store" #\, #\Space "ToInt" #\, #\Space "Q" #\, #\Space "If"  #\Newline )
    (list  #\Newline )
    (list "def" #\Space "sort" #\( "x" #\) #\:  #\Newline )
    (list #\Space #\Space #\Space #\Space "if" #\Space "type" #\( "x" #\) #\Space "=" "=" #\Space "bool" #\: #\Space #\Space #\Space #\Space "return" #\Space "BoolSort" #\( #\)  #\Newline )
    (list #\Space #\Space #\Space #\Space "elif" #\Space "type" #\( "x" #\) #\Space "=" "=" #\Space "int" #\: #\Space #\Space #\Space "return" #\Space "IntSort" #\( #\)  #\Newline )
    (list #\Space #\Space #\Space #\Space "elif" #\Space "type" #\( "x" #\) #\Space "=" "=" #\Space "float" #\: #\Space "return" #\Space "RealSort" #\( #\)  #\Newline )
    (list #\Space #\Space #\Space #\Space "elif" #\Space "hasattr" #\( "x" #\, #\Space #\' "sort" #\' #\) #\:  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "if" #\Space "x" #\. "sort" #\( #\) #\Space "=" "=" #\Space "BoolSort" #\( #\) #\: #\Space "return" #\Space "BoolSort" #\( #\)  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "if" #\Space "x" #\. "sort" #\( #\) #\Space "=" "=" #\Space "IntSort" #\( #\) #\: #\Space #\Space "return" #\Space "IntSort" #\( #\)  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "if" #\Space "x" #\. "sort" #\( #\) #\Space "=" "=" #\Space "RealSort" #\( #\) #\: #\Space "return" #\Space "RealSort" #\( #\)  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "else" #\:  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "raise" #\Space "Exception" #\( #\' "unknown" #\Space "sort" #\Space "for" #\Space "expression" #\' #\)  #\Newline )
    (list  #\Newline )
    (list "class" #\Space "ACL22SMT" #\( "object" #\) #\:  #\Newline )
    (list #\Space #\Space #\Space #\Space "class" #\Space "status" #\:  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "def" #\Space "__init__" #\( "self" #\, #\Space "value" #\) #\:  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "self" #\. "value" #\Space "=" #\Space "value"  #\Newline )
    (list  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "def" #\Space "__str__" #\( "self" #\) #\:  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "if" #\( "self" #\. "value" #\Space "is" #\Space "True" #\) #\: #\Space "return" #\Space #\' "QED" #\'  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "elif" #\( "self" #\. "value" #\. "__class__" #\Space "=" "=" #\Space #\' "msg" #\' #\. "__class__" #\) #\: #\Space "return" #\Space "self" #\. "value"  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "else" #\: #\Space "raise" #\Space "Exception" #\( #\' "unknown" #\Space "status" "?" #\' #\)  #\Newline )
    (list  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "def" #\Space "isThm" #\( "self" #\) #\:  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "return" #\( "self" #\. "value" #\Space "is" #\Space "True" #\)  #\Newline )
    (list  #\Newline )
    (list #\Space #\Space #\Space #\Space "class" #\Space "atom" #\: #\Space #\Space #\# #\Space "added" #\Space "my" #\Space "mrg" #\, #\Space "21" #\Space "May" #\Space "2015"  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "def" #\Space "__init__" #\( "self" #\, #\Space "string" #\) #\:  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "self" #\. "who_am_i" #\Space "=" #\Space "string" #\. "lower" #\( #\)  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "def" #\Space "__eq__" #\( "self" #\, #\Space "other" #\) #\:  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "return" #\( "self" #\. "who_am_i" #\Space "=" "=" #\Space "other" #\. "who_am_i" #\)  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "def" #\Space "__ne__" #\( "self" #\, #\Space "other" #\) #\:  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "return" #\( "self" #\. "who_am_i" #\Space "!" "=" #\Space "other" #\. "who_am_i" #\)  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "def" #\Space "__str__" #\( "self" #\) #\:  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "return" #\( "self" #\. "who_am_i" #\)  #\Newline )
    (list  #\Newline )
    (list #\Space #\Space #\Space #\Space "def" #\Space "__init__" #\( "self" #\, #\Space "solver" "=" "0" #\) #\:  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "if" #\( "solver" #\Space "!" "=" #\Space "0" #\) #\: #\Space "self" #\. "solver" #\Space "=" #\Space "solver"  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "else" #\: #\Space "self" #\. "solver" #\Space "=" #\Space "Solver" #\( #\)  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "self" #\. "nameNumber" #\Space "=" #\Space "0"  #\Newline )
    (list  #\Newline )
    (list #\Space #\Space #\Space #\Space "def" #\Space "newVar" #\( "self" #\) #\:  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "varName" #\Space "=" #\Space #\' "$" #\' #\Space "+" #\Space "str" #\( "self" #\. "nameNumber" #\)  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "self" #\. "nameNumber" #\Space "=" #\Space "self" #\. "nameNumber" "+" "1"  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "return" #\Space "varName"  #\Newline )
    (list  #\Newline )
    (list #\Space #\Space #\Space #\Space "def" #\Space "isBool" #\( "self" #\, #\Space "who" #\) #\: #\Space "return" #\Space "Bool" #\( "who" #\)  #\Newline )
    (list #\Space #\Space #\Space #\Space "def" #\Space "isInt" #\( "self" #\, #\Space "who" #\) #\: #\Space "return" #\Space "Int" #\( "who" #\)  #\Newline )
    (list #\Space #\Space #\Space #\Space "def" #\Space "isReal" #\( "self" #\, #\Space "who" #\) #\: #\Space "return" #\Space "Real" #\( "who" #\)  #\Newline )
    (list #\Space #\Space #\Space #\Space "def" #\Space "plus" #\( "self" #\, #\Space "*" "args" #\) #\: #\Space "return" #\Space "reduce" #\( "lambda" #\Space "x" #\, #\Space "y" #\: #\Space "x" "+" "y" #\, #\Space "args" #\)  #\Newline )
    (list #\Space #\Space #\Space #\Space "def" #\Space "times" #\( "self" #\, #\Space "*" "args" #\) #\: #\Space "return" #\Space "reduce" #\( "lambda" #\Space "x" #\, #\Space "y" #\: #\Space "x" "*" "y" #\, #\Space "args" #\)  #\Newline )
    (list  #\Newline )
    (list #\Space #\Space #\Space #\Space "def" #\Space "reciprocal" #\( "self" #\, #\Space "x" #\) #\:  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "if" #\( "type" #\( "x" #\) #\Space "is" #\Space "int" #\) #\: #\Space "return" #\( "Q" #\( "1" #\, "x" #\) #\)  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "elif" #\( "type" #\( "x" #\) #\Space "is" #\Space "float" #\) #\: #\Space "return" #\Space "1" #\. "0" "/" "x"  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "else" #\: #\Space "return" #\Space "1" #\. "0" "/" "x"  #\Newline )
    (list  #\Newline )
    (list #\Space #\Space #\Space #\Space "def" #\Space "negate" #\( "self" #\, #\Space "x" #\) #\: #\Space "return" #\Space "-" "x"  #\Newline )
    (list #\Space #\Space #\Space #\Space "def" #\Space "lt" #\( "self" #\, #\Space "x" #\, "y" #\) #\: #\Space "return" #\Space "x" "<" "y"  #\Newline )
    (list #\Space #\Space #\Space #\Space "def" #\Space "equal" #\( "self" #\, #\Space "x" #\, "y" #\) #\: #\Space "return" #\Space "x" "=" "=" "y"  #\Newline )
    (list #\Space #\Space #\Space #\Space "def" #\Space "notx" #\( "self" #\, #\Space "x" #\) #\: #\Space "return" #\Space "Not" #\( "x" #\)  #\Newline )
    (list #\Space #\Space #\Space #\Space "def" #\Space "implies" #\( "self" #\, #\Space "x" #\, #\Space "y" #\) #\: #\Space "return" #\Space "Implies" #\( "x" #\, "y" #\)  #\Newline )
    (list #\Space #\Space #\Space #\Space "def" #\Space "Qx" #\( "self" #\, #\Space "x" #\, #\Space "y" #\) #\: #\Space "return" #\Space "Q" #\( "x" #\, "y" #\)  #\Newline )
    (list  #\Newline )
    (list #\Space #\Space #\Space #\Space #\# #\Space "type" #\Space "related" #\Space "functions"  #\Newline )
    (list #\Space #\Space #\Space #\Space "def" #\Space "integerp" #\( "self" #\, #\Space "x" #\) #\: #\Space "return" #\Space "sort" #\( "x" #\) #\Space "=" "=" #\Space "IntSort" #\( #\)  #\Newline )
    (list #\Space #\Space #\Space #\Space "def" #\Space "rationalp" #\( "self" #\, #\Space "x" #\) #\: #\Space "return" #\Space "sort" #\( "x" #\) #\Space "=" "=" #\Space "RealSort" #\( #\)  #\Newline )
    (list #\Space #\Space #\Space #\Space "def" #\Space "booleanp" #\( "self" #\, #\Space "x" #\) #\: #\Space "return" #\Space "sort" #\( "x" #\) #\Space "=" "=" #\Space "BoolSort" #\( #\)  #\Newline )
    (list  #\Newline )
    (list #\Space #\Space #\Space #\Space "def" #\Space "ifx" #\( "self" #\, #\Space "condx" #\, #\Space "thenx" #\, #\Space "elsex" #\) #\:  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "return" #\Space "If" #\( "condx" #\, #\Space "thenx" #\, #\Space "elsex" #\)  #\Newline )
    (list  #\Newline )
    (list #\Space #\Space #\Space #\Space #\# #\Space #\# #\Space "usage" #\Space "prove" #\( "claim" #\) #\Space "or" #\Space "prove" #\( "hypotheses" #\, #\Space "conclusion" #\)  #\Newline )
    (list #\Space #\Space #\Space #\Space #\# #\Space "def" #\Space "prove" #\( "self" #\, #\Space "hypotheses" #\, #\Space "conclusion" "=" "0" #\) #\:  #\Newline )
    (list #\Space #\Space #\Space #\Space #\# #\Space #\Space #\Space #\Space #\Space "if" #\( "conclusion" #\Space "is" #\Space "0" #\) #\: #\Space "claim" #\Space "=" #\Space "hypotheses"  #\Newline )
    (list #\Space #\Space #\Space #\Space #\# #\Space #\Space #\Space #\Space #\Space "else" #\: #\Space "claim" #\Space "=" #\Space "Implies" #\( "hypotheses" #\, #\Space "conclusion" #\)  #\Newline )
    (list  #\Newline )
    (list #\Space #\Space #\Space #\Space #\# #\Space #\Space #\Space #\Space #\Space "self" #\. "solver" #\. "push" #\( #\)  #\Newline )
    (list #\Space #\Space #\Space #\Space #\# #\Space #\Space #\Space #\Space #\Space "self" #\. "solver" #\. "add" #\( "Not" #\( "claim" #\) #\)  #\Newline )
    (list #\Space #\Space #\Space #\Space #\# #\Space #\Space #\Space #\Space #\Space "res" #\Space "=" #\Space "self" #\. "solver" #\. "check" #\( #\)  #\Newline )
    (list  #\Newline )
    (list #\Space #\Space #\Space #\Space #\# #\Space #\Space #\Space #\Space #\Space "if" #\Space "res" #\Space "=" "=" #\Space "unsat" #\:  #\Newline )
    (list #\Space #\Space #\Space #\Space #\# #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "print" #\Space #\" "proved" #\"  #\Newline )
    (list #\Space #\Space #\Space #\Space #\# #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "return" #\Space "self" #\. "status" #\( "True" #\) #\Space #\Space #\# #\Space "It" #\' "s" #\Space "a" #\Space "theorem"  #\Newline )
    (list #\Space #\Space #\Space #\Space #\# #\Space #\Space #\Space #\Space #\Space "elif" #\Space "res" #\Space "=" "=" #\Space "sat" #\:  #\Newline )
    (list #\Space #\Space #\Space #\Space #\# #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "print" #\Space #\" "counterexample" #\"  #\Newline )
    (list #\Space #\Space #\Space #\Space #\# #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "m" #\Space "=" #\Space "self" #\. "solver" #\. "model" #\( #\)  #\Newline )
    (list #\Space #\Space #\Space #\Space #\# #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "print" #\Space "m"  #\Newline )
    (list #\Space #\Space #\Space #\Space #\# #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\# #\Space "return" #\Space "an" #\Space "counterexample"  #\Newline )
    (list #\Space #\Space #\Space #\Space #\# #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "return" #\Space "self" #\. "status" #\( "False" #\)  #\Newline )
    (list #\Space #\Space #\Space #\Space #\# #\Space #\Space #\Space #\Space #\Space "else" #\:  #\Newline )
    (list #\Space #\Space #\Space #\Space #\# #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "print" #\Space #\" "failed" #\Space "to" #\Space "prove" #\"  #\Newline )
    (list #\Space #\Space #\Space #\Space #\# #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "r" #\Space "=" #\Space "self" #\. "status" #\( "False" #\)  #\Newline )
    (list  #\Newline )
    (list #\Space #\Space #\Space #\Space #\# #\Space #\Space #\Space #\Space #\Space "self" #\. "solver" #\. "pop" #\( #\)  #\Newline )
    (list #\Space #\Space #\Space #\Space #\# #\Space #\Space #\Space #\Space #\Space "return" #\( "r" #\)  #\Newline )
    (list  #\Newline )
    (list #\Space #\Space #\Space #\Space "def" #\Space "proof_success" #\( "self" #\) #\:  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "print" #\Space #\" "proved" #\"  #\Newline )
    (list  #\Newline )
    (list #\Space #\Space #\Space #\Space #\# #\Space "finds" #\Space "variable" #\Space "names"  #\Newline )
    (list #\Space #\Space #\Space #\Space "def" #\Space "var_lst" #\Space #\( "self" #\, #\Space "lst" #\, #\Space "ret" #\) #\:  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "llen" #\Space "=" #\Space "len" #\( "lst" #\)  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "i" #\Space "=" #\Space "0"  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "while" #\Space "i" #\Space "<" #\Space "llen" #\:  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "if" #\Space "lst" "[" "i" "]" #\. "children" #\( #\) #\Space "=" "=" #\Space "[" "]" #\:  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "st" #\Space "=" #\Space "str" #\( "lst" "[" "i" "]" #\) #\. "replace" #\( #\" "-" #\" #\, #\Space #\" #\" #\) #\. "replace" #\( #\" #\. #\" #\, #\" #\" #\) #\. "replace" #\( #\" "/" #\" #\, #\Space #\" #\" #\)  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "if" #\Space "not" #\Space "st" #\. "isdigit" #\( #\) #\:  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "ret" #\. "append" #\( "st" #\)  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "else" #\:  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "if" #\Space "isinstance" #\( "lst" "[" "i" "]" #\. "children" #\( #\) #\, "list" #\) #\:  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "self" #\. "var_lst" #\Space #\( "lst" "[" "i" "]" #\. "children" #\( #\) #\, #\Space "ret" #\)  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "i" #\Space "+" "=" #\Space "1"  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "return" #\Space "list" #\( "set" #\( "ret" #\) #\) ";"  #\Newline )
    (list  #\Newline )
    (list #\Space #\Space #\Space #\Space #\# #\Space "concatonate"  #\Newline )
    (list #\Space #\Space #\Space #\Space "def" #\Space "conc_var_lst" #\Space #\( "self" #\, #\Space "st" #\, #\Space "lst" #\) #\:  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "le" #\Space "=" #\Space "len" #\( "lst" #\)  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "m" #\Space "=" #\Space "self" #\. "solver" #\. "model" #\( #\)  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "i" #\Space "=" #\Space "0"  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "while" #\Space "i" #\Space "<" #\Space "le" #\:  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "if" #\Space #\( "st" #\. "find" #\( #\" #\( #\" "+" "lst" "[" "i" "]" "+" #\" #\Space #\" #\) #\Space "=" "=" #\Space "-" "1" #\) #\Space "and" #\Space "not" #\( "lst" "[" "i" "]" #\Space "=" "=" #\Space #\' "False" #\' #\) #\Space "and" #\Space "not" #\( "lst" "[" "i" "]" #\Space "=" "=" #\Space #\' "True" #\' #\) #\:  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "if" #\Space "is_bool" #\( "eval" #\( "lst" "[" "i" "]" #\) #\) #\:  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "st" #\Space "=" #\Space "st" #\Space "+" #\Space #\" #\Space #\( #\" "+" "lst" "[" "i" "]" "+" #\" #\Space #\( "cex" "-" "trivial" #\Space "nil" #\) #\) #\"  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "else" #\:  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "st" #\Space "=" #\Space "st" #\Space "+" #\Space #\" #\Space #\( #\" "+" "lst" "[" "i" "]" "+" #\" #\Space #\( "cex" "-" "trivial" #\Space "0" #\) #\) #\"  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "i" #\Space "+" "=" #\Space "1"  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "return" #\Space "st"  #\Newline )
    (list  #\Newline )
    (list #\Space #\Space #\Space #\Space "def" #\Space "pymodel_to_lisp" #\( "self" #\) #\:  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "m" #\Space "=" #\Space "self" #\. "solver" #\. "model" #\( #\)  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "l" #\Space "=" #\Space "len" #\( "m" #\)  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "s" #\Space "=" #\Space #\" #\"  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "i" #\Space "=" #\Space "0"  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "while" #\Space "i" #\Space "<" #\Space "l" #\:  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "if" #\Space #\( "is_rational_value" #\( "m" "[" "m" "[" "i" "]" "]" #\) #\) #\Space "or" #\Space #\( "is_bool" #\( "m" "[" "m" "[" "i" "]" "]" #\) #\) #\:  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "val_str" #\Space "=" #\Space "str" #\( "m" "[" "m" "[" "i" "]" "]" #\) #\. "replace" #\( #\" #\. "0" #\" #\, #\Space #\" #\" #\) #\. "replace" #\( #\" "False" #\" #\, #\Space #\" "nil" #\" #\) #\. "replace" #\( #\" "True" #\" #\, #\" "t" #\" #\)  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "s" #\Space "=" #\Space "s" #\Space "+" #\Space #\" #\Space #\( #\" #\Space "+" #\Space "str" #\( "m" "[" "i" "]" #\) #\Space "+" #\Space #\" #\Space #\" #\Space "+" #\Space "val_str" #\Space "+" #\Space #\" #\) #\"  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "else" #\:  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "rt_obj" #\Space "=" #\Space "str" #\( "m" "[" "m" "[" "i" "]" "]" #\. "sexpr" #\( #\) #\)  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "rt_obj" #\Space "=" #\Space "rt_obj" #\. "replace" #\( #\" "root" "-" "obj" #\" #\, #\Space #\" "cex" "-" "root" "-" "obj" #\Space #\" #\Space "+" #\Space #\" #\' #\" #\Space "+" #\Space "str" #\( "m" "[" "i" "]" #\) #\Space "+" #\Space #\" #\Space "state" #\" #\)  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "rt_obj" #\Space "=" #\Space "rt_obj" #\. "replace" #\( #\" #\( "+" #\" #\, #\Space #\" #\' #\( "+" #\" #\)  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "s" #\Space "=" #\Space "s" #\Space "+" #\Space #\" #\Space #\( #\" #\Space "+" #\Space "str" #\( "m" "[" "i" "]" #\) #\Space "+" #\Space #\" #\Space #\" #\Space "+" #\Space "rt_obj" #\Space "+" #\Space #\" #\) #\"  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "i" #\Space "=" #\Space "i" #\Space "+" #\Space "1"  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "return" #\Space "s"  #\Newline )
    (list  #\Newline )
    (list #\Space #\Space #\Space #\Space "def" #\Space "parse_cex" #\Space #\( "self" #\, #\Space "st" #\) #\:  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "s1" #\Space "=" #\Space "st" #\. "replace" #\( #\" #\( #\) #\Space #\" #\, #\Space #\" #\" #\)  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "s2" #\Space "=" #\Space "s1" #\. "replace" #\( #\" "define" "-" "fun" #\Space #\" #\, #\Space #\" #\" #\)  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "s3" #\Space "=" #\Space "s2" #\. "replace" #\( #\" "Real" #\" #\, #\Space #\" #\" #\)  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "s3" #\Space "=" #\Space "s3" #\. "replace" #\( #\" #\. "0" #\" #\, #\Space #\" #\" #\)  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "s4" #\Space "=" #\Space "s3" #\. "split" #\( #\)  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "s5" #\Space "=" #\Space #\' #\Space #\' #\. "join" #\( "s4" #\)  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "return" #\Space "s5"  #\Newline )
    (list  #\Newline )
    (list #\Space #\Space #\Space #\Space "def" #\Space "proof_counterExample" #\( "self" #\) #\:  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "thing" #\Space "=" #\Space "self" #\. "pymodel_to_lisp" #\( #\)  #\Newline )
    (list  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "m" #\Space "=" #\Space "self" #\. "solver" #\. "model" #\( #\)  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "a" #\Space "=" #\Space "self" #\. "solver" #\. "assertions" #\( #\)  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "s0" #\Space "=" #\Space "m" #\. "sexpr" #\( #\)  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "s5" #\Space "=" #\Space "self" #\. "pymodel_to_lisp" #\( #\)  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "alst" #\Space "=" #\Space "self" #\. "var_lst" #\( "a" #\, #\Space "[" "]" #\)  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "s6" #\Space "=" #\Space "self" #\. "conc_var_lst" #\( "s5" #\, #\Space "alst" #\)  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "print" #\Space #\" #\( #\" #\Space "+" #\Space #\Space "s6" #\Space "+" #\Space #\" #\) #\"  #\Newline )
    (list  #\Newline )
    (list #\Space #\Space #\Space #\Space "def" #\Space "proof_fail" #\( "self" #\) #\:  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "print" #\Space #\" "failed" #\Space "to" #\Space "prove" #\"  #\Newline )
    (list  #\Newline )
    (list #\Space #\Space #\Space #\Space #\# #\Space "usage" #\Space "prove" #\( "claim" #\) #\Space "or" #\Space "prove" #\( "hypotheses" #\, #\Space "conclusion" #\)  #\Newline )
    (list #\Space #\Space #\Space #\Space "def" #\Space "prove" #\( "self" #\, #\Space "hypotheses" #\, #\Space "conclusion" "=" "0" #\) #\:  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "if" #\( "conclusion" #\Space "is" #\Space "0" #\) #\: #\Space "claim" #\Space "=" #\Space "hypotheses"  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "else" #\: #\Space "claim" #\Space "=" #\Space "Implies" #\( "hypotheses" #\, #\Space "conclusion" #\)  #\Newline )
    (list  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "self" #\. "solver" #\. "push" #\( #\)  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "self" #\. "solver" #\. "add" #\( "Not" #\( "claim" #\) #\)  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "res" #\Space "=" #\Space "self" #\. "solver" #\. "check" #\( #\)  #\Newline )
    (list  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "if" #\Space "res" #\Space "=" "=" #\Space "unsat" #\: #\Space "self" #\. "proof_success" #\( #\)  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "elif" #\Space "res" #\Space "=" "=" #\Space "sat" #\: #\Space "self" #\. "proof_counterExample" #\( #\)  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "else" #\: #\Space "self" #\. "proof_fail" #\( #\)  #\Newline )
    (list  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "self" #\. "solver" #\. "pop" #\( #\)  #\Newline )
    (list #\Space #\Space #\Space #\Space #\Space #\Space #\Space #\Space "return" #\( "self" #\. "status" #\( "res" #\Space "=" "=" #\Space "unsat" #\) #\)  #\Newline )
    (list  #\Newline )
    (list  #\Newline )
))