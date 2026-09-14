Class {
	#name : 'FlashEditorWindowElement',
	#superclass : 'BlElement',
	#instVars : [
		'liveEditor',
		'titleBar',
		'doItButton',
		'printItButton',
		'inspectItButton',
		'bodyContainer',
		'toast'
	],
	#category : 'Flash-Workspace',
	#package : 'Flash-Workspace'
}

{ #category : 'building' }
FlashEditorWindowElement >> addButton: aString action: aBlock [
	| button |
	button := BlElement new.
	button extent: 60 @ 22.
	button background: (Color fromHexString: '#161B22').
	button geometry: BlRoundedRectangleGeometry new.
	button addChild: (self label: aString).
	button addEventHandler: (BlEventHandler on: BlClickEvent do: [ :evt | aBlock value ]).
	^ button
]

{ #category : 'accessing' }
FlashEditorWindowElement >> bodyContainer [
	^ bodyContainer
]

{ #category : 'building' }
FlashEditorWindowElement >> buildChrome [
	self layout: BlLinearLayout vertical.
	self extent: 600 @ 420.
	self background: (Color fromHexString: '#11151C').
	self border: (BlBorder paint: (Color fromHexString: '#1D232B') width: 1).
	titleBar := BlElement new.
	titleBar layout: BlLinearLayout horizontal.
	titleBar constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical exact: 30 ].
	titleBar addChild: (self label: 'FLASH LIVE EDITOR').
	doItButton := self addButton: 'DO IT' action: [ liveEditor doIt ].
	printItButton := self addButton: 'PRINT IT' action: [ liveEditor printIt ].
	inspectItButton := self addButton: 'INSPECT' action: [ liveEditor inspectIt ].
	titleBar addChildren: { doItButton. printItButton. inspectItButton }.
	toast := self label: ''.
	bodyContainer := BlElement new.
	bodyContainer layout: BlFrameLayout new.
	bodyContainer constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	liveEditor constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	bodyContainer addChild: liveEditor.
	self addChildren: { titleBar. bodyContainer. toast }
]

{ #category : 'accessing' }
FlashEditorWindowElement >> doItButton [
	^ doItButton
]

{ #category : 'initialization' }
FlashEditorWindowElement >> initialize [
	super initialize.
	liveEditor := FlashLiveEditor new.
	self buildChrome
]

{ #category : 'accessing' }
FlashEditorWindowElement >> inspectItButton [
	^ inspectItButton
]

{ #category : 'building' }
FlashEditorWindowElement >> label: aString [
	| text |
	text := BlTextElement new text: (aString asRopedText).
	text constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	^ text
]

{ #category : 'accessing' }
FlashEditorWindowElement >> liveEditor [
	^ liveEditor
]

{ #category : 'accessing' }
FlashEditorWindowElement >> printItButton [
	^ printItButton
]

{ #category : 'accessing' }
FlashEditorWindowElement >> titleBar [
	^ titleBar
]

{ #category : 'accessing' }
FlashEditorWindowElement >> toast [
	^ toast
]

{ #category : 'updating' }
FlashEditorWindowElement >> toastText: aString [
	toast text: (aString asRopedText)
]