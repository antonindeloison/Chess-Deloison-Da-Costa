Class {
	#name : 'MyDefensiveGamingStrategy',
	#superclass : 'MyAbstractStrategy',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyDefensiveGamingStrategy >> testDefensiveStrategyPrioritizesSafety [

	| strategy player mock targetedSquares |
	mock := ChessBoardMock new
		        basicSetup;
		        addBlack: MyRook at: 'd8';
		        addWhite: MyPawn at: 'a1';
		        yourself.
	player := mock game whitePlayer.
	strategy := DefensiveGamingStrategy new.
	targetedSquares := strategy getOpponentTargetedSquares: player.
	strategy play: player.

	"test of white rook have moved to safety"
	self assert: (mock board at: 'd1') contents isNil
]

{ #category : 'tests' }
MyDefensiveGamingStrategy >> testGetAllOtherMovesReturnsAllLegalMoves [

	| strategy player mock allMoves |
	mock := ChessBoardMock new
		        basicSetup;
		        addWhite: MyPawn at: 'e2';
		        yourself.
	player := mock game whitePlayer.
	strategy := DefensiveGamingStrategy new.
	allMoves := strategy getAllOtherMoves: player.
	strategy play: player.

	"test if moves include all 14 differents moves"
	self assert: allMoves size equals: 14
]

{ #category : 'tests' }
MyDefensiveGamingStrategy >> testGetEscapeMovesAvoidsDangerousSquares [

	| strategy player mock escapeMoves opponentTargets |
	mock := ChessBoardMock new basicSetup.
	mock addBlack: MyRook at: 'd8'.
	player := mock game whitePlayer.
	strategy := DefensiveGamingStrategy new.
	opponentTargets := strategy getOpponentTargetedSquares: player.
	escapeMoves := strategy getEscapeMoves: player.

	"test if escape moves are always to safe squares"
	escapeMoves do: [ :move |
		self deny: (opponentTargets includes: (move at: 2)) ]
]

{ #category : 'tests' }
MyDefensiveGamingStrategy >> testGetEscapeMovesFindsValidEscapes [

	| strategy player mock escapeMoves |
	mock := ChessBoardMock new basicSetup.
	mock addBlack: MyRook at: 'd8'.
	player := mock game whitePlayer.
	strategy := DefensiveGamingStrategy new.
	escapeMoves := strategy getEscapeMoves: player.

	"test if find the 4 escape moves for the white rook"
	self assert: escapeMoves size equals: 4.
	"test if the moves are for the threatened rook"
	self assert:
		(escapeMoves allSatisfy: [ :move | (move at: 1) square name = 'd1' ])
]

{ #category : 'tests' }
MyDefensiveGamingStrategy >> testGetEscapeMovesReturnsEmptyWhenNoPiecesInDanger [

	| strategy player mock escapeMoves |
	mock := ChessBoardMock new basicSetup.
	mock addBlack: MyKing at: 'h8'.
	player := mock game whitePlayer.
	strategy := DefensiveGamingStrategy new.
	escapeMoves := strategy getEscapeMoves: player.

	"test if no escape moves are find"
	self assert: escapeMoves isEmpty
]

{ #category : 'tests' }
MyDefensiveGamingStrategy >> testGetOpponentTargetedSquares [

	| strategy player mock targetedSquares |
	mock := ChessBoardMock new basicSetup.
	mock addBlack: MyRook at: 'd8'.
	player := mock game whitePlayer.
	strategy := DefensiveGamingStrategy new.
	targetedSquares := strategy getOpponentTargetedSquares: player.

	"test if black rook target squares on d"
	self assert: (targetedSquares includes: (mock board at: 'd1')).
	self assert: (targetedSquares includes: (mock board at: 'd2')).
	"test if black rook target squares on 8"
	self assert: (targetedSquares includes: (mock board at: 'a8')).
	self assert: (targetedSquares includes: (mock board at: 'h8'))
]

{ #category : 'tests' }
MyDefensiveGamingStrategy >> testGetPiecesInDangerIdentifiesThreatenedPieces [

	| strategy player mock piecesInDanger |
	mock := ChessBoardMock new threatScenario.
	mock addWhite: MyPawn at: 'a1'.
	player := mock game whitePlayer.
	strategy := DefensiveGamingStrategy new.
	piecesInDanger := strategy getPiecesInDanger: player.

	"test if the Rook is in piecesInDanger"
	self assert: piecesInDanger size equals: 1.
	self assert: piecesInDanger first class equals: MyRook.
	self assert: piecesInDanger first square name equals: 'd1'
]

{ #category : 'tests' }
MyDefensiveGamingStrategy >> testGetPiecesInDangerReturnsEmptyWhenAllSafe [

	| strategy player mock piecesInDanger |
	mock := ChessBoardMock new basicSetup.
	mock addBlack: MyKing at: 'h8'.
	player := mock game whitePlayer.
	strategy := DefensiveGamingStrategy new.
	piecesInDanger := strategy getPiecesInDanger: player.

	"test if no pieces are in danger"
	self assert: piecesInDanger isEmpty
]

{ #category : 'tests' }
MyDefensiveGamingStrategy >> testPlayCallsNoMovesAvailableWhenStuck [

	| strategy player mock |
	mock := ChessBoardMock new stalemateScenario.
	player := mock game whitePlayer.
	strategy := DefensiveGamingStrategy new.

	"test if noMovesAvailable is called"
	self should: [ strategy play: player ] raise: Halt
]

{ #category : 'tests' }
MyDefensiveGamingStrategy >> testPlayExecutesEscapeMoveWhenPieceInDanger [

	| strategy player mock |
	mock := ChessBoardMock new threatScenario.
	player := mock game whitePlayer.
	strategy := DefensiveGamingStrategy new.
	strategy play: player.

	"test if have moved from d1"
	self assert: (mock board at: 'd1') contents isNil
]

{ #category : 'tests' }
MyDefensiveGamingStrategy >> testPlayExecutesRandomMoveWhenNoPiecesInDanger [

	| strategy player mock originalPositions |
	mock := ChessBoardMock new basicSetup.
	mock addBlack: MyKing at: 'h8'.
	player := mock game whitePlayer.
	originalPositions := player pieces collect: [ :p | p square name ].
	strategy := DefensiveGamingStrategy new.
	strategy play: player.

	"test if a piece have moved"
	self
		deny: (player pieces collect: [ :p | p square name ])
		equals: originalPositions
]
