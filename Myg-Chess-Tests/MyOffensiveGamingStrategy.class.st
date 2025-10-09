Class {
	#name : 'MyOffensiveGamingStrategy',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyOffensiveGamingStrategy >> testKingIsInCheck [

	| player board os king pawn game|
	

	board := MyChessBoard empty.
board at: 'e4' put: (king := MyKing white).
board at: 'e5' put: (pawn := MyPawn white).

	game := MyChessGame freshGame.
	board game: game.
	player := MyPlayer new.
	player game: game.
	
	self
		assert: (os kingIsInCheck: player)
		equals: (OrderedCollection with: player king)
]
