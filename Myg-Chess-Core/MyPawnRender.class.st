Class {
	#name : 'MyPawnRender',
	#superclass : 'MyRender',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'rendering' }
MyPawnRender >> render: aPiece on: aSquare [

	| pieceColor squareColor key |
	pieceColor := self colorNameFor: aPiece isWhite.
	squareColor := self colorNameFor: aSquare isWhite.
	key := {
		       #pawn.
		       pieceColor.
		       squareColor }.
	^ self pieceTables at: key ifAbsent: [ 'Erreur' ]
]
