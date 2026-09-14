Class {
	#name : 'FlashOscilloscopeTest',
	#superclass : 'TestCase',
	#category : 'Flash-Tests-Workspace',
	#package : 'Flash-Tests-Workspace'
}

{ #category : 'tests' }
FlashOscilloscopeTest >> testModelClampsSamples [
	| scope |
	scope := FlashOscilloscope new.
	scope sample: 5.0.
	scope sample: -1.0.
	scope sample: 0.5.
	self assert: (scope samples includes: 1.0).
	self assert: (scope samples includes: 0.0).
	self assert: (scope samples includes: 0.5)
]

{ #category : 'tests' }
FlashOscilloscopeTest >> testModelNormalizedPeak [
	| scope |
	scope := FlashOscilloscope new.
	scope sample: 0.2.
	scope sample: 0.8.
	self assert: scope normalizedPeak closeTo: 0.8 precision: 0.001
]

{ #category : 'tests' }
FlashOscilloscopeTest >> testModelWrapsBuffer [
	| scope |
	scope := FlashOscilloscope new.
	200 timesRepeat: [ scope sample: 0.1 ].
	self assert: scope size equals: 64
]

{ #category : 'tests' }
FlashOscilloscopeTest >> testElementHasBars [
	| element |
	element := FlashOscilloscopeElement new.
	self assert: element barElements size equals: 48
]

{ #category : 'tests' }
FlashOscilloscopeTest >> testElementRefreshDoesNotError [
	| element |
	element := FlashOscilloscopeElement new.
	element scope sample: 0.7.
	element refresh.
	self assert: element scope normalizedPeak closeTo: 0.7 precision: 0.001
]