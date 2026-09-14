Class {
	#name : 'FlashParticleCanvasElement',
	#superclass : 'BlElement',
	#instVars : [
		'engine',
		'labelText',
		'accentColor',
		'baseHeight',
		'visualsPane',
		'bottomBar'
	],
	#category : 'Flash-Particles',
	#package : 'Flash-Particles'
}

{ #category : 'accessing' }
FlashParticleCanvasElement >> accentColor [
	^ accentColor
]

{ #category : 'accessing' }
FlashParticleCanvasElement >> accentColor: aColor [
	accentColor := aColor
]

{ #category : 'accessing' }
FlashParticleCanvasElement >> bottomBar [
	^ bottomBar
]

{ #category : 'building' }
FlashParticleCanvasElement >> buildCanvas [
	self layout: BlLinearLayout vertical.
	self extent: 320 @ 200.
	self background: (Color fromHexString: '#0A0E14').
	self border: (BlBorder paint: (Color fromHexString: '#1D232B') width: 1).
	baseHeight := 180.
	visualsPane := BlElement new.
	visualsPane layout: BlFrameLayout new.
	visualsPane constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	bottomBar := BlElement new.
	bottomBar layout: BlLinearLayout horizontal.
	bottomBar constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical exact: 22 ].
	labelText := BlTextElement new text: ('' asRopedText).
	labelText constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	bottomBar addChild: labelText.
	self addChildren: { visualsPane. bottomBar }
]

{ #category : 'querying' }
FlashParticleCanvasElement >> colorForKind: aSymbol [
	aSymbol = #shockwave ifTrue: [ ^ Color fromHexString: '#60FF99' ].
	aSymbol = #spark ifTrue: [ ^ Color fromHexString: '#FFB700' ].
	aSymbol = #shower ifTrue: [ ^ Color fromHexString: '#00F2FF' ].
	^ accentColor ifNil: [ Color fromHexString: '#00F2FF' ]
]

{ #category : 'building' }
FlashParticleCanvasElement >> effectiveHeight [
	^ visualsPane height max: baseHeight
]

{ #category : 'accessing' }
FlashParticleCanvasElement >> engine [
	^ engine
]

{ #category : 'initialization' }
FlashParticleCanvasElement >> initialize [
	super initialize.
	engine := FlashParticleEngine new.
	accentColor := Color fromHexString: '#00F2FF'.
	self buildCanvas.
	self updateLabel
]

{ #category : 'accessing' }
FlashParticleCanvasElement >> labelText [
	^ labelText
]

{ #category : 'events' }
FlashParticleCanvasElement >> panic [
	self resetParticles
]

{ #category : 'events' }
FlashParticleCanvasElement >> pulseFor: aFlashMelodyEvent [
	engine spawnForEvent: aFlashMelodyEvent.
	self spawnVisualFor: aFlashMelodyEvent.
	self updateLabel
]

{ #category : 'events' }
FlashParticleCanvasElement >> resetParticles [
	engine clear.
	visualsPane removeChildren.
	self updateLabel
]

{ #category : 'spawning' }
FlashParticleCanvasElement >> spawnVisualFor: aFlashMelodyEvent [
	| visual color kind life offset animation fade |
	color := self colorForKind: aFlashMelodyEvent triggerKind.
	kind := aFlashMelodyEvent triggerKind.
	life := (aFlashMelodyEvent velocity ifNil: [ 0.8 ]) * 550.
	visual := BlElement new.
	visual size: 6 @ 6.
	visual geometry: BlRoundedRectangleGeometry new.
	visual background: (color alpha: 0.9).
	visual constraintsDo: [ :c |
		c frame horizontal alignLeftAt: (self spawnXFor: aFlashMelodyEvent).
		c frame vertical alignBottomAt: 6 ].
	visualsPane addChild: visual.
	offset := kind = #shockwave
		ifTrue: [ ((aFlashMelodyEvent normalizedPitch * 40 - 20) rounded) @ (life / -3.0) ]
		ifFalse: [ 0 @ (life / -2.0) ].
	animation := (BlTransformAnimation translate: offset)
		duration: life milliSeconds.
	fade := BlColorTransition new
		from: (color alpha: 0.9);
		to: Color transparent;
		duration: life milliSeconds;
		onStepDo: [ :c | visual background: c ];
		yourself.
	visual addAnimation: animation.
	visual addAnimation: fade
]

{ #category : 'spawning' }
FlashParticleCanvasElement >> spawnXFor: aFlashMelodyEvent [
	| base |
	base := (visualsPane width max: 320) - 60.
	^ 30 + ((aFlashMelodyEvent pitchIndex * base) rounded max: 0)
]

{ #category : 'updating' }
FlashParticleCanvasElement >> updateLabel [
	labelText text: (('PARTICLES ' , engine size printString) asRopedText)
]

{ #category : 'accessing' }
FlashParticleCanvasElement >> visualsPane [
	^ visualsPane
]