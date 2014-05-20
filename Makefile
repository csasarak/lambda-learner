all: Parser.hs Scanner.hs

Parser.hs: Grammar.y Scanner.hs
	happy Grammar.y -o Parser.hs
	
Scanner.hs: Lexer.x
	alex Lexer.x -o Scanner.hs
