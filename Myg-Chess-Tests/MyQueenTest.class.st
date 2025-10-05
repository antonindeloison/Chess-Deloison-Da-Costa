Class {
	#name : 'MyQueenTest',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyQueenTest >> testCanMyQuennMoveInASpecificSquare [

	| queen board squares |
	board := MyChessBoard empty.
	board at: 'd1' put: (queen := MyQueen white).
	board at: 'd4' put: MyKnight black.

	self assert: (board at: 'd1' contents) equals: MyQueen new.
	squares := queen targetSquares.
	self
		assertCollection: squares
		includesAll: (#( d4 ) collect: [ :name | board at: name ])
]
