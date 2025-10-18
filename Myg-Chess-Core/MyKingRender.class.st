Class {
	#name : 'MyKingRender',
	#superclass : 'MyRender',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'rendering' }
MyKingRender >> render: aPiece on: aSquare [

	| pieceColor squareColor key |
	pieceColor := self colorNameFor: aPiece isWhite.
	squareColor := self colorNameFor: aSquare isWhite.
	key := {
		       #king.
		       pieceColor.
		       squareColor }.
	^ self pieceTables at: key ifAbsent: [ 'Erreur' ]
]
