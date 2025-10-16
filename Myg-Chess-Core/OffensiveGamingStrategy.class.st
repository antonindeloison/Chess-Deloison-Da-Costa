Class {
	#name : 'OffensiveGamingStrategy',
	#superclass : 'AbstractGamingStrategy',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'as yet unclassified' }
OffensiveGamingStrategy >> executeRandomMoveFrom: aCollection for: aPlayer [
	" 1: moved piece, 2: target square "
	
	| move |
	move := aCollection atRandom.
	aPlayer game move: (move at: 1) to: (move at: 2). 
	^ aPlayer
]

{ #category : 'as yet unclassified' }
OffensiveGamingStrategy >> legalMoves: aPlayer [
	" attackingMoves is a collecion who regroup all the moves can capture an ennemy
	  standardMoves is a collection who regroup all the moves who can't capture an ennemy, they are a normal in the grid. "

	| pieces attackingMoves standardMoves |
	pieces := self listOfPiecesOrKing: aPlayer.

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

{ #category : 'as yet unclassified' }
OffensiveGamingStrategy >> listOfPiecesOrKing: aPlayer [

^ aPlayer king isInCheck
		          ifTrue: [ OrderedCollection with: aPlayer king ]
		          ifFalse: [ aPlayer pieces copy asOrderedCollection ].
]

{ #category : 'playing' }
OffensiveGamingStrategy >> play: aPlayer [
	" attackingMoves is a collecion who regroup all the moves can capture an ennemy
	  standardMoves is a collection who regroup all the moves who can't capture an ennemy, they are a normal in the grid. "

	| moves attackingMoves standardMoves |
	
	moves := self legalMoves: aPlayer.

	attackingMoves := moves first.
	standardMoves := moves second.


	attackingMoves notEmpty ifTrue: [
		^ self executeRandomMoveFrom: attackingMoves for: aPlayer ].

	standardMoves notEmpty ifTrue: [
		^ self executeRandomMoveFrom: standardMoves for: aPlayer ]
]
