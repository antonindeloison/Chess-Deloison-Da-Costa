Class {
	#name : 'MixedGamingStrategy',
	#superclass : 'DefensiveGamingStrategy',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'playing' }
MixedGamingStrategy >> getSafeCaptureMoves: aPlayer [

	| safeMoves safeCaptureMoves |
	safeMoves := self getSafeMoves: aPlayer.
	safeCaptureMoves := OrderedCollection new.

	safeMoves do: [ :move |
			| piece targetSquare |
			piece := move first.
			targetSquare := move at: 2.

			(targetSquare hasPiece and: [
				 targetSquare contents color ~= aPlayer color ]) ifTrue: [
				safeCaptureMoves add: move ] ].

	^ safeCaptureMoves
]

{ #category : 'playing' }
MixedGamingStrategy >> getSafeMoves: aPlayer [

	| opponentTargets safeMoves pieces |
	opponentTargets := self getOpponentTargetedSquares: aPlayer.
	safeMoves := OrderedCollection new.
	pieces := self kingIsInCheck: aPlayer.

	pieces do: [ :piece |
			piece legalTargetSquares do: [ :targetSquare |
					(opponentTargets includes: targetSquare) ifFalse: [
						safeMoves add: (Array with: piece with: targetSquare) ] ] ].

	^ safeMoves
]

{ #category : 'playing' }
MixedGamingStrategy >> play: aPlayer [
	"Mixed strategy :
    1. Save a piece in danger
    2. Make a safe capture
    3. Make a safe move
    4. Make random legal move"

	| escapeMoves safeMoves allMoves safeCaptureMoves |
	" 1. Save a piece in danger (HIGHEST PRIORITY)"
	escapeMoves := self getEscapeMoves: aPlayer.
	escapeMoves notEmpty ifTrue: [
		^ self executeRandomMoveFrom: escapeMoves for: aPlayer ].

	" 2. Make a safe capture"
	safeCaptureMoves := self getSafeCaptureMoves: aPlayer.
	safeCaptureMoves notEmpty ifTrue: [
		^ self executeRandomMoveFrom: safeCaptureMoves for: aPlayer ].

	" 3. Make a safe move"
	safeMoves := self getSafeMoves: aPlayer.
	safeMoves notEmpty ifTrue: [
		^ self executeRandomMoveFrom: safeMoves for: aPlayer ].

	" 4. Make random legal move"
	allMoves := self getAllOtherMoves: aPlayer.
	allMoves notEmpty ifTrue: [
		^ self executeRandomMoveFrom: allMoves for: aPlayer ].

	self noMovesAvailable
]
