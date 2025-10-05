Class {
	#name : 'AbstractGamingStrategy',
	#superclass : 'Object',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'playing' }
AbstractGamingStrategy >> play: aPlayer [

	^ self subclassResponsibility
]
