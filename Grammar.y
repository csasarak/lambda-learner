{
module Parser where
import Scanner
}

%name p_lam
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
	: Lam AppExp			{AppV $1 $2}
	| '(' Exp ')' AppExp		{AppE $2 $4}
	| '(' Exp ')'			{Nest $2}
	| Val				{Value $1}

Val
	: dig				{Int $1}
	| Var				{Variable $1}
	| Lam				{$1}

Lam
	: '(' '\\' Args '.' Exp ')'	{Lam $3 $5}

Var
	: var				{Var $1}

Args
	: Var Arg			{Args ($1:$2)}

Arg
	: Var Arg			{$1:$2}
	|				{[]}

{
parseError :: [Token] -> a
parseError _ = error "Parse Error"

data Exp =
        Plus AppExp Exp
      | Minus AppExp Exp
      | If AppExp Exp Exp
      | Fix AppExp
      | AppExp AppExp
	deriving Show

data AppExp =
	AppV Value AppExp
      | AppE Exp AppExp
      | Nest Exp
      | Value Value
	deriving Show

data Args =
	Args [Var]
	deriving Show

data Var =
	Var Char
	deriving Show

data Value =
        Int Int
      | Lam Args Exp
      | Variable Var
	deriving Show
}
