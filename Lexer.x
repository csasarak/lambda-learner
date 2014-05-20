{
module Scanner (Token(..), lexFromFile, lexFromFileToFile, alexScanTokens) where
}

%wrapper "basic"

$digit = 0-9
$alpha = [a-zA-Z]
$upper = [A-Z]
$lower = [a-z]

tokens :-
   $white+			;
   "("				{ \s -> S_Lparen }
   "\"          		{ \s -> S_Bslash }
   "."				{ \s -> S_Period }
   ")"				{ \s -> S_Rparen }
   "+"				{ \s -> S_Plus }
   "-"				{ \s -> S_Minus }
   "->"				{ \s -> S_Arrow }
   "if"				{ \s -> S_If }
   "then"			{ \s -> S_Then }
   "else"			{ \s -> S_Else }
   $digit+			{ \s -> S_Int (read s) }
   $alpha			{ \s -> S_Var (head s) }
   fix				{ \s -> S_Fix }

{
data Token =
   S_Lparen
 | S_Bslash
 | S_Period
 | S_Rparen
 | S_Plus
 | S_Minus
 | S_Arrow
 | S_If
 | S_Then
 | S_Else
 | S_Int Int
 | S_Var Char
 | S_Fix
   deriving (Eq,Show)

lexFromFile fil = 
   do
      s <- readFile fil
      let toks = (alexScanTokens s)
      return toks

lexFromFileToFile infile outfile = 
   do
      toks <- lexFromFile infile
      let stoks = show toks
      writeFile outfile stoks

main = 
   do
      s <- getContents
      print (alexScanTokens s)
}
