Class {
	#name : 'MyChessSquareTest',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyChessSquareTest >> testRenderBishopIsOk [

	self assert: (MyChessSquare white renderBishop: MyBishop white) equals: 'B'.
	self assert: (MyChessSquare white renderBishop: MyBishop  black) equals: 'V'.
	self assert: (MyChessSquare black renderBishop: MyBishop  black) equals: 'v'.
	self assert: (MyChessSquare black renderBishop: MyBishop  white) equals: 'b'.
]

{ #category : 'tests' }
MyChessSquareTest >> testRenderKingIsOk [

	self assert: (MyChessSquare white renderKing: MyKing white) equals: 'K'.
	self assert: (MyChessSquare white renderKing: MyKing black) equals: 'L'.
	self assert: (MyChessSquare black renderKing: MyKing black) equals: 'l'.
	self assert: (MyChessSquare black renderKing: MyKing white) equals: 'k'.
]

{ #category : 'tests' }
MyChessSquareTest >> testRenderKnightIsOk [

	self assert: (MyChessSquare white renderKnight: MyKnight white) equals: 'N'.
	self assert: (MyChessSquare white renderKnight: MyKnight black) equals: 'M'.
	self assert: (MyChessSquare black renderKnight: MyKnight black) equals: 'm'.
	self assert: (MyChessSquare black renderKnight: MyKnight white) equals: 'n'.
]

{ #category : 'tests' }
MyChessSquareTest >> testRenderPawnIsOk [

	self assert: (MyChessSquare white renderPawn: MyPawn white) equals: 'P'.
	self assert: (MyChessSquare white renderPawn: MyPawn black) equals: 'O'.
	self assert: (MyChessSquare black renderPawn: MyPawn black) equals: 'o'.
	self assert: (MyChessSquare black renderPawn: MyPawn white) equals: 'p'.
]

{ #category : 'tests' }
MyChessSquareTest >> testRenderQueenIsOk [

	self assert: (MyChessSquare white renderQueen: MyQueen white) equals: 'Q'.
	self assert: (MyChessSquare white renderQueen: MyQueen black) equals: 'W'.
	self assert: (MyChessSquare black renderQueen: MyQueen black) equals: 'w'.
	self assert: (MyChessSquare black renderQueen: MyQueen white) equals: 'q'.
]

{ #category : 'tests' }
MyChessSquareTest >> testRenderRookIsOk [

	self assert: (MyChessSquare white renderRook: MyRook white) equals: 'R'.
	self assert: (MyChessSquare white renderRook: MyRook black) equals: 'T'.
	self assert: (MyChessSquare black renderRook: MyRook black) equals: 't'.
	self assert: (MyChessSquare black renderRook: MyRook white) equals: 'r'.
]
