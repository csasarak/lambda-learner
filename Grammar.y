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
   dig		{S_Int $$}
   var		{S_Var $$}
   fix		{S_Fix}

%%

Exp
	: Exp Exp			{App $1 $2}
	| Exp '+' Exp			{Plus $1 $3}
	| Exp '-' Exp			{Minus $1 $3}
	| fix Exp			{Fix $2}
	| '(' Exp ')'			{Nest $2}
	| Val				{Value $1}

Val
	: dig				{Int $1}
	| '(' '\\' Args '.' Exp ')'	{Lam $3 $5}

Var
	: var				{Var $1}

Args
	: Var Arg			{Arg ($1::$2)}

Arg
	: Var Arg			{$1::$2}
	|				{[]}

{
parseError :: [Token] -> a
parseError _ = error "Parse Error"

data Exp =
        App Exp Exp
      | Plus Exp Exp
      | Minus Exp Exp
      | Fix Exp
      | Nest Exp
      | Value Value

data Arg =
        Arg [Var]

data Var =
        Var Char

data Value =
        Int Int
      | Lam Arg Exp 
}
