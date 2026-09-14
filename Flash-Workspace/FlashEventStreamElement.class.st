Class {
	#name : 'FlashEventStreamElement',
	#superclass : 'BlElement',
	#instVars : [
		'rows',
		'displayCount',
		'container'
	],
	#category : 'Flash-Workspace',
	#package : 'Flash-Workspace'
}

{ #category : 'building' }
FlashEventStreamElement >> buildStream [
	self layout: BlLinearLayout vertical.
	self extent: 320 @ 120.
	self background: (Color fromHexString: '#0A0E14').
	self border: (BlBorder paint: (Color fromHexString: '#1D232B') width: 1).
	container := BlElement new.
	container layout: BlLinearLayout vertical.
	container constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	self addChild: container.
	self addChild: (self titleLabel: 'EVENT STREAM')
]

{ #category : 'initialization' }
FlashEventStreamElement >> initialize [
	super initialize.
	rows := OrderedCollection new.
	displayCount := 6.
	self buildStream
]

{ #category : 'querying' }
FlashEventStreamElement >> rowCount [
	^ container children size
]

{ #category : 'accessing' }
FlashEventStreamElement >> rows [
	^ rows
]

{ #category : 'updating' }
FlashEventStreamElement >> refreshWith: anArrayOfStrings [
	| recent |
	container removeChildren.
	rows := OrderedCollection new.
	recent := anArrayOfStrings size <= displayCount
		ifTrue: [ anArrayOfStrings ]
		ifFalse: [ anArrayOfStrings last: displayCount ].
	recent do: [ :entry |
		| text |
		text := BlTextElement new text: (entry asRopedText).
		text constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical exact: 16 ].
		rows add: text.
		container addChild: text ]
]

{ #category : 'building' }
FlashEventStreamElement >> titleLabel: aString [
	| text |
	text := BlTextElement new text: (aString asRopedText).
	text constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical exact: 16 ].
	^ text
]