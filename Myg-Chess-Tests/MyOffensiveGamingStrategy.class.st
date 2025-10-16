Class {
	#name : 'MyOffensiveGamingStrategy',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyOffensiveGamingStrategy >> testLegalMoves [

	| board game player attackingMoves standardMoves moves |
	board := MyChessBoard empty.
	board at: 'e2' put: MyKing white.
	board at: 'd4' put: MyPawn white.
	board at: 'd5' put: MyPawn black.

	game := MyChessGame freshGame.
	game board: board.

	player := game whitePlayer.

	moves := OffensiveGamingStrategy new legalMoves: player.

	attackingMoves := moves first.
	standardMoves := moves second.
	
	self
		assertCollection: (attackingMoves collect: [ :move | move second ])
		includesAll: (#( d5 ) collect: [ :name | board at: name ])
]

{ #category : 'tests' }
MyOffensiveGamingStrategy >> testListOfPiecesOrKingWithKingIsInCheck [

	| player board result game |
	board := MyChessBoard empty.
	board at: 'e1' put: MyKing white.
	board at: 'e8' put: MyRook black.

	game := MyChessGame freshGame.
	game board: board.

	player := game whitePlayer.
	
	result := OffensiveGamingStrategy new listOfPiecesOrKing: player.

	self assert: (result anySatisfy: [:p | p == player king]).

]

{ #category : 'tests' }
MyOffensiveGamingStrategy >> testPlayPlaysAnAttackingMoveIfPossible [

	| game player strategy board moveMade capturedPiece |
	board := MyChessBoard empty.
	board at: 'a1' put: MyKing white.
	board at: 'e2' put: MyRook white.
	board at: 'e3' put: MyPawn black.

	game := MyChessGame freshGame.
	game board: board.
	player := game whitePlayer.
	strategy := OffensiveGamingStrategy new.

	moveMade := strategy play: player.

	capturedPiece := game board at: 'e3'.

	self assert: capturedPiece contents color = Color white
]
