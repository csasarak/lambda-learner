{
module Parser (Exp(..), AppExp(..), Value(..), Var(..), parseFromFile) where
import Scanner
}

%name parse
%tokentype {Scanner.Token}
%error { parseError }

%token
   '('		{S_Lparen}
   '\\'		{S_Bslash}
   '.'		{S_Period}
   ')'		{S_Rparen}
   '+'		{S_Plus}
   '-'		{S_Minus}
   if 		{S_If}
   then		{S_Then}
   else		{S_Else}
   dig		{S_Int $$}
   var		{S_Var $$}
   fix		{S_Fix}

%%

Exp
	: AppExp '+' Exp		{Plus $1 $3}
	| AppExp '-' Exp		{Minus $1 $3}
	| if AppExp then Exp else Exp	{If $2 $4 $6}
	| fix AppExp			{Fix $2}
	| AppExp			{AppExp $1}

AppExp
	: Val AppExp			{AppV $1 $2}
	| '(' Exp ')' AppExp		{AppE $2 $4}
	| '(' Exp ')'			{Nest $2}
	| Val				{Value $1}

Val
	: dig				{Int $1}
	| Var				{Variable $1}
	| Lam				{$1}

Lam
	: '(' '\\' Var '.' Exp ')'	{Lam $3 $5}

Var
	: var				{Var $1}

{
parseError :: [Token] -> a
parseError _ = error "Parse Error"

data Exp =
        Plus AppExp Exp
      | Minus AppExp Exp
      | If AppExp Exp Exp
      | Fix AppExp
      | AppExp AppExp

instance Show Exp where
   show (Plus ae e) = let strAe = show ae
                          strE = show e
	              in strAe ++ " + " ++ strE
   show (Minus ae e) = let strAe = show ae
                           strE = show e
	               in strAe ++ " - " ++ strE
   show (If ae et ee) = let strAe = show ae
                            strEt = show et
		            strEe = show ee
		        in "if " ++ strAe ++ " then " ++ strEt ++ " else " ++ strEe
   show (Fix ae) = let strAe = show ae
                   in "fix " ++ strAe
   show (AppExp ae) = show ae

data AppExp =
	AppV Value AppExp
      | AppE Exp AppExp
      | Nest Exp
      | Value Value

instance Show AppExp where
   show (AppV v ae) = let strV = show v
                          strAe = show ae
		      in strV ++ " " ++ strAe
   show (AppE e ae) = let strE = show e
                          strAe = show ae
                      in strE ++ " " ++ strAe
   show (Nest e) = let strE = show e
                   in "(" ++ strE ++ ")"
   show (Value v) = show v


data Var =
	Var Char
	deriving Eq

instance Show Var where
   show (Var c) = c:""

data Value =
        Int Int
      | Lam Var Exp
      | Variable Var

instance Show Value where
   show (Int i) = show i
   show (Lam v e) = let strV = show v
                        strE = show e
                     in "(\\" ++ strV ++ ". " ++ strE ++ ")"
   show (Variable v) = show v

parseFromFile fil =
   do
      toks <- Scanner.lexFromFile fil
      return (p_lam toks)
}
