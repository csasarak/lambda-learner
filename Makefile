all: lambda-learner.hs Parser.hs Scanner.hs
	@echo "\nCompiling lambda-learner"
	ghc -XRankNTypes lambda-learner.hs

Parser.hs: Grammar.y Scanner.hs
	@echo "\nMaking parser"
	happy Grammar.y -o Parser.hs
	
Scanner.hs: Lexer.x
	@echo "\nMaking Lexer"
	alex Lexer.x -o Scanner.hs

clean:
	rm -rf *.o *.hi Scanner.hs Parser.hs
