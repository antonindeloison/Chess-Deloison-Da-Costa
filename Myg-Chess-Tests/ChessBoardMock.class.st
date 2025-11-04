Class {
	#name : 'ChessBoardMock',
	#superclass : 'Object',
	#instVars : [
		'board',
		'game'
	],
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'accessing' }
ChessBoardMock >> addBlack: pieceClass at: square [

	^ self addPiece: pieceClass color: #black at: square
]

{ #category : 'accessing' }
ChessBoardMock >> addPiece: aPieceClass color: aColor at: aSquareName [

	| piece |
	piece := aPieceClass perform: aColor.
	board at: aSquareName put: piece.
	^ piece
]

{ #category : 'accessing' }
ChessBoardMock >> addWhite: pieceClass at: square [

	^ self addPiece: pieceClass color: #white at: square
]

{ #category : 'accessing' }
ChessBoardMock >> basicSetup [

	^ self
		  addWhite: MyKing at: 'e1';
		  addWhite: MyRook at: 'd1';
		  yourself
]

{ #category : 'accessing' }
ChessBoardMock >> board [

	^ board
]

{ #category : 'accessing' }
ChessBoardMock >> board: anObject [

	board := anObject
]

{ #category : 'accessing' }
ChessBoardMock >> captureScenario [

	^ self basicSetup
		  addBlack: MyPawn at: 'a7';
		  yourself
]

{ #category : 'accessing' }
ChessBoardMock >> checkScenario [

	^ self multiPieceSetup
		  addBlack: MyRook at: 'e8';
		  yourself
]

{ #category : 'as yet unclassified' }
ChessBoardMock >> cornerSafeCaptureScenario [

	^ self
		  addWhite: MyKing at: 'a1';
		  addWhite: MyRook at: 'a2';
		  addBlack: MyPawn at: 'a8';
		  addBlack: MyKing at: 'h8';
		  yourself
]

{ #category : 'accessing' }
ChessBoardMock >> game [

	^ game
]

{ #category : 'accessing' }
ChessBoardMock >> game: anObject [

	game := anObject
]

{ #category : 'accessing' }
ChessBoardMock >> initialize [

	super initialize.
	board := MyChessBoard empty.
	game := MyChessGame freshGame.
	game board: board
]

{ #category : 'accessing' }
ChessBoardMock >> multiCaptureScenario [

	^ self
		  addWhite: MyKing at: 'e1';
		  addWhite: MyQueen at: 'd4';
		  addBlack: MyPawn at: 'd7';
		  addBlack: MyPawn at: 'a4';
		  addBlack: MyPawn at: 'g7';
		  yourself
]

{ #category : 'accessing' }
ChessBoardMock >> multiPieceSetup [

	^ self
		  addWhite: MyKing at: 'e1';
		  addWhite: MyQueen at: 'd1';
		  addWhite: MyBishop at: 'c1';
		  addWhite: MyKnight at: 'b1';
		  addWhite: MyRook at: 'a1';
		  addWhite: MyPawn at: 'f1';
		  yourself
]

{ #category : 'accessing' }
ChessBoardMock >> pawnCaptureScenario [

	^ self
		  addWhite: MyKing at: 'e2';
		  addWhite: MyPawn at: 'd4';
		  addBlack: MyPawn at: 'd5';
		  yourself
]

{ #category : 'as yet unclassified' }
ChessBoardMock >> safeCaptureScenario [

	^ self
		  addWhite: MyKing at: 'e1';
		  addWhite: MyRook at: 'a1';
		  addBlack: MyPawn at: 'a2';
		  addBlack: MyPawn at: 'b1';
		  yourself
]

{ #category : 'accessing' }
ChessBoardMock >> stalemateScenario [

	^ self
		  addWhite: MyKing at: 'a1';
		  addBlack: MyRook at: 'a2';
		  addBlack: MyRook at: 'b1';
		  addBlack: MyQueen at: 'b2';
		  yourself
]

{ #category : 'accessing' }
ChessBoardMock >> threatScenario [

	^ self basicSetup
		  addBlack: MyRook at: 'd8';
		  yourself
]
