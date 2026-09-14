Class {
	#name : 'FlashDemoPatterns',
	#superclass : 'Object',
	#category : 'Flash-Support',
	#package : 'Flash-Support'
}

{ #category : 'patterns' }
FlashDemoPatterns class >> defaultLanes [
	^ Dictionary newFromPairs: {
			#kick.
			(FlashSequencerLane key: #kick
				gates: #( 1 0 0 0 1 0 0 0 1 0 1 0 1 0 0 0 )
				notes: #( 36 )
				name: 'Kick').
			#acid.
			(FlashSequencerLane key: #acid
				gates: #( 1 0 1 1 0 1 0 1 1 0 1 0 1 1 0 1 )
				notes: #( 48 51 55 58 60 55 62 60 )
				name: 'Acid').
			#hihat.
			(FlashSequencerLane key: #hihat
				gates: #( 0 0 1 0 0 0 1 0 1 0 0 0 1 0 1 1 )
				notes: #( 70 )
				name: 'HHat') }
]

{ #category : 'patterns' }
FlashDemoPatterns class >> hiHatSteps [
	^ (#( 0 0 1 0 0 0 1 0 1 0 0 0 1 0 1 1 ) collect: [ :e | e isZero not ]) asArray
]

{ #category : 'patterns' }
FlashDemoPatterns class >> kickSteps [
	^ (#( 1 0 0 0 1 0 0 0 1 0 1 0 1 0 0 0 ) collect: [ :e | e isZero not ]) asArray
]

{ #category : 'patterns' }
FlashDemoPatterns class >> stepPitches [
	^ #( 'C3' 'Eb3' 'G3' 'Bb3' 'C4' 'D4' 'G4' 'F4' 'C3' 'Eb3' 'G3' 'Bb3' 'C4' 'G3' 'D4' 'C3' )
]