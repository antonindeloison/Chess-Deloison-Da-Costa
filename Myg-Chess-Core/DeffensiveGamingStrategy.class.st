Class {
	#name : 'DeffensiveGamingStrategy',
	#superclass : 'AbstractGamingStrategy',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'playing' }
DeffensiveGamingStrategy >> executeRandomMoveFrom: aCollection for: aPlayer [
	" 1: moved piece, 2: target square "
	
	| move |
	move := aCollection atRandom.
	aPlayer game move: (move at: 1) to: (move at: 2). 
	^ aPlayer
]

{ #category : 'playing' }
DeffensiveGamingStrategy >> kingIsInCheck: aPlayer [

^ aPlayer king isInCheck
		          ifTrue: [ OrderedCollection with: aPlayer king ]
		          ifFalse: [ aPlayer pieces copy asOrderedCollection ].
]

{ #category : 'playing' }
DeffensiveGamingStrategy >> legalMoves: aPlayer [
	" defensiveMoves: all legal moves that do NOT land on a square targeted by the opponent (safer).
	  standardMoves: legal moves that DO land on a square targeted by the opponent (risk of being eaten). "

	| pieces defensiveMoves standardMoves opponentPieces |
	pieces := self kingIsInCheck: aPlayer.
	opponentPieces := self kingIsInCheck: (aPlayer game currentPlayer isWhite ifTrue: [aPlayer game blackPlayer] ifFalse: [aPlayer game whitePlayer]).

	defensiveMoves := OrderedCollection new.
	standardMoves := OrderedCollection new.

	pieces do: [ :piece |
			| legalMoves |
			legalMoves := piece legalTargetSquares.
			legalMoves ifNotEmpty: [
					legalMoves do: [ :targetSquare |
							(targetSquare hasPiece and: [
								 targetSquare contents color ~= aPlayer color ])
								ifTrue: [ defensiveMoves add: (Array with: (targetSquare ) with: targetSquare) ]
								ifFalse: [ standardMoves add: (Array with: piece with: targetSquare) ] ] ] ].

	^ Array with: defensiveMoves with: standardMoves

]

{ #category : 'playing' }
DeffensiveGamingStrategy >> play: aPlayer [
	" deffendingMoves is a collecion who regroup all the moves can capture an ennemy
	  standardMoves is a collection who regroup all the moves who can't capture an ennemy, they are a normal in the grid. "

	| moves deffendingMoves standardMoves |
	
	moves := self legalMoves: aPlayer.

	deffendingMoves := moves first.
	standardMoves := moves second.


	deffendingMoves notEmpty ifTrue: [
		^ self executeRandomMoveFrom: deffendingMoves for: aPlayer ].

	standardMoves notEmpty ifTrue: [
		^ self executeRandomMoveFrom: standardMoves for: aPlayer ]
]
