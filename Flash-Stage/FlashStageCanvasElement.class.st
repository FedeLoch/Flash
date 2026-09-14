Class {
	#name : 'FlashStageCanvasElement',
	#superclass : 'BlElement',
	#instVars : [
		'headerBar',
		'contentPane',
		'backgroundLayer',
		'scanlines',
		'particleCanvas',
		'presetButtons',
		'currentPresentation'
	],
	#category : 'Flash-Stage',
	#package : 'Flash-Stage'
}

{ #category : 'presentations' }
FlashStageCanvasElement >> applyPresentation: aFlashStagePresentation [
	currentPresentation := aFlashStagePresentation.
	aFlashStagePresentation applyTo: self
]

{ #category : 'accessing' }
FlashStageCanvasElement >> backgroundLayer [
	^ backgroundLayer
]

{ #category : 'initialization' }
FlashStageCanvasElement >> buildCanvas [
	contentPane := BlElement new
		layout: BlFrameLayout new;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		yourself.

	backgroundLayer := BlElement new
		background: (Color fromHexString: '#0A0E14');
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		yourself.

	scanlines := FlashScanlineOverlay new.

	particleCanvas := FlashParticleCanvasElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		yourself.

	contentPane addChild: backgroundLayer.
	contentPane addChild: scanlines.
	contentPane addChild: particleCanvas.
	self addChild: contentPane
]

{ #category : 'initialization' }
FlashStageCanvasElement >> buildHeaderBar [
	presetButtons := OrderedCollection new.

	headerBar := BlElement new
		layout: (BlLinearLayout horizontal cellSpacing: 10);
		background: ((Color fromHexString: '#0A0E14') alpha: 0.85);
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical exact: 48 ];
		yourself.

	headerBar addChild: ((BlTextElement text: ('FLASH STAGE' asRopedText foreground: (Color fromHexString: '#00F2FF')))
	background: Color transparent;
	constraintsDo: [ :c |
		c vertical fitContent.
		c horizontal fitContent.
		c padding: (BlInsets all: 14) ]).

	FlashStagePresentation all do: [ :preset |
		| button |
		button := self presetButtonFor: preset.
		presetButtons add: button.
		headerBar addChild: button ].

	headerBar addChild: (BlElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical exact: 1 ];
		yourself).

	self addChild: headerBar
]

{ #category : 'accessing' }
FlashStageCanvasElement >> contentPane [
	^ contentPane
]

{ #category : 'accessing' }
FlashStageCanvasElement >> currentPresentation [
	^ currentPresentation
]

{ #category : 'accessing' }
FlashStageCanvasElement >> headerBar [
	^ headerBar
]

{ #category : 'initialization' }
FlashStageCanvasElement >> initialize [
	super initialize.

	self layout: (BlLinearLayout vertical).
	self constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	self background: (Color fromHexString: '#0A0E14').

	self buildHeaderBar.
	self buildCanvas.

	currentPresentation := FlashStagePresentation presetForId: #phosphor.
	currentPresentation applyTo: self
]

{ #category : 'accessing' }
FlashStageCanvasElement >> particleCanvas [
	^ particleCanvas
]

{ #category : 'accessing' }
FlashStageCanvasElement >> presetButtons [
	^ presetButtons
]

{ #category : 'events' }
FlashStageCanvasElement >> presetPulse: aFlashMelodyEvent [
	particleCanvas spawnVisualFor: aFlashMelodyEvent
]

{ #category : 'events' }
FlashStageCanvasElement >> presetPulseFor: aCollection [
	aCollection do: [ :e | self presetPulse: e ].
	^ aCollection
]

{ #category : 'accessing' }
FlashStageCanvasElement >> scanlines [
	^ scanlines
]

{ #category : 'initialization' }
FlashStageCanvasElement >> presetButtonFor: aFlashStagePresentation [
	| button |
	button := BlElement new
		layout: (BlLinearLayout horizontal);
		background: (aFlashStagePresentation accentColor alpha: 0.12);
		border: (BlBorder paint: aFlashStagePresentation accentColor width: 1);
		geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
		constraintsDo: [ :c |
			c vertical fitContent.
			c horizontal fitContent.
			c padding: (BlInsets top: 6 left: 10 bottom: 6 right: 10) ].

	button addChild: (BlTextElement text: (aFlashStagePresentation name asRopedText foreground: aFlashStagePresentation accentColor)).

	button addEventHandler: (BlEventHandler on: BlClickEvent do: [ :evt |
		self applyPresentation: aFlashStagePresentation ]).

	^ button
]