Class {
	#name : 'FlashStageDockElement',
	#superclass : 'BlElement',
	#instVars : [
		'workspace',
		'miniMatrix',
		'transportToggleButton',
		'sweepButton',
		'burstButton',
		'panicButton',
		'stepValueLabel',
		'masterBeatLed',
		'bpmDisplayLabel',
		'sparkLabel',
		'sparkDensity',
		'vuLeftFill',
		'vuRightFill',
		'tickerLabel',
		'burstAction'
	],
	#category : 'Flash-Stage',
	#package : 'Flash-Stage'
}

{ #category : 'instance creation' }
FlashStageDockElement class >> onWorkspace: aWorkspace [
	^ self new workspace: aWorkspace
]

{ #category : 'building' }
FlashStageDockElement >> addButton: aString action: aBlock [
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

{ #category : 'building' }
FlashStageDockElement >> buildDock [
	| vuLeftBean vuRightBean |
	self layout: (BlLinearLayout horizontal cellSpacing: 6).
	self extent: 980 @ 76.
	self background: (Color fromHexString: '#11151C').
	self border: (BlBorder paint: (Color fromHexString: '#1D232B') width: 1).

	miniMatrix := FlashMiniMatrixElement onWorkspace: workspace.

	transportToggleButton := self addButton: 'PLAY' action: [ workspace toggleRunning. self syncTransportButton ].
	sweepButton := self addButton: 'SWEEP' action: [ workspace soundEventLog clear. self tickerText: 'SWEEP — visuals cleared' ].
	burstButton := self addButton: 'BURST' action: [ burstAction value ].
	panicButton := self addButton: 'PANIC' action: [ workspace panic. self tickerText: 'PANIC — all clear' ].

	stepValueLabel := self label: 'STEP 000'.
	bpmDisplayLabel := self label: '120 BPM'.
	sparkLabel := self label: 'SPARK x2'.

	masterBeatLed := BlElement new.
	masterBeatLed size: 8 @ 8.
	masterBeatLed geometry: BlRoundedRectangleGeometry new.
	masterBeatLed background: (Color fromHexString: '#1D232B').

	vuLeftFill := self vuFill.
	vuLeftBean := self vuColumnContaining: vuLeftFill.
	vuRightFill := self vuFill.
	vuRightBean := self vuColumnContaining: vuRightFill.

	tickerLabel := self label: '—'.

	self addChildren: {
		miniMatrix.
		transportToggleButton.
		sweepButton.
		burstButton.
		panicButton.
		stepValueLabel.
		bpmDisplayLabel.
		sparkLabel.
		vuLeftBean.
		vuRightBean.
		masterBeatLed.
		tickerLabel }
]

{ #category : 'accessing' }
FlashStageDockElement >> burstAction [
	^ burstAction
]

{ #category : 'accessing' }
FlashStageDockElement >> burstAction: aBlock [
	burstAction := aBlock
]

{ #category : 'accessing' }
FlashStageDockElement >> burstButton [
	^ burstButton
]

{ #category : 'updating' }
FlashStageDockElement >> flashMasterBeat [
	masterBeatLed background: (Color fromHexString: '#60FF99').
	masterBeatLed addAnimation: (BlColorTransition new
		from: (Color fromHexString: '#60FF99');
		to: (Color fromHexString: '#1D232B');
		duration: 200 milliSeconds;
		onStepDo: [ :c | masterBeatLed background: c ];
		yourself)
]

{ #category : 'initialization' }
FlashStageDockElement >> initialize [
	super initialize.
	workspace := FlashWorkspace new.
	sparkDensity := 2.
	burstAction := [ self tickerText: 'BURST' ].
	self buildDock
]

{ #category : 'building' }
FlashStageDockElement >> label: aString [
	| text |
	text := BlTextElement new text: (aString asRopedText).
	text constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	^ text
]

{ #category : 'accessing' }
FlashStageDockElement >> masterBeatLed [
	^ masterBeatLed
]

{ #category : 'accessing' }
FlashStageDockElement >> miniMatrix [
	^ miniMatrix
]

{ #category : 'accessing' }
FlashStageDockElement >> panicButton [
	^ panicButton
]

{ #category : 'updating' }
FlashStageDockElement >> sparkDensity: anInteger [
	sparkDensity := (anInteger max: 0) min: 8.
	sparkLabel text: ('SPARK x' , sparkDensity printString asRopedText)
]

{ #category : 'accessing' }
FlashStageDockElement >> sparkLabel [
	^ sparkLabel
]

{ #category : 'events' }
FlashStageDockElement >> stepClock: anInteger [
	miniMatrix tickToStep: anInteger.
	stepValueLabel text: ('STEP ' , anInteger printString asRopedText).
	anInteger = 0 ifTrue: [ self flashMasterBeat ]
]

{ #category : 'updating' }
FlashStageDockElement >> syncTransportButton [
	transportToggleButton removeChildren.
	transportToggleButton addChild: (self label: (workspace isRunning ifTrue: [ 'PAUSE' ] ifFalse: [ 'PLAY' ]))
]

{ #category : 'accessing' }
FlashStageDockElement >> stepValueLabel [
	^ stepValueLabel
]

{ #category : 'accessing' }
FlashStageDockElement >> sweepButton [
	^ sweepButton
]

{ #category : 'accessing' }
FlashStageDockElement >> tickerLabel [
	^ tickerLabel
]

{ #category : 'updating' }
FlashStageDockElement >> tickerText: aString [
	tickerLabel text: (aString asRopedText)
]

{ #category : 'accessing' }
FlashStageDockElement >> transportToggleButton [
	^ transportToggleButton
]

{ #category : 'updating' }
FlashStageDockElement >> updateBpm [
	bpmDisplayLabel text: ((workspace bpm asInteger printString) , ' BPM' asRopedText)
]

{ #category : 'building' }
FlashStageDockElement >> vuColumnContaining: aFill [
	| column |
	column := BlElement new.
	column size: 8 @ 30.
	column background: (Color fromHexString: '#0A0E14').
	column geometry: BlRoundedRectangleGeometry new.
	column addChild: aFill.
	^ column
]

{ #category : 'building' }
FlashStageDockElement >> vuFill [
	| fill |
	fill := BlElement new.
	fill size: 8 @ 0.
	fill background: (Color fromHexString: '#00F2FF').
	fill geometry: BlRoundedRectangleGeometry new.
	^ fill
]

{ #category : 'accessing' }
FlashStageDockElement >> vuLevels: anArray [
	| l r |
	l := ((anArray at: 1 ifAbsent: 0) max: 0) min: 1.
	r := ((anArray at: 2 ifAbsent: 0) max: 0) min: 1.
	vuLeftFill size: 8 @ (l * 28).
	vuRightFill size: 8 @ (r * 28).
	^ anArray
]

{ #category : 'accessing' }
FlashStageDockElement >> vuLeftFill [
	^ vuLeftFill
]

{ #category : 'accessing' }
FlashStageDockElement >> vuRightFill [
	^ vuRightFill
]

{ #category : 'accessing' }
FlashStageDockElement >> workspace [
	^ workspace
]

{ #category : 'accessing' }
FlashStageDockElement >> workspace: aWorkspace [
	workspace := aWorkspace.
	miniMatrix workspace: aWorkspace.
	self updateBpm
]