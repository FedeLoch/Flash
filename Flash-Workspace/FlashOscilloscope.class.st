Class {
	#name : 'FlashOscilloscope',
	#superclass : 'Object',
	#instVars : [
		'samples',
		'writeIndex'
	],
	#category : 'Flash-Workspace',
	#package : 'Flash-Workspace'
}

{ #category : 'querying' }
FlashOscilloscope >> clear [
	samples := Array new: samples size withAll: 0.0.
	writeIndex := 0
]

{ #category : 'initialization' }
FlashOscilloscope >> initialize [
	super initialize.
	samples := Array new: 64 withAll: 0.0.
	writeIndex := 0
]

{ #category : 'querying' }
FlashOscilloscope >> normalizedPeak [
	^ (samples collect: [ :each | each abs ]) max ifNil: [ 0.0 ]
]

{ #category : 'recording' }
FlashOscilloscope >> sample: aFloat [
	samples at: (writeIndex + 1) put: ((aFloat max: 0.0) min: 1.0).
	writeIndex := (writeIndex + 1) \\ samples size
]

{ #category : 'accessing' }
FlashOscilloscope >> samples [
	^ samples copy
]

{ #category : 'querying' }
FlashOscilloscope >> size [
	^ samples size
]