Class {
	#name : 'FlashHudEditorElement',
	#superclass : 'BlElement',
	#instVars : [
		'editorWindow',
		'bodyContainer',
		'dragHandle',
		'opacityValueLabel',
		'decreaseButton',
		'increaseButton',
		'minimizeButton',
		'hudOpacity',
		'isEditorVisible'
	],
	#category : 'Flash-Stage',
	#package : 'Flash-Stage'
}

{ #category : 'building' }
FlashHudEditorElement >> addButton: aString action: aBlock [
	| button |
	button := BlElement new.
	button extent: 44 @ 20.
	button background: (Color fromHexString: '#161B22').
	button geometry: BlRoundedRectangleGeometry new.
	button addChild: (self label: aString).
	button addEventHandler: (BlEventHandler on: BlClickEvent do: [ :evt | aBlock value ]).
	^ button
]

{ #category : 'accessing' }
FlashHudEditorElement >> bodyContainer [
	^ bodyContainer
]

{ #category : 'initialization' }
FlashHudEditorElement >> buildHud [
	| chromeRow |
	self layout: BlLinearLayout vertical.
	self extent: 640 @ 440.
	self background: ((Color fromHexString: '#11151C') alpha: 0.85).
	self border: (BlBorder paint: (Color fromHexString: '#1D232B') width: 1).
	self geometry: (BlRoundedRectangleGeometry cornerRadius: 8).

	dragHandle := self label: 'HUD EDITOR'.
	minimizeButton := self addButton: 'MIN' action: [ self toggleMinimized ].
	decreaseButton := self addButton: '-' action: [ self changeOpacityBy: -0.1 ].
	increaseButton := self addButton: '+' action: [ self changeOpacityBy: 0.1 ].
	opacityValueLabel := self label: '100%'.

	chromeRow := BlElement new.
	chromeRow layout: BlLinearLayout horizontal.
	chromeRow constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical exact: 22 ].
	chromeRow addChildren: {
		dragHandle.
		decreaseButton.
		opacityValueLabel.
		increaseButton.
		minimizeButton }.
	self addChild: chromeRow.

	bodyContainer := BlElement new.
	bodyContainer layout: BlFrameLayout new.
	bodyContainer constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	editorWindow constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	bodyContainer addChild: editorWindow.
	self addChild: bodyContainer
]

{ #category : 'events' }
FlashHudEditorElement >> changeOpacityBy: aNumber [
	self hudOpacity: ((hudOpacity + aNumber) max: 0.3) min: 1.0
]

{ #category : 'accessing' }
FlashHudEditorElement >> decreaseButton [
	^ decreaseButton
]

{ #category : 'accessing' }
FlashHudEditorElement >> dragHandle [
	^ dragHandle
]

{ #category : 'accessing' }
FlashHudEditorElement >> editorWindow [
	^ editorWindow
]

{ #category : 'accessing' }
FlashHudEditorElement >> hudOpacity [
	^ hudOpacity
]

{ #category : 'updating' }
FlashHudEditorElement >> hudOpacity: aNumber [
	hudOpacity := aNumber.
	self opacity: hudOpacity.
	opacityValueLabel text: (((hudOpacity * 100) asInteger printString , '%') asRopedText)
]

{ #category : 'initialization' }
FlashHudEditorElement >> initialize [
	super initialize.
	hudOpacity := 1.0.
	isEditorVisible := true.
	editorWindow := FlashEditorWindowElement new.
	self buildHud
]

{ #category : 'accessing' }
FlashHudEditorElement >> increaseButton [
	^ increaseButton
]

{ #category : 'accessing' }
FlashHudEditorElement >> isEditorVisible [
	^ isEditorVisible
]

{ #category : 'building' }
FlashHudEditorElement >> label: aString [
	| text |
	text := BlTextElement new text: (aString asRopedText).
	text constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	^ text
]

{ #category : 'querying' }
FlashHudEditorElement >> liveEditor [
	^ editorWindow liveEditor
]

{ #category : 'accessing' }
FlashHudEditorElement >> minimizeButton [
	^ minimizeButton
]

{ #category : 'accessing' }
FlashHudEditorElement >> opacityValueLabel [
	^ opacityValueLabel
]

{ #category : 'events' }
FlashHudEditorElement >> toggleMinimized [
	isEditorVisible := isEditorVisible not.
	bodyContainer visibility: (isEditorVisible ifTrue: BlVisibility visible ifFalse: BlVisibility hidden).
	self extent: (isEditorVisible
		ifTrue: 640 @ 440
		ifFalse: 640 @ 24)
]