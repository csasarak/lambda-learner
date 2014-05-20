{-# OPTIONS_GHC -w #-}
module Parser (Exp(..), AppExp(..), Value(..), Var(..), parse, parseFromFile) where
import Scanner

-- parser produced by Happy Version 1.18.9

data HappyAbsSyn t4 t5 t6 t7 t8
	= HappyTerminal (Scanner.Token)
	| HappyErrorToken Int
	| HappyAbsSyn4 t4
	| HappyAbsSyn5 t5
	| HappyAbsSyn6 t6
	| HappyAbsSyn7 t7
	| HappyAbsSyn8 t8

action_0 (9) = happyShift action_6
action_0 (15) = happyShift action_11
action_0 (18) = happyShift action_7
action_0 (19) = happyShift action_8
action_0 (20) = happyShift action_12
action_0 (4) = happyGoto action_9
action_0 (5) = happyGoto action_10
action_0 (6) = happyGoto action_3
action_0 (7) = happyGoto action_4
action_0 (8) = happyGoto action_5
action_0 _ = happyFail

action_1 (9) = happyShift action_6
action_1 (18) = happyShift action_7
action_1 (19) = happyShift action_8
action_1 (5) = happyGoto action_2
action_1 (6) = happyGoto action_3
action_1 (7) = happyGoto action_4
action_1 (8) = happyGoto action_5
action_1 _ = happyFail

action_2 (13) = happyShift action_15
action_2 _ = happyFail

action_3 (9) = happyShift action_6
action_3 (18) = happyShift action_7
action_3 (19) = happyShift action_8
action_3 (5) = happyGoto action_19
action_3 (6) = happyGoto action_3
action_3 (7) = happyGoto action_4
action_3 (8) = happyGoto action_5
action_3 _ = happyReduce_9

action_4 _ = happyReduce_12

action_5 _ = happyReduce_11

action_6 (9) = happyShift action_6
action_6 (10) = happyShift action_18
action_6 (15) = happyShift action_11
action_6 (18) = happyShift action_7
action_6 (19) = happyShift action_8
action_6 (20) = happyShift action_12
action_6 (4) = happyGoto action_17
action_6 (5) = happyGoto action_10
action_6 (6) = happyGoto action_3
action_6 (7) = happyGoto action_4
action_6 (8) = happyGoto action_5
action_6 _ = happyFail

action_7 _ = happyReduce_10

action_8 _ = happyReduce_14

action_9 (21) = happyAccept
action_9 _ = happyFail

action_10 (13) = happyShift action_15
action_10 (14) = happyShift action_16
action_10 _ = happyReduce_5

action_11 (9) = happyShift action_6
action_11 (18) = happyShift action_7
action_11 (19) = happyShift action_8
action_11 (5) = happyGoto action_14
action_11 (6) = happyGoto action_3
action_11 (7) = happyGoto action_4
action_11 (8) = happyGoto action_5
action_11 _ = happyFail

action_12 (9) = happyShift action_6
action_12 (18) = happyShift action_7
action_12 (19) = happyShift action_8
action_12 (5) = happyGoto action_13
action_12 (6) = happyGoto action_3
action_12 (7) = happyGoto action_4
action_12 (8) = happyGoto action_5
action_12 _ = happyFail

action_13 _ = happyReduce_4

action_14 (16) = happyShift action_24
action_14 _ = happyFail

action_15 (9) = happyShift action_6
action_15 (15) = happyShift action_11
action_15 (18) = happyShift action_7
action_15 (19) = happyShift action_8
action_15 (20) = happyShift action_12
action_15 (4) = happyGoto action_23
action_15 (5) = happyGoto action_10
action_15 (6) = happyGoto action_3
action_15 (7) = happyGoto action_4
action_15 (8) = happyGoto action_5
action_15 _ = happyFail

action_16 (9) = happyShift action_6
action_16 (15) = happyShift action_11
action_16 (18) = happyShift action_7
action_16 (19) = happyShift action_8
action_16 (20) = happyShift action_12
action_16 (4) = happyGoto action_22
action_16 (5) = happyGoto action_10
action_16 (6) = happyGoto action_3
action_16 (7) = happyGoto action_4
action_16 (8) = happyGoto action_5
action_16 _ = happyFail

action_17 (12) = happyShift action_21
action_17 _ = happyFail

action_18 (19) = happyShift action_8
action_18 (8) = happyGoto action_20
action_18 _ = happyFail

action_19 _ = happyReduce_6

action_20 (11) = happyShift action_27
action_20 _ = happyFail

action_21 (9) = happyShift action_6
action_21 (18) = happyShift action_7
action_21 (19) = happyShift action_8
action_21 (5) = happyGoto action_26
action_21 (6) = happyGoto action_3
action_21 (7) = happyGoto action_4
action_21 (8) = happyGoto action_5
action_21 _ = happyReduce_8

action_22 _ = happyReduce_2

action_23 _ = happyReduce_1

action_24 (9) = happyShift action_6
action_24 (15) = happyShift action_11
action_24 (18) = happyShift action_7
action_24 (19) = happyShift action_8
action_24 (20) = happyShift action_12
action_24 (4) = happyGoto action_25
action_24 (5) = happyGoto action_10
action_24 (6) = happyGoto action_3
action_24 (7) = happyGoto action_4
action_24 (8) = happyGoto action_5
action_24 _ = happyFail

action_25 (17) = happyShift action_29
action_25 _ = happyFail

action_26 _ = happyReduce_7

action_27 (9) = happyShift action_6
action_27 (15) = happyShift action_11
action_27 (18) = happyShift action_7
action_27 (19) = happyShift action_8
action_27 (20) = happyShift action_12
action_27 (4) = happyGoto action_28
action_27 (5) = happyGoto action_10
action_27 (6) = happyGoto action_3
action_27 (7) = happyGoto action_4
action_27 (8) = happyGoto action_5
action_27 _ = happyFail

action_28 (12) = happyShift action_31
action_28 _ = happyFail

action_29 (9) = happyShift action_6
action_29 (15) = happyShift action_11
action_29 (18) = happyShift action_7
action_29 (19) = happyShift action_8
action_29 (20) = happyShift action_12
action_29 (4) = happyGoto action_30
action_29 (5) = happyGoto action_10
action_29 (6) = happyGoto action_3
action_29 (7) = happyGoto action_4
action_29 (8) = happyGoto action_5
action_29 _ = happyFail

action_30 _ = happyReduce_3

action_31 _ = happyReduce_13

happyReduce_1 = happySpecReduce_3  4 happyReduction_1
happyReduction_1 (HappyAbsSyn4  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn4
		 (Plus happy_var_1 happy_var_3
	)
happyReduction_1 _ _ _  = notHappyAtAll 

happyReduce_2 = happySpecReduce_3  4 happyReduction_2
happyReduction_2 (HappyAbsSyn4  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn4
		 (Minus happy_var_1 happy_var_3
	)
happyReduction_2 _ _ _  = notHappyAtAll 

happyReduce_3 = happyReduce 6 4 happyReduction_3
happyReduction_3 ((HappyAbsSyn4  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn5  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (If happy_var_2 happy_var_4 happy_var_6
	) `HappyStk` happyRest

happyReduce_4 = happySpecReduce_2  4 happyReduction_4
happyReduction_4 (HappyAbsSyn5  happy_var_2)
	_
	 =  HappyAbsSyn4
		 (Fix happy_var_2
	)
happyReduction_4 _ _  = notHappyAtAll 

happyReduce_5 = happySpecReduce_1  4 happyReduction_5
happyReduction_5 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn4
		 (AppExp happy_var_1
	)
happyReduction_5 _  = notHappyAtAll 

happyReduce_6 = happySpecReduce_2  5 happyReduction_6
happyReduction_6 (HappyAbsSyn5  happy_var_2)
	(HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn5
		 (AppV happy_var_1 happy_var_2
	)
happyReduction_6 _ _  = notHappyAtAll 

happyReduce_7 = happyReduce 4 5 happyReduction_7
happyReduction_7 ((HappyAbsSyn5  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn5
		 (AppE happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_8 = happySpecReduce_3  5 happyReduction_8
happyReduction_8 _
	(HappyAbsSyn4  happy_var_2)
	_
	 =  HappyAbsSyn5
		 (Nest happy_var_2
	)
happyReduction_8 _ _ _  = notHappyAtAll 

happyReduce_9 = happySpecReduce_1  5 happyReduction_9
happyReduction_9 (HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn5
		 (Value happy_var_1
	)
happyReduction_9 _  = notHappyAtAll 

happyReduce_10 = happySpecReduce_1  6 happyReduction_10
happyReduction_10 (HappyTerminal (S_Int happy_var_1))
	 =  HappyAbsSyn6
		 (Int happy_var_1
	)
happyReduction_10 _  = notHappyAtAll 

happyReduce_11 = happySpecReduce_1  6 happyReduction_11
happyReduction_11 (HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn6
		 (Variable happy_var_1
	)
happyReduction_11 _  = notHappyAtAll 

happyReduce_12 = happySpecReduce_1  6 happyReduction_12
happyReduction_12 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn6
		 (happy_var_1
	)
happyReduction_12 _  = notHappyAtAll 

happyReduce_13 = happyReduce 6 7 happyReduction_13
happyReduction_13 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn8  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn7
		 (Lam happy_var_3 happy_var_5
	) `HappyStk` happyRest

happyReduce_14 = happySpecReduce_1  8 happyReduction_14
happyReduction_14 (HappyTerminal (S_Var happy_var_1))
	 =  HappyAbsSyn8
		 (Var happy_var_1
	)
happyReduction_14 _  = notHappyAtAll 

happyNewToken action sts stk [] =
	action 21 21 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	S_Lparen -> cont 9;
	S_Bslash -> cont 10;
	S_Period -> cont 11;
	S_Rparen -> cont 12;
	S_Plus -> cont 13;
	S_Minus -> cont 14;
	S_If -> cont 15;
	S_Then -> cont 16;
	S_Else -> cont 17;
	S_Int happy_dollar_dollar -> cont 18;
	S_Var happy_dollar_dollar -> cont 19;
	S_Fix -> cont 20;
	_ -> happyError' (tk:tks)
	}

happyError_ 21 tk tks = happyError' tks
happyError_ _ tk tks = happyError' (tk:tks)

newtype HappyIdentity a = HappyIdentity a
happyIdentity = HappyIdentity
happyRunIdentity (HappyIdentity a) = a

instance Monad HappyIdentity where
    return = HappyIdentity
    (HappyIdentity p) >>= q = q p

happyThen :: () => HappyIdentity a -> (a -> HappyIdentity b) -> HappyIdentity b
happyThen = (>>=)
happyReturn :: () => a -> HappyIdentity a
happyReturn = (return)
happyThen1 m k tks = (>>=) m (\a -> k a tks)
happyReturn1 :: () => a -> b -> HappyIdentity a
happyReturn1 = \a tks -> (return) a
happyError' :: () => [(Scanner.Token)] -> HappyIdentity a
happyError' = HappyIdentity . parseError

parse tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_0 tks) (\x -> case x of {HappyAbsSyn4 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq


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
      return (parse toks)
{-# LINE 1 "templates/GenericTemplate.hs" #-}
{-# LINE 1 "templates/GenericTemplate.hs" #-}
{-# LINE 1 "<built-in>" #-}
{-# LINE 1 "<command-line>" #-}
{-# LINE 1 "templates/GenericTemplate.hs" #-}
-- Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp 

{-# LINE 30 "templates/GenericTemplate.hs" #-}








{-# LINE 51 "templates/GenericTemplate.hs" #-}

{-# LINE 61 "templates/GenericTemplate.hs" #-}

{-# LINE 70 "templates/GenericTemplate.hs" #-}

infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is (1), it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept (1) tk st sts (_ `HappyStk` ans `HappyStk` _) =
	happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) = 
	 (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action

{-# LINE 148 "templates/GenericTemplate.hs" #-}

-----------------------------------------------------------------------------
-- HappyState data type (not arrays)



newtype HappyState b c = HappyState
        (Int ->                    -- token number
         Int ->                    -- token number (yes, again)
         b ->                           -- token semantic value
         HappyState b c ->              -- current state
         [HappyState b c] ->            -- state stack
         c)



-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state (1) tk st sts stk@(x `HappyStk` _) =
     let (i) = (case x of { HappyErrorToken (i) -> i }) in
--     trace "shifting the error token" $
     new_state i i tk (HappyState (new_state)) ((st):(sts)) (stk)

happyShift new_state i tk st sts stk =
     happyNewToken new_state ((st):(sts)) ((HappyTerminal (tk))`HappyStk`stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_0 nt fn j tk st@((HappyState (action))) sts stk
     = action nt j tk st ((st):(sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@(((st@(HappyState (action))):(_))) (v1`HappyStk`stk')
     = let r = fn v1 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_2 nt fn j tk _ ((_):(sts@(((st@(HappyState (action))):(_))))) (v1`HappyStk`v2`HappyStk`stk')
     = let r = fn v1 v2 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_3 nt fn j tk _ ((_):(((_):(sts@(((st@(HappyState (action))):(_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = let r = fn v1 v2 v3 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop (k - ((1) :: Int)) sts of
	 sts1@(((st1@(HappyState (action))):(_))) ->
        	let r = fn stk in  -- it doesn't hurt to always seq here...
       		happyDoSeq r (action nt j tk st1 sts1 r)

happyMonadReduce k nt fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
        happyThen1 (fn stk tk) (\r -> action nt j tk st1 sts1 (r `HappyStk` drop_stk))
       where (sts1@(((st1@(HappyState (action))):(_)))) = happyDrop k ((st):(sts))
             drop_stk = happyDropStk k stk

happyMonad2Reduce k nt fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happyMonad2Reduce k nt fn j tk st sts stk =
       happyThen1 (fn stk tk) (\r -> happyNewToken new_state sts1 (r `HappyStk` drop_stk))
       where (sts1@(((st1@(HappyState (action))):(_)))) = happyDrop k ((st):(sts))
             drop_stk = happyDropStk k stk





             new_state = action


happyDrop (0) l = l
happyDrop n ((_):(t)) = happyDrop (n - ((1) :: Int)) t

happyDropStk (0) l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n - ((1)::Int)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction

{-# LINE 246 "templates/GenericTemplate.hs" #-}
happyGoto action j tk st = action j j tk (HappyState action)


-----------------------------------------------------------------------------
-- Error recovery ((1) is the error token)

-- parse error if we are in recovery and we fail again
happyFail (1) tk old_st _ stk@(x `HappyStk` _) =
     let (i) = (case x of { HappyErrorToken (i) -> i }) in
--	trace "failing" $ 
        happyError_ i tk

{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  (1) tk old_st (((HappyState (action))):(sts)) 
						(saved_tok `HappyStk` _ `HappyStk` stk) =
--	trace ("discarding state, depth " ++ show (length stk))  $
	action (1) (1) tk (HappyState (action)) sts ((saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail  i tk (HappyState (action)) sts stk =
--      trace "entering error recovery" $
	action (1) (1) tk (HappyState (action)) sts ( (HappyErrorToken (i)) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll :: a
notHappyAtAll = error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions







-----------------------------------------------------------------------------
-- Seq-ing.  If the --strict flag is given, then Happy emits 
--	happySeq = happyDoSeq
-- otherwise it emits
-- 	happySeq = happyDontSeq

happyDoSeq, happyDontSeq :: a -> b -> b
happyDoSeq   a b = a `seq` b
happyDontSeq a b = b

-----------------------------------------------------------------------------
-- Don't inline any functions from the template.  GHC has a nasty habit
-- of deciding to inline happyGoto everywhere, which increases the size of
-- the generated parser quite a bit.

{-# LINE 312 "templates/GenericTemplate.hs" #-}
{-# NOINLINE happyShift #-}
{-# NOINLINE happySpecReduce_0 #-}
{-# NOINLINE happySpecReduce_1 #-}
{-# NOINLINE happySpecReduce_2 #-}
{-# NOINLINE happySpecReduce_3 #-}
{-# NOINLINE happyReduce #-}
{-# NOINLINE happyMonadReduce #-}
{-# NOINLINE happyGoto #-}
{-# NOINLINE happyFail #-}

-- end of Happy Template.
