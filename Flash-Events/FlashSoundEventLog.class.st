Class {
	#name : 'FlashSoundEventLog',
	#superclass : 'Object',
	#instVars : [
		'maxEntries',
		'entries'
	],
	#category : 'Flash-Events',
	#package : 'Flash-Events'
}

{ #category : 'adding' }
FlashSoundEventLog >> add: aFlashMelodyEvent [
	entries addLast: (self rowFor: aFlashMelodyEvent).
	[ entries size > maxEntries ] whileTrue: [ entries removeFirst ].
	^ self
]

{ #category : 'accessing' }
FlashSoundEventLog >> clear [
	entries removeAll
]

{ #category : 'accessing' }
FlashSoundEventLog >> entries [
	^ entries copy
]

{ #category : 'initialization' }
FlashSoundEventLog >> initialize [
	super initialize.
	maxEntries := 50.
	entries := OrderedCollection new
]

{ #category : 'querying' }
FlashSoundEventLog >> isEmpty [
	^ entries isEmpty
]

{ #category : 'accessing' }
FlashSoundEventLog >> maxEntries: anInteger [
	maxEntries := anInteger
]

{ #category : 'formatting' }
FlashSoundEventLog >> rowFor: aFlashMelodyEvent [
	| time |
	time := aFlashMelodyEvent timestamp
		ifNil: [ '--' ]
		ifNotNil: [ :t |
			(t hour printPaddedWith: $0 to: 2), ':',
			(t minute printPaddedWith: $0 to: 2), ':',
			(t second printPaddedWith: $0 to: 2), '.',
			((t nanoSecond // 1000000) printPaddedWith: $0 to: 3) ].
	^ String streamContents: [ :stream |
		stream
			nextPut: $[;
			nextPutAll: time;
			nextPut: $];
			space;
			nextPutAll: (aFlashMelodyEvent triggerKind printString);
			space;
			nextPutAll: aFlashMelodyEvent noteName;
			space;
			nextPutAll: (aFlashMelodyEvent soundName ifNil: [ '?' ]) ]
]

{ #category : 'querying' }
FlashSoundEventLog >> size [
	^ entries size
]