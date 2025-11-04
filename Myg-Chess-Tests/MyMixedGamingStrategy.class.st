Class {
	#name : 'MyMixedGamingStrategy',
	#superclass : 'MyDefensiveGamingStrategy',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyMixedGamingStrategy >> testGetCaptureMovesIdentifiesCaptures [

	| strategy player mock captureMoves |
	mock := ChessBoardMock new safeCaptureScenario.
	player := mock game whitePlayer.
	strategy := MixedGamingStrategy new.
	captureMoves := strategy getSafeCaptureMoves: player.

	"test if find the 2 moves"
	self assert: captureMoves size equals: 2.
	"All moves should be captures"
	captureMoves do: [ :move |
			| targetSquare |
			targetSquare := move at: 2.
			self assert: targetSquare hasPiece.
			self deny: targetSquare contents color equals: player color ]
]

{ #category : 'tests' }
MyMixedGamingStrategy >> testGetCaptureMovesReturnsEmptyWhenNoCaptures [

	| strategy player mock safeCaptureMoves |
	mock := ChessBoardMock new basicSetup
		        addBlack: MyPawn at: 'a2';
		        addBlack: MyRook at: 'b2';
		        yourself.
	player := mock game whitePlayer.
	strategy := MixedGamingStrategy new.
	safeCaptureMoves := strategy getSafeCaptureMoves: player.

	"test if no captures is find"
	self assert: safeCaptureMoves isEmpty
]

{ #category : 'tests' }
MyMixedGamingStrategy >> testGetSafeMovesReturnsMovesToUntargetedSquares [
	"Test getSafeMoves: returns moves to squares not targeted by opponent"
	
	| strategy player board game safeMoves opponentTargets |
	board := MyChessBoard empty.
	board at: 'e1' put: MyKing white.
	board at: 'a1' put: MyRook white.
	board at: 'd8' put: MyRook black.  "Targets d-file and 8th rank"
	
	game := MyChessGame freshGame.
	game board: board.
	player := game whitePlayer.
	
	strategy := MixedGamingStrategy new.
	opponentTargets := strategy getOpponentTargetedSquares: player.
	safeMoves := strategy getSafeMoves: player.
	
	"test if all safe moves are not targeted by opponent"
	safeMoves do: [ :move |
		self deny: (opponentTargets includes: (move at: 2)) ]
]

{ #category : 'tests' }
MyMixedGamingStrategy >> testMixedStrategyFollowsCorrectPriority [

	| strategy player mock |
	mock := ChessBoardMock new basicSetup
		        addWhite: MyQueen at: 'e2';
		        addWhite: MyRook at: 'a1';
		        addBlack: MyPawn at: 'a7';
		        addBlack: MyRook at: 'e8';
		        yourself.
	player := mock game whitePlayer.
	strategy := MixedGamingStrategy new.
	strategy play: player.

	"test if queen prefer safe move insted of capture"
	self assert: (mock board at: 'e2') contents isNil
]

{ #category : 'tests' }
MyMixedGamingStrategy >> testPlayCallsNoMovesAvailableWhenStuck [
	
	| strategy player mock |
    mock := ChessBoardMock new stalemateScenario.
    player := mock game whitePlayer.
    strategy := MixedGamingStrategy new.
	
	"test if noMovesAvailable is called"
	self 
		should: [ strategy play: player ]
		raise: Halt
]

{ #category : 'tests' }
MyMixedGamingStrategy >> testPlayMakesSafeCaptureWhenNoPiecesInDanger [

	| strategy player mock |
	mock := ChessBoardMock new captureScenario.
	mock addWhite: MyRook at: 'a1'.
	player := mock game whitePlayer.
	strategy := MixedGamingStrategy new.
	strategy play: player.

	"test if the black pawn is captured"
	self assert: (mock board at: 'a7') contents color equals: Color white
]

{ #category : 'tests' }
MyMixedGamingStrategy >> testPlayMakesSafeMoveWhenNoCapturesAvailable [

	| strategy player mock originalPositions |
	mock := ChessBoardMock new basicSetup.
	mock addBlack: MyKing at: 'h8'.
	player := mock game whitePlayer.
	originalPositions := player pieces collect: [ :p | p square name ].
	strategy := MixedGamingStrategy new.
	strategy play: player.

	"test if a piece have moved"
	self
		deny: (player pieces collect: [ :p | p square name ])
		equals: originalPositions
]

{ #category : 'tests' }
MyMixedGamingStrategy >> testPlayPrioritizesEscapeMovesFirst [

	| strategy player mock |
	mock := ChessBoardMock new threatScenario.
	mock addBlack: MyPawn at: 'a2'.
	player := mock game whitePlayer.
	strategy := MixedGamingStrategy new.
	strategy play: player.

	"test if the white rook moved from c3"
	self assert: (mock board at: 'c3') contents isNil
]

{ #category : 'tests' }
MyMixedGamingStrategy >> testPlaySelectsSafeCapturesOverUnsafeOnes [
	
	| strategy player mock |
    mock := ChessBoardMock new cornerSafeCaptureScenario.
    player := mock game whitePlayer.
    strategy := MixedGamingStrategy new.
    strategy play: player.
	
	"test if the white rook have captured the pawn on a8"
	self assert: (mock board at: 'a8') contents color equals: Color white.
	"test if the rook have moved from a2"  
	self assert: (mock board at: 'a2') contents isNil
]
