Class {
	#name : 'FlashOscilloscopeElement',
	#superclass : 'BlElement',
	#instVars : [
		'scope',
		'barElements'
	],
	#category : 'Flash-Workspace',
	#package : 'Flash-Workspace'
}

{ #category : 'building' }
FlashOscilloscopeElement >> buildBars [
	barElements := (1 to: 48) collect: [ :i |
		| bar |
		bar := BlElement new.
		bar constraintsDo: [ :c |
			c horizontal exact: 4.
			c vertical exact: 2 ].
		bar background: (Color fromHexString: '#00F2FF').
		bar ].
	self addChildren: barElements
]

{ #category : 'accessing' }
FlashOscilloscopeElement >> barElements [
	^ barElements
]

{ #category : 'initialization' }
FlashOscilloscopeElement >> initialize [
	super initialize.
	scope := FlashOscilloscope new.
	self layout: BlLinearLayout horizontal.
	self extent: 320 @ 60.
	self background: (Color fromHexString: '#0A0E14').
	self border: (BlBorder paint: (Color fromHexString: '#1D232B') width: 1).
	self buildBars.
	self refresh
]

{ #category : 'updating' }
FlashOscilloscopeElement >> refresh [
	| values max |
	values := scope samples.
	max := scope normalizedPeak.
	barElements doWithIndex: [ :bar :i |
		| v h |
		v := (values at: (i - 1 \\ values size) + 1) max: 0.0.
		h := v > 0
			ifTrue: [ (2 + (v * (self extent y - 8))) rounded ]
			ifFalse: [ 2 ].
		bar constraints vertical exact: (h max: 2).
		bar background: (max < 0.2
			ifTrue: [ Color fromHexString: '#60FF99' ]
			ifFalse: [ Color fromHexString: '#FF4A8D' ]) ].
	self requestLayout
]

{ #category : 'accesing' }
FlashOscilloscopeElement >> scope [
	^ scope
]

{ #category : 'updating' }
FlashOscilloscopeElement >> setSamples: anArray [
	anArray do: [ :v | scope sample: v ].
	self refresh
]