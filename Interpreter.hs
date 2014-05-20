{-
   File: Interpreter.hs
   Author: Connor Adsit
   Date: 19 May 2014

   Provides Operational Semantics for basic Lambda Calculus
-}

module Interpreter where
import Parser

-- Checks to see if an expression cannot be evaluated more
isValueExp :: Parser.Exp -> Bool
isValueExp exp =
   case exp of
      -- The only case we're concerned about is if we're an AppExp
      Parser.AppExp app -> isValueAppExp app
      _                     -> False

-- Checks to see if an application expression cannot be evaluated more
isValueAppExp :: Parser.AppExp -> Bool
isValueAppExp app =
   case app of
      -- if we're a value, check to make sure we're not a variable
      Parser.Value val -> isValueValue val
      -- if we're a nested expression, make sure that the encompassed exp is a value
      Parser.Nest exp  -> isValueExp exp
      _                -> False

-- Checks to see if a value is in fact a value
isValueValue :: Parser.Value -> Bool
isValueValue val =
   case val of
      -- the only time we're not a value is if we're a variable
      Parser.Variable var -> False
      _                   -> True

-- Runs a substitution through all parts of an expression
substExp :: Parser.Var -> Parser.AppExp -> Parser.Exp -> Parser.Exp
substExp v ae exp =
   case exp of
      -- Push the substitution in the left and right branches of the tree
      Parser.Plus app expr -> let app' = substAppExp v ae app
                                  expr' = substExp v ae expr
			      in Parser.Plus app' expr'
      -- Push the substitution in the left and right branches of the tree
      Parser.Minus app expr -> let app' = substAppExp v ae app
                                   expr' = substExp v ae expr
			       in Parser.Minus app' expr'
      -- Push the substitution in the condition, then and else branches of the tree
      Parser.If app expt expe -> let app' = substAppExp v ae app
                                     expt' = substExp v ae expt
				     expe' = substExp v ae expe
				 in Parser.If app' expt' expe'
      -- Push the substitution to the application expression
      Parser.Fix app -> let app' = substAppExp v ae app
                        in Parser.Fix app'
      -- Push the substitution to the application expression
      Parser.AppExp app -> let app' = substAppExp v ae app
                           in Parser.AppExp app'

-- Runs a substitution through all parts of an application expression
substAppExp :: Parser.Var -> Parser.AppExp -> Parser.AppExp -> Parser.AppExp
substAppExp v ae app =
   case app of
      -- Check val to see if it's the variable we need to substitute and make
      -- necessary changes
      Parser.AppV val apparg -> let apparg' = substAppExp v ae apparg
                                in case substValue v ae val of
                                   Left ae' -> Parser.AppE (Parser.AppExp ae') apparg'
				   Right v -> Parser.AppV v apparg'
      Parser.AppE exp apparg -> let exp' = substExp v ae exp
                                    apparg' = substAppExp v ae apparg
                                in Parser.AppE exp' apparg'
      Parser.Nest exp -> let exp' = substExp v ae exp
                         in Parser.Nest exp'
      Parser.Value val -> case substValue v ae val of
                             Left ae -> ae
			     Right v -> Parser.Value v

-- Runs a substitution through all parts of a value
substValue :: Parser.Var -> Parser.AppExp -> Parser.Value -> Either Parser.AppExp Parser.Value
substValue v ae val =
   case val of
      -- Do not substitute
      Parser.Int i        -> Right val
      -- Check to make sure that the variable is not the formal param
      Parser.Lam var exp  -> if (var == v)
                                then Right val
				else let exp' = substExp v ae exp
				     in Right (Parser.Lam var exp')
      -- Only substitute if the vars are the same
      Parser.Variable var -> if (v == var)
                                then Left ae
				else Right val

-- Returns the value of an expression if there is one
getValueExp :: Parser.Exp -> Maybe Parser.Value
getValueExp exp =
   case exp of
      Parser.AppExp ae -> getValueAppExp ae
      _                -> Nothing

-- Returns the value of an application expression if there is one
getValueAppExp :: Parser.AppExp -> Maybe Parser.Value
getValueAppExp ae =
   case ae of
      Parser.Value val -> getValue val
      Parser.Nest exp  -> getValueExp exp
      _                -> Nothing

-- Returns the value object if not a variable
getValue :: Parser.Value -> Maybe Parser.Value
getValue val =
   case val of
      Parser.Int i       -> Just val
      Parser.Lam var exp -> Just val
      _                  -> Nothing

-- Returns the stepped-to expression or Nothing if the expression cannot take a step
stepExp :: Parser.Exp -> Maybe Parser.Exp
stepExp exp =
   case exp of
      Parser.Plus app expR    -> let appVal = getValueAppExp app
                                 -- if there is no appVal, app can take a step
				 in case appVal of
				    Nothing  -> let app' = stepAppExp app
				                in case app' of
						   Just a' -> Just (Parser.Plus a' expR)
						   _       -> Nothing
				    -- Otherwise see if the value is an integer 
				    Just val -> case val of
				                   Parser.Int i -> let expRVal = getValueExp expR
						                   -- if the right is not a value, step the right
						                   in case expRVal of
								      Nothing -> let expR' = stepExp expR
								                 in case expR' of
										    Just e' -> Just (Parser.Plus app e')
										    Nothing -> Nothing
								      -- if it is, perform the addition if the value is an int
								      Just val' -> case val' of
								                      Parser.Int i' -> Just (Parser.AppExp (Parser.Value (Parser.Int (i + i'))))
										      _             -> Nothing
						   -- If we aren't an integer, there was an error
						   _            -> Nothing

      Parser.Minus app expR   -> let appVal = getValueAppExp app
                                 -- if there is no appVal, app can take a step
				 in case appVal of
				    Nothing  -> let app' = stepAppExp app
				                in case app' of
						   Just a' -> Just (Parser.Minus a' expR)
						   _       -> Nothing
				    -- Otherwise see if the value is an integer
				    Just val -> case val of
				                   Parser.Int i -> let expRVal = getValueExp expR
						                   -- if the right expression is not a value, step it
						                   in case expRVal of
								      Nothing -> let expR' = stepExp expR
								                 in case expR' of
										    Just e' -> Just (Parser.Minus app e')
										    Nothing -> Nothing
								      -- Otherwise make sure that it's an integer
								      Just val' -> case val' of
								                      Parser.Int i' -> Just (Parser.AppExp (Parser.Value (Parser.Int (i - i'))))
										      _             -> Nothing
						   -- If we're not an integer, we can't take a step
						   _            -> Nothing

      Parser.If app expT expE -> let appVal = getValueAppExp app
                                 -- if our AppExp is not a value, step it
                                 in case appVal of
				    Nothing -> let app' = stepAppExp app
				               in case app' of
					          Just a' -> Just (Parser.If a' expT expE)
						  Nothing -> Nothing
				    -- Otherwise make sure that it's an int
				    Just val -> case val of
				                   -- If val > 0, proceed to True branch, otherwise proceed to False branch
				                   Parser.Int i -> if (i > 0)
						                      then Just expT
								      else Just expE
						   _            -> Nothing

      Parser.Fix app          -> let appVal = getValueAppExp app
                                 -- if our AppExp is not a value step it
                                 in case appVal of
				    Nothing -> let app' = stepAppExp app
				               in case app' of
					          Just a' -> Just (Parser.Fix a')
						  Nothing -> Nothing
				    -- Otherwise, make sure it's a lambda
				    Just val -> case val of
				                   Parser.Lam x e -> Just (Parser.AppExp (Parser.AppV val (Parser.Nest (exp))))
						   _              -> Nothing

      Parser.AppExp app       -> let appVal = getValueAppExp app
                                 -- if our AppExp is not a value, step it
                                 in case appVal of
				    Nothing -> let app' = stepAppExp app
				               in case app' of
					          Just a' -> Just (Parser.AppExp a')
						  Nothing -> Nothing
				    -- Otherwise, we are done interpreting
				    Just val -> Nothing

stepAppExp :: Parser.AppExp -> Maybe Parser.AppExp
stepAppExp ae =
  case ae of
     Parser.AppV val app -> case val of
                               -- Make sure we're a lambda and perform substitution
                               Lam x exp -> Just (Parser.Nest (substExp x app exp))
			       _         -> Nothing

     Parser.AppE exp app -> let expVal = getValueExp exp
                            -- if our exp can take a step, then step it
                            in case expVal of
			       Nothing -> let exp' = stepExp exp
			                  in case exp' of
					     Just e' -> Just (Parser.AppE e' app)
					     Nothing -> Nothing
			       -- otherwise performs substitution
			       Just val -> case val of
			                      Parser.Lam x expb -> Just (Parser.Nest (substExp x app expb))
					      _                 -> Nothing
     Parser.Nest exp -> let expVal = getValueExp exp
                        -- only take a step when the nested expression can take a step
                        in case expVal of
			   Nothing -> let exp' = stepExp exp
			              in case exp' of
				         Just e' -> Just (Parser.Nest e')
					 Nothing -> Nothing
			   -- A value cannot take a step
                           Just val -> Nothing
     -- A value cannot take a step
     Parser.Value v -> Nothing
