Class {
	#name : 'MyKnightRender',
	#superclass : 'MyRender',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'rendering' }
MyKnightRender >> render: aPiece on: aSquare [

	| pieceColor squareColor key |
	pieceColor := self colorNameFor: aPiece isWhite.
	squareColor := self colorNameFor: aSquare isWhite.
	key := {
		       #knight.
		       pieceColor.
		       squareColor }.
	^ self pieceTables at: key ifAbsent: [ 'Erreur' ]
]
