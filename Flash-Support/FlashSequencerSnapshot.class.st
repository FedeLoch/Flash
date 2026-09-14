Class {
	#name : 'FlashSequencerSnapshot',
	#superclass : 'Object',
	#instVars : [
		'lanes'
	],
	#category : 'Flash-Support',
	#package : 'Flash-Support'
}

{ #category : 'instance creation' }
FlashSequencerSnapshot class >> fromDemoPatterns [
	^ self new
		lanes: FlashDemoPatterns defaultLanes;
		yourself
]

{ #category : 'building' }
FlashSequencerSnapshot >> addLane: aFlashSequencerLane [
	lanes at: aFlashSequencerLane key put: aFlashSequencerLane
]

{ #category : 'querying' }
FlashSequencerSnapshot >> hasLane: aSymbol [
	^ lanes includesKey: aSymbol
]

{ #category : 'initialization' }
FlashSequencerSnapshot >> initialize [
	super initialize.
	lanes := Dictionary new
]

{ #category : 'querying' }
FlashSequencerSnapshot >> keys [
	^ lanes keys
]

{ #category : 'accessing' }
FlashSequencerSnapshot >> laneAtKey: aSymbol [
	^ lanes at: aSymbol ifAbsent: [ nil ]
]

{ #category : 'accessing' }
FlashSequencerSnapshot >> lanes [
	^ lanes
]

{ #category : 'accessing' }
FlashSequencerSnapshot >> lanes: aDictionary [
	lanes := aDictionary
]

{ #category : 'querying' }
FlashSequencerSnapshot >> noteNameAtStep: anInteger [
	| lane |
	lane := lanes at: #acid ifAbsent: [ lanes at: #lead ifAbsent: [ nil ] ].
	lane ifNil: [ ^ 'C4' ].
	^ FlashDemoPatterns stepPitches at: ((anInteger \\ 16) + 1)
]