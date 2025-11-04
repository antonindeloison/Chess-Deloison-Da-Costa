Class {
	#name : 'OffensiveGamingStrategy',
	#superclass : 'AbstractGamingStrategy',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'as yet unclassified' }
OffensiveGamingStrategy >> legalMoves: aPlayer [
	"return 
	1. attackingMoves : all the moves that can capture an ennemy piece
	2. standardMoves : all the normal moves that can't capture an ennemy."

	| pieces attackingMoves standardMoves |
	pieces := self kingIsInCheck: aPlayer.

	attackingMoves := OrderedCollection new.
	standardMoves := OrderedCollection new.

	pieces do: [ :piece |
			| legalMoves |
			legalMoves := piece legalTargetSquares.
			legalMoves ifNotEmpty: [
					legalMoves do: [ :targetSquare |
							(targetSquare hasPiece and: [
								 targetSquare contents color ~= aPlayer color ])
								ifTrue: [ attackingMoves add: (Array with: piece with: targetSquare) ]
								ifFalse: [ standardMoves add: (Array with: piece with: targetSquare) ] ] ] ].


	^ Array with: attackingMoves with: standardMoves
]

{ #category : 'playing' }
OffensiveGamingStrategy >> play: aPlayer [
	"Offensive strategy that capture an ennemy piece if it's possible else do a random legal move"

	| moves attackingMoves standardMoves |
	moves := self legalMoves: aPlayer.

	attackingMoves := moves first.
	standardMoves := moves second.


	attackingMoves notEmpty ifTrue: [
		^ self executeRandomMoveFrom: attackingMoves for: aPlayer ].

	standardMoves notEmpty ifTrue: [
		^ self executeRandomMoveFrom: standardMoves for: aPlayer ].

	self noMovesAvailable
]
