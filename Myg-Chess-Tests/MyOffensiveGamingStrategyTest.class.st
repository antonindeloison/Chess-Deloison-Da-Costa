Class {
	#name : 'MyOffensiveGamingStrategyTest',
	#superclass : 'MyAbstractStrategyTest',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyOffensiveGamingStrategyTest >> testLegalMoves [

	| player attackingMoves standardMoves moves mock |
	mock := ChessBoardMock new pawnCaptureScenario.
	player := mock game whitePlayer.
	moves := OffensiveGamingStrategy new legalMoves: player.
	attackingMoves := moves first.
	standardMoves := moves second.

	"each attacking move is a legal move"
	self
		assertCollection: (attackingMoves collect: [ :move | move second ])
		includesAll: (#( d5 ) collect: [ :name | mock board at: name ])
]

{ #category : 'tests' }
MyOffensiveGamingStrategyTest >> testLegalMovesFiltersCorrectly [

	| player moves attackingMoves standardMoves strategy mock |
	mock := ChessBoardMock new basicSetup
		        addWhite: MyRook at: 'e4';
		        addBlack: MyPawn at: 'e7';
		        addBlack: MyKing at: 'h8';
		        yourself.
	player := mock game whitePlayer.
	strategy := OffensiveGamingStrategy new.
	moves := strategy legalMoves: player.
	attackingMoves := moves first.
	standardMoves := moves second.

	"test if attacking moves only contain capture moves"
	attackingMoves do: [ :move |
			| targetSquare |
			targetSquare := move at: 2.
			self assert: targetSquare hasPiece.
			self deny: targetSquare contents color equals: player color ].

	"test if standard moves never contain capture moves"
	standardMoves do: [ :move |
			| targetSquare |
			targetSquare := move at: 2.
			self deny: (targetSquare hasPiece and: [
					 targetSquare contents color ~= player color ]) ]
]

{ #category : 'tests' }
MyOffensiveGamingStrategyTest >> testLegalMovesWithMultipleCaptures [

	| player moves attackingMoves mock captureTargets |
	mock := ChessBoardMock new multiCaptureScenario.
	player := mock game whitePlayer.
	moves := OffensiveGamingStrategy new legalMoves: player.
	attackingMoves := moves first.

	"test if the 3 capture moves are identified"
	self assert: attackingMoves size equals: 3.
	"test if all captures are identified"
	captureTargets := attackingMoves collect: [ :move |
		                  (move at: 2) name ].
	self assert: (captureTargets includes: 'd7').
	self assert: (captureTargets includes: 'a4').
	self assert: (captureTargets includes: 'g7')
]

{ #category : 'tests' }
MyOffensiveGamingStrategyTest >> testLegalMovesWithNoCaptures [

	| player moves attackingMoves standardMoves mock |
	mock := ChessBoardMock new basicSetup.
	mock addBlack: MyKing at: 'h8'.
	player := mock game whitePlayer.
	moves := OffensiveGamingStrategy new legalMoves: player.
	attackingMoves := moves first.
	standardMoves := moves second.

	"test if there is no attackingMoves but standard moves"
	self assert: attackingMoves isEmpty.
	self assert: standardMoves notEmpty
]

{ #category : 'tests' }
MyOffensiveGamingStrategyTest >> testOffensiveStrategyPrioritizesAggression [

	| strategy player mock |
	mock := ChessBoardMock new basicSetup
		        addWhite: MyRook at: 'e4';
		        addBlack: MyPawn at: 'e7';
		        addBlack: MyRook at: 'f8';
		        yourself.
	player := mock game whitePlayer.
	strategy := OffensiveGamingStrategy new.
	strategy play: player.

	"test if capture the pawn in e7"
	self assert: (mock board at: 'e7') contents color equals: Color white
]

{ #category : 'tests' }
MyOffensiveGamingStrategyTest >> testPlayCallsNoMovesAvailableWhenStuck [

	| player strategy mock |
	mock := ChessBoardMock new stalemateScenario.
	player := mock game whitePlayer.
	strategy := OffensiveGamingStrategy new.

	"test if noMovesAvailable is called"
	self should: [ strategy play: player ] raise: Halt
]

{ #category : 'tests' }
MyOffensiveGamingStrategyTest >> testPlayMakesStandardMoveWhenNoCapturesAvailable [

	| player strategy mock originalPositions |
	mock := ChessBoardMock new basicSetup.
	mock addBlack: MyKing at: 'h8'.
	player := mock game whitePlayer.
	strategy := OffensiveGamingStrategy new.
	originalPositions := player pieces collect: [ :p | p square name ].
	strategy play: player.

	"test if a piece have moved"
	self
		deny: (player pieces collect: [ :p | p square name ])
		equals: originalPositions
]

{ #category : 'tests' }
MyOffensiveGamingStrategyTest >> testPlayPrioritizesAttackingMoves [

	| player strategy mock |
	mock := ChessBoardMock new basicSetup
		        addWhite: MyRook at: 'e2';
		        addBlack: MyPawn at: 'e3';
		        yourself.
	player := mock game whitePlayer.
	strategy := OffensiveGamingStrategy new.
	strategy play: player.

	"test if the black pawn is captured by the white rook"
	self assert: (mock board at: 'e3') contents color equals: Color white.
	self assert: (mock board at: 'e2') contents isNil
]
