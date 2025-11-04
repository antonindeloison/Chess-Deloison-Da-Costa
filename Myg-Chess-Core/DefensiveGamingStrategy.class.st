Class {
	#name : 'DefensiveGamingStrategy',
	#superclass : 'AbstractGamingStrategy',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'playing' }
DefensiveGamingStrategy >> getAllOtherMoves: aPlayer [
    
    | allMoves pieces |
    allMoves := OrderedCollection new.
    pieces := self kingIsInCheck: aPlayer.
    
    pieces do: [ :piece |
        piece legalTargetSquares do: [ :targetSquare |
            allMoves add: (Array with: piece with: targetSquare) ] ].
    
    ^ allMoves
]

{ #category : 'playing' }
DefensiveGamingStrategy >> getEscapeMoves: aPlayer [

	| piecesInDanger escapeMoves opponentTargets |
	piecesInDanger := self getPiecesInDanger: aPlayer.
	opponentTargets := self getOpponentTargetedSquares: aPlayer.
	escapeMoves := OrderedCollection new.

	piecesInDanger do: [ :piece |
			piece legalTargetSquares do: [ :targetSquare |
					(opponentTargets includes: targetSquare) ifFalse: [
						escapeMoves add: (Array with: piece with: targetSquare) ] ] ].



	^ escapeMoves
]

{ #category : 'playing' }
DefensiveGamingStrategy >> getOpponentTargetedSquares: aPlayer [

	| opponent targetedSquares |
	opponent := aPlayer isWhite
		            ifTrue: [ aPlayer game blackPlayer ]
		            ifFalse: [ aPlayer game whitePlayer ].

	targetedSquares := Set new.
	opponent pieces do: [ :piece |
		piece legalTargetSquares do: [ :square |
			targetedSquares add: square ] ].

	^ targetedSquares
]

{ #category : 'playing' }
DefensiveGamingStrategy >> getPiecesInDanger: aPlayer [
    
    | opponentTargets piecesInDanger |
    opponentTargets := self getOpponentTargetedSquares: aPlayer.
    piecesInDanger := OrderedCollection new.
    
    aPlayer pieces do: [ :piece |
        (opponentTargets includes: piece square) ifTrue: [
            piecesInDanger add: piece ] ].
    
    ^ piecesInDanger
]

{ #category : 'playing' }
DefensiveGamingStrategy >> play: aPlayer [
	"Defensive strategy that saves a piece in danger else do a random legal move"

	| escapeMoves allMoves |
	escapeMoves := self getEscapeMoves: aPlayer.
	escapeMoves notEmpty ifTrue: [
		^ self executeRandomMoveFrom: escapeMoves for: aPlayer ].

	allMoves := self getAllOtherMoves: aPlayer.
	allMoves notEmpty ifTrue: [
		^ self executeRandomMoveFrom: allMoves for: aPlayer ].

	self noMovesAvailable
]
