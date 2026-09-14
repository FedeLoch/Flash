Class {
	#name : 'FlashSequencerSnapshotTest',
	#superclass : 'TestCase',
	#category : 'Flash-Tests-Support',
	#package : 'Flash-Tests-Support'
}

{ #category : 'tests' }
FlashSequencerSnapshotTest >> testActiveStepsPerLane [
	| snapshot kick |
	snapshot := FlashSequencerSnapshot new.
	kick := FlashSequencerLane key: #kick gates: #( 1 0 0 0 1 0 0 0 1 0 1 0 1 0 0 0 ) notes: #( 36 ) name: 'Kick'.
	snapshot addLane: kick.
	self assert: (kick isActiveAt: 1).
	self deny: (kick isActiveAt: 2).
	self assert: (kick gateAt: 17)
]

{ #category : 'tests' }
FlashSequencerSnapshotTest >> testFromDemoPatternsContainsThreeLanes [
	| snapshot |
	snapshot := FlashSequencerSnapshot fromDemoPatterns.
	self assert: snapshot keys size equals: 3.
	self assert: (snapshot hasLane: #kick).
	self assert: (snapshot hasLane: #acid).
	self assert: (snapshot hasLane: #hihat)
]

{ #category : 'tests' }
FlashSequencerSnapshotTest >> testNoteAtWrapsRound [
	| lane |
	lane := FlashSequencerLane key: #acid gates: #( 1 ) notes: #( 48 51 ) name: 'Acid'.
	self assert: (lane noteAt: 1) equals: 48.
	self assert: (lane noteAt: 2) equals: 51.
	self assert: (lane noteAt: 3) equals: 48.
	self assert: (lane noteAt: 16) equals: 51
]