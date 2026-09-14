Class {
	#name : 'FlashWorkspace',
	#superclass : 'Object',
	#instVars : [
		'snapshot',
		'transportClock',
		'soundEventLog',
		'theme',
		'bpm',
		'running'
	],
	#category : 'Flash-Workspace',
	#package : 'Flash-Workspace'
}

{ #category : 'example' }
FlashWorkspace class >> default [
	^ self new
]

{ #category : 'transport' }
FlashWorkspace >> advanceClock [
	| events |
	transportClock advance.
	events := OrderedCollection new.
	self laneKeys do: [ :key |
		| lane |
		lane := snapshot laneAtKey: key.
		(lane isNotNil and: [ lane gateAt: transportClock step + 1 ]) ifTrue: [
			events add: (self eventForLane: key atStep: transportClock step) ] ].
	events do: [ :e | self handleMelodyEvent: e ].
	^ events
]

{ #category : 'accessing' }
FlashWorkspace >> bpm [
	^ bpm
]

{ #category : 'accessing' }
FlashWorkspace >> bpm: aNumber [
	bpm := (aNumber max: 30.0) min: 300.0
]

{ #category : 'events' }
FlashWorkspace >> eventForLane: aSymbol atStep: anInteger [
	| lane note sound |
	lane := snapshot laneAtKey: aSymbol.
	note := lane ifNil: [ 60 ] ifNotNil: [ lane noteAt: anInteger + 1 ].
	sound := aSymbol = #kick
		ifTrue: [ 'bd' ]
		ifFalse: [ aSymbol = #acid
			ifTrue: [ 'bass1' ]
			ifFalse: [ aSymbol = #hihat ifTrue: [ 'hh' ] ifFalse: [ 'sample' ] ] ].
	^ FlashMelodyEvent new
		noteValue: note;
		velocity: 0.8;
		sequencerKey: aSymbol;
		soundName: sound;
		timestamp: DateAndTime now;
		yourself
]

{ #category : 'events' }
FlashWorkspace >> handleMelodyEvent: aFlashMelodyEvent [
	soundEventLog add: aFlashMelodyEvent
]

{ #category : 'initialization' }
FlashWorkspace >> initialize [
	super initialize.
	snapshot := FlashSequencerSnapshot fromDemoPatterns.
	transportClock := FlashTransportClock new.
	soundEventLog := FlashSoundEventLog new.
	theme := FlashRanaEffectTheme new.
	bpm := 138.0.
	running := false
]

{ #category : 'testing' }
FlashWorkspace >> isRunning [
	^ running
]

{ #category : 'querying' }
FlashWorkspace >> laneKeys [
	^ snapshot keys
]

{ #category : 'querying' }
FlashWorkspace >> laneForKey: aSymbol [
	^ snapshot laneAtKey: aSymbol
]

{ #category : 'transport' }
FlashWorkspace >> panic [
	soundEventLog clear.
	self theme isNotNil ifTrue: [ self soundEventLog clear ].
	transportClock resetTaps
]

{ #category : 'accessing' }
FlashWorkspace >> snapshot [
	^ snapshot
]

{ #category : 'accessing' }
FlashWorkspace >> soundEventLog [
	^ soundEventLog
]

{ #category : 'accessing' }
FlashWorkspace >> theme [
	^ theme
]

{ #category : 'accessing' }
FlashWorkspace >> theme: aFlashEffectTheme [
	theme := aFlashEffectTheme
]

{ #category : 'transport' }
FlashWorkspace >> toggleRunning [
	running := running not.
	^ running
]

{ #category : 'accessing' }
FlashWorkspace >> transportClock [
	^ transportClock
]