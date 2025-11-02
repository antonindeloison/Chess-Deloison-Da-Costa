Class {
	#name : 'MyRender',
	#superclass : 'Object',
	#instVars : [
		'pieceTables',
		'colorNameTable'
	],
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'accessing' }
MyRender >> colorNameFor: aBoolean [

	^ self colorNameTable at: aBoolean
]

{ #category : 'accessing' }
MyRender >> colorNameTable [
	^ colorNameTable ifNil: [
		colorNameTable := {
			true -> 'white'.
			false -> 'black'
		} asDictionary
	]

]

{ #category : 'as yet unclassified' }
MyRender >> pieceTables [

	^ pieceTables ifNil: [
			  pieceTables := Dictionary new.

			  "Knight"
			  pieceTables at: { #knight. 'white'. 'white' } put: 'N'.
			  pieceTables at: { #knight. 'white'. 'black' } put: 'n'.
			  pieceTables at: { #knight. 'black'. 'white' } put: 'M'.
			  pieceTables at: { #knight. 'black'. 'black' } put: 'm'.

			  "Bishop"
			  pieceTables at: { #bishop. 'white'. 'white' } put: 'B'.
			  pieceTables at: { #bishop. 'white'. 'black' } put: 'b'.
			  pieceTables at: { #bishop. 'black'. 'white' } put: 'V'.
			  pieceTables at: { #bishop. 'black'. 'black' } put: 'v'.

			  "King"
			  pieceTables at: { #king. 'white'. 'white' } put: 'K'.
			  pieceTables at: { #king. 'white'. 'black' } put: 'k'.
			  pieceTables at: { #king. 'black'. 'white' } put: 'L'.
			  pieceTables at: { #king. 'black'. 'black' } put: 'l'.

			  "pawn"
			  pieceTables at: { #pawn. 'white'. 'white' } put: 'P'.
			  pieceTables at: { #pawn. 'white'. 'black' } put: 'p'.
			  pieceTables at: { #pawn. 'black'. 'white' } put: 'O'.
			  pieceTables at: { #pawn. 'black'. 'black' } put: 'o'.

			  "queen"
			  pieceTables at: { #queen. 'white'. 'white' } put: 'Q'.
			  pieceTables at: { #queen. 'white'. 'black' } put: 'q'.
			  pieceTables at: { #queen. 'black'. 'white' } put: 'W'.
			  pieceTables at: { #queen. 'black'. 'black' } put: 'w'.

			  "rook"
			  pieceTables at: { #rook. 'white'. 'white' } put: 'R'.
			  pieceTables at: { #rook. 'white'. 'black' } put: 'r'.
			  pieceTables at: { #rook. 'black'. 'white' } put: 'T'.
			  pieceTables at: { #rook. 'black'. 'black' } put: 't'.

			  pieceTables ]
]

{ #category : 'as yet unclassified' }
MyRender >> tableFor: aSymbol [

	^ (self pieceTables at: aSymbol ifAbsent: [ Dictionary new ])
]
