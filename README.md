# Chess-Deloison-Da-Costa

## Summary
- [Installation instructions](#installation-instructions)
- [Instructions for use](#instructions-for-use)
- [Design decision
](#design-decision)
  - [Kata : Refactoring du rendu des pièces](#kata--refactor-piece-rendering)
- [Authors](#authors)

## Installation instructions

## Instructions for use

## Design decision

## Explain the basics

### Kata : Refactor piece rendering

Initial solution: 


```smalltalk
MyChessSquare >> renderKnight: aPiece

	^ aPiece isWhite
		  ifFalse: [ color isBlack
				  ifFalse: [ 'M' ]
				  ifTrue: [ 'm' ] ]
		  ifTrue: [
			  color isBlack
				  ifFalse: [ 'N' ]
				  ifTrue: [ 'n' ] ]
`````
**Goal:** remove the ifs. 


Presentation of design choices to solve this problem.

We started by tackling the problem at its source. Here, the first call to the rendering system is made in:

```smalltalk
MyChessSquare >> contents: aPiece

	| text |
	contents := aPiece.

	text := contents
		        ifNil: [
				        color isBlack
					        ifFalse: [ 'z' ]
					        ifTrue: [ 'x' ] ]
		        ifNotNil: [ <span style="color:#ff5555"> contents renderPieceOn: self </span> ].
	piece text: (text asRopedText
			 fontSize: 48;
			 foreground: self foreground;
			 fontName: MyOpenChessDownloadedFont new familyName)
`````

The first thing to implement is a **double dispatch** to obtain the type of piece, the colour of the piece and the colour of the square, in order to determine which character to return.

To begin with, **MyChessSquare >> contents: aPiece** sends a message to a piece of type x to find out its type.  
In this example, the piece type will be MyKnight.


**The message renderPieceOn: aSquare** is applied to an object of type **MyKnight**, which then tells **aSquare** that the rendering must be performed for an object of its type and passes itself as an argument.

```smalltalk
MyKnight >> renderPieceOn: aSquare

	^ aSquare renderKnight: self
```

Next, the square tells the render Knight that the rendering must be done for a MyKnight-type piece, and she gives the piece and herself to MyKnightRender.

```smalltalk
MychessSquare >> renderKnight: aPiece

	^ MyKnightRender new render: aPiece on: self
```

This is where the **double dispatch** ends. We used it to determine which render to use based on the type of piece currently positioned on the square. **This double dispatch was already present; we only modified the body of the method  MyChessSquare >> renderX: aPiece**, in order to implement a MyRender hierarchy in the dispatch table. It was essential to recall how this double dispatch works in order to fully understand why we made this modification.

Now, let's move on to the core of the modification, which is the addition of a MyRender hierarchy containing a **dispatch table**.

The MyRender class is abstract and has a render for each type of piece. Each render has a render method that takes a piece and a square as arguments.

In our example, we will use MyKnightRender.

```smalltalk
MyKnightRender >> render: aPiece on: aSquare

	| pieceColor squareColor key |
	pieceColor := self colorNameFor: aPiece isWhite.
	squareColor := self colorNameFor: aSquare isWhite.
	key := {
		       #knight.
		       pieceColor.
		       squareColor }.
	^ self pieceTables at: key ifAbsent: [ 'Erreur' ]
````

The render method aims to construct the key used to find the correct character in the dictionary based on:
- The type of piece
- The colour of the piece
- The colour of the square

Finally, MyRender has the dictionary in which each of its subclasses retrieves its value.

```smalltalk
MyRender >> pieceTables

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
````

In conclusion, thanks to **double dispatch** and **table dispatch**, we arrive at a solution without if statements, code is clean, readable applies the Don't ask, tell principle and is open to extensions.

The goal of creating one class per render is to allow for potential future extensions.

## Authors

- Matéo DA COSTA
- Antonin DELOISON