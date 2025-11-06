Class {
	#name : 'MyAbstractStrategyTest',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyAbstractStrategyTest >> testExecuteRandomMoveFromExecutesAMove [

	| strategy player mock moves targetSquare result |
	mock := ChessBoardMock new basicSetup.
	player := mock game whitePlayer.
	targetSquare := mock board at: 'd2'.
	moves := OrderedCollection with:
		         (Array
			          with: (mock board at: 'd1') contents
			          with: targetSquare).

	strategy := AbstractGamingStrategy new.
	result := strategy executeRandomMoveFrom: moves for: player.

	"test if return the player"
	self assert: result equals: player.
	"test if the rook have moved to the target square"
	self assert: targetSquare contents class equals: MyRook
]

{ #category : 'tests' }
MyAbstractStrategyTest >> testExecuteRandomMoveFromWithEmptyCollection [

	| strategy player mock moves |
	mock := ChessBoardMock new basicSetup.
	player := mock game whitePlayer.
	moves := OrderedCollection new.
	strategy := AbstractGamingStrategy new.

	"test the error"
	self
		should: [ strategy executeRandomMoveFrom: moves for: player ]
		raise: Error
]

{ #category : 'tests' }
MyAbstractStrategyTest >> testKingIsInCheckWithKingInCheck [

	| strategy player mock result |
	mock := ChessBoardMock new checkScenario.
	player := mock game whitePlayer.
	strategy := AbstractGamingStrategy new.
	result := strategy kingIsInCheck: player.

	"test only one move"
	self assert: result size equals: 1.
	"test is the a move of the king"
	self assert: result first equals: player king
]

{ #category : 'tests' }
MyAbstractStrategyTest >> testKingIsInCheckWithoutKingInCheck [

	| strategy player mock result |
	mock := ChessBoardMock new multiPieceSetup.
	player := mock game whitePlayer.
	strategy := AbstractGamingStrategy new.
	result := strategy kingIsInCheck: player.

	"test if all 6 pieces can be move"
	self assert: result size equals: 6.
	"test each piece can be move if king not in check"
	self assert: result size equals: player pieces size.
	result do: [ :piece | self assert: (player pieces includes: piece) ]
]

{ #category : 'tests' }
MyAbstractStrategyTest >> testNoMovesAvailable [

	| strategy |
	strategy := AbstractGamingStrategy new.

	"test noMovesAvailable raise a halt"
	self should: [ strategy noMovesAvailable ] raise: Halt
]
