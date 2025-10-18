Class {
	#name : 'MyRookRender',
	#superclass : 'MyRender',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'rendering' }
MyRookRender >> render: aPiece on: aSquare [

	| pieceColor squareColor key |
	pieceColor := self colorNameFor: aPiece isWhite.
	squareColor := self colorNameFor: aSquare isWhite.
	key := {
		       #rook.
		       pieceColor.
		       squareColor }.
	^ self pieceTables at: key ifAbsent: [ 'Erreur' ]
]
