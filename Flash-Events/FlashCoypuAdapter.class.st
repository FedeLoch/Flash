Class {
	#name : 'FlashCoypuAdapter',
	#superclass : 'Object',
	#category : 'Flash-Events',
	#package : 'Flash-Events'
}

{ #category : 'instance creation' }
FlashCoypuAdapter class >> laneFromSequencer: aSequencer [
	| name keys |
	keys := aSequencer seqKey.
	name := FlashMelodyEvent extractSoundNameFrom: aSequencer.
	^ FlashSequencerLane key: keys gates: (aSequencer gates copy) notes: (aSequencer notes copy) name: name
]

{ #category : 'instance creation' }
FlashCoypuAdapter class >> snapshotFrom: aPerformanceLike [
	| snapshot |
	snapshot := FlashSequencerSnapshot new.
	(aPerformanceLike respondsTo: #sequencers) ifFalse: [ ^ snapshot ].
	aPerformanceLike sequencers do: [ :each |
		snapshot addLane: (self laneFromSequencer: each) ].
	^ snapshot
]