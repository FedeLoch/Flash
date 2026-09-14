Class {
	#name : 'FlashTransportBarElement',
	#superclass : 'BlElement',
	#instVars : [
		'workspace',
		'playPauseButton',
		'bpmValueLabel',
		'tapButton',
		'panicButton',
		'beatLamp',
		'transportLabel'
	],
	#category : 'Flash-Workspace',
	#package : 'Flash-Workspace'
}

{ #category : 'instance creation' }
FlashTransportBarElement class >> onWorkspace: aWorkspace [
	^ self new workspace: aWorkspace
]

{ #category : 'building' }
FlashTransportBarElement >> addButton: aString action: aBlock [
	| button |
	button := BlElement new.
	button layout: BlLinearLayout horizontal.
	button extent: 64 @ 24.
	button background: (Color fromHexString: '#161B22').
	button geometry: BlRoundedRectangleGeometry new.
	button addChild: (self label: aString).
	button addEventHandler: (BlEventHandler on: BlClickEvent do: [ :evt | aBlock value ]).
	^ button
]

{ #category : 'accessing' }
FlashTransportBarElement >> beatLamp [
	^ beatLamp
]

{ #category : 'building' }
FlashTransportBarElement >> buildTransport [
	self layout: BlLinearLayout horizontal.
	self extent: 640 @ 44.
	self background: (Color fromHexString: '#11151C').
	self border: (BlBorder paint: (Color fromHexString: '#1D232B') width: 1).
	playPauseButton := self addButton: 'PLAY' action: [ workspace toggleRunning. self updateBpmLabel ].
	transportLabel := self label: 'TRANSPORT'.
	bpmValueLabel := self label: 'BPM'.
	tapButton := self addButton: 'TAP' action: [ workspace transportClock tap ].
	panicButton := self addButton: 'PANIC' action: [ workspace panic ].
	beatLamp := BlElement new.
	beatLamp size: 10 @ 10.
	beatLamp geometry: BlRoundedRectangleGeometry new.
	beatLamp background: (Color fromHexString: '#1D232B').
	self addChildren: { playPauseButton. transportLabel. bpmValueLabel. tapButton. panicButton. beatLamp }.
	self updateBpmLabel
]

{ #category : 'accessing' }
FlashTransportBarElement >> bpmValueLabel [
	^ bpmValueLabel
]

{ #category : 'events' }
FlashTransportBarElement >> flashPlayhead [
	| flash |
	flash := BlColorTransition new
		from: (Color fromHexString: '#00F2FF');
		to: (Color fromHexString: '#1D232B');
		duration: 300 milliSeconds;
		onStepDo: [ :c | beatLamp background: c ];
		yourself.
	beatLamp background: (Color fromHexString: '#00F2FF').
	beatLamp addAnimation: flash
]

{ #category : 'initialization' }
FlashTransportBarElement >> initialize [
	super initialize.
	workspace := FlashWorkspace new.
	self buildTransport
]

{ #category : 'building' }
FlashTransportBarElement >> label: aString [
	| text |
	text := BlTextElement new text: ((aString asRopedText) foreground: (Color fromHexString: '#C5CDD8')).
	text constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	^ text
]

{ #category : 'accessing' }
FlashTransportBarElement >> panicButton [
	^ panicButton
]

{ #category : 'accessing' }
FlashTransportBarElement >> playPauseButton [
	^ playPauseButton
]

{ #category : 'accessing' }
FlashTransportBarElement >> tapButton [
	^ tapButton
]

{ #category : 'accessing' }
FlashTransportBarElement >> transportLabel [
	^ transportLabel
]

{ #category : 'updating' }
FlashTransportBarElement >> updateBpmLabel [
	bpmValueLabel text: (((workspace bpm asInteger printString , ' BPM') asRopedText) foreground: (Color fromHexString: '#C5CDD8'))
]

{ #category : 'accessing' }
FlashTransportBarElement >> workspace [
	^ workspace
]

{ #category : 'accessing' }
FlashTransportBarElement >> workspace: aWorkspace [
	workspace := aWorkspace.
	self updateBpmLabel
]