Class {
	#name : 'FlashSynthPanelElement',
	#superclass : 'BlElement',
	#instVars : [
		'panel',
		'valueLabels'
	],
	#category : 'Flash-Workspace',
	#package : 'Flash-Workspace'
}

{ #category : 'building' }
FlashSynthPanelElement >> addButton: aLabel action: aBlock [
	| button |
	button := BlElement new.
	button extent: 24 @ 20.
	button background: (Color fromHexString: '#161B22').
	button geometry: BlRoundedRectangleGeometry new.
	button addChild: (self miniLabel: aLabel).
	button addEventHandler: (BlEventHandler on: BlClickEvent do: [ :evt | aBlock value ]).
	^ button
]

{ #category : 'building' }
FlashSynthPanelElement >> buildPanel [
	| container |
	self layout: BlLinearLayout vertical.
	self extent: 240 @ 120.
	self background: (Color fromHexString: '#0A0E14').
	self border: (BlBorder paint: (Color fromHexString: '#1D232B') width: 1).
	container := BlElement new.
	container layout: BlLinearLayout vertical.
	container constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	container addChild: (self rowLabel: 'SYNTH FX').
	valueLabels := Dictionary new.
	#(cutoff reso decay wet) do: [ :paramKey |
		| row label valueLabel minus plus |
		row := BlElement new.
		row layout: BlLinearLayout horizontal.
		row height: 20.
		label := self miniLabel: (paramKey asString asUppercase).
		valueLabel := self miniLabel: (self formatValue: (panel valueFor: paramKey) for: paramKey).
		valueLabels at: paramKey put: valueLabel.
		minus := self addButton: '<' action: [ panel valueFor: paramKey increment: (self stepFor: paramKey negated). self updateValueLabels ].
		plus := self addButton: '>' action: [ panel valueFor: paramKey increment: (self stepFor: paramKey). self updateValueLabels ].
		row addChildren: { label. valueLabel. minus. plus }.
		container addChild: row ].
	self addChild: container
]

{ #category : 'building' }
FlashSynthPanelElement >> formatValue: aNumber for: aSymbol [
	aSymbol = #cutoff ifTrue: [ ^ aNumber rounded printString , 'Hz' ].
	^ ((aNumber * 100) rounded / 100) printString
]

{ #category : 'initialization' }
FlashSynthPanelElement >> initialize [
	super initialize.
	panel := FlashSynthPanel new.
	valueLabels := Dictionary new.
	self buildPanel
]

{ #category : 'building' }
FlashSynthPanelElement >> miniLabel: aString [
	| text |
	text := BlTextElement new text: ((aString asRopedText) foreground: (Color fromHexString: '#C5CDD8')).
	text constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	^ text
]

{ #category : 'accessing' }
FlashSynthPanelElement >> panel [
	^ panel
]

{ #category : 'updating' }
FlashSynthPanelElement >> refresh [
	self updateValueLabels
]

{ #category : 'building' }
FlashSynthPanelElement >> rowLabel: aString [
	| text |
	text := BlTextElement new text: ((aString asRopedText) foreground: (Color fromHexString: '#C5CDD8')).
	text constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical exact: 14 ].
	^ text
]

{ #category : 'querying' }
FlashSynthPanelElement >> stepFor: aSymbol [
	aSymbol = #cutoff ifTrue: [ ^ 0.12 ].
	^ 0.1
]

{ #category : 'updating' }
FlashSynthPanelElement >> updateValueLabels [
	valueLabels keysAndValuesDo: [ :key :label |
		label text: (((self formatValue: (panel valueFor: key) for: key) asRopedText) foreground: (Color fromHexString: '#C5CDD8')) ]
]

{ #category : 'accessing' }
FlashSynthPanelElement >> valueLabels [
	^ valueLabels
]