Class {
	#name : 'RandomGamingStrategy',
	#superclass : 'AbstractGamingStrategy',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'playing' }
RandomGamingStrategy >> play: aPlayer [

	| pieces |
	pieces := aPlayer king isInCheck
		          ifTrue: [ OrderedCollection with: aPlayer king ]
		          ifFalse: [ aPlayer pieces copy asOrderedCollection ].


	[ pieces notEmpty ] whileTrue: [
			| piece legalMoves |
			piece := pieces atRandom.
			pieces remove: piece.
			legalMoves := piece legalTargetSquares.
			legalMoves ifNotEmpty: [
					aPlayer game move: piece to: legalMoves atRandom.
					^ aPlayer ] ].

	1 halt: 'NO MOVES AVAILABLE!'
]
