Class {
	#name : 'AbstractGamingStrategy',
	#superclass : 'Object',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'playing' }
AbstractGamingStrategy >> executeRandomMoveFrom: aCollection for: aPlayer [

	| move |
	move := aCollection atRandom.
	aPlayer game move: move first to: (move at: 2).
	^ aPlayer
]

{ #category : 'playing' }
AbstractGamingStrategy >> kingIsInCheck: aPlayer [

^ aPlayer king isInCheck
		          ifTrue: [ OrderedCollection with: aPlayer king ]
		          ifFalse: [ aPlayer pieces copy asOrderedCollection ].
]

{ #category : 'playing' }
AbstractGamingStrategy >> noMovesAvailable [

	self halt: 'NO MOVES AVAILABLE!'
]

{ #category : 'playing' }
AbstractGamingStrategy >> play: aPlayer [

	^ self subclassResponsibility
]
