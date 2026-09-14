Class {
	#name : 'FlashSynthPanel',
	#superclass : 'Object',
	#instVars : [
		'cutoff',
		'reso',
		'decay',
		'wet'
	],
	#category : 'Flash-Workspace',
	#package : 'Flash-Workspace'
}

{ #category : 'accessing' }
FlashSynthPanel >> cutoff [
	^ cutoff
]

{ #category : 'accessing' }
FlashSynthPanel >> cutoff: aNumber [
	cutoff := (aNumber max: 20.0) min: 20000.0
]

{ #category : 'accessing' }
FlashSynthPanel >> decay [
	^ decay
]

{ #category : 'accessing' }
FlashSynthPanel >> decay: aNumber [
	decay := (aNumber max: 0.0) min: 2.0
]

{ #category : 'initialization' }
FlashSynthPanel >> initialize [
	super initialize.
	cutoff := 600.
	reso := 0.35.
	decay := 0.4.
	wet := 0.2
]

{ #category : 'accessing' }
FlashSynthPanel >> reso [
	^ reso
]

{ #category : 'accessing' }
FlashSynthPanel >> reso: aNumber [
	reso := (aNumber max: 0.0) min: 1.0
]

{ #category : 'querying' }
FlashSynthPanel >> valueFor: aSymbol [
	aSymbol = #cutoff ifTrue: [ ^ cutoff ].
	aSymbol = #reso ifTrue: [ ^ reso ].
	aSymbol = #decay ifTrue: [ ^ decay ].
	aSymbol = #wet ifTrue: [ ^ wet ].
	^ 0
]

{ #category : 'updating' }
FlashSynthPanel >> valueFor: aSymbol increment: aDelta [
	aSymbol = #cutoff ifTrue: [ self cutoff: cutoff * (1 + aDelta) ].
	aSymbol = #reso ifTrue: [ self reso: reso + aDelta ].
	aSymbol = #decay ifTrue: [ self decay: decay + aDelta ].
	aSymbol = #wet ifTrue: [ self wet: wet + aDelta ]
]

{ #category : 'accessing' }
FlashSynthPanel >> wet [
	^ wet
]

{ #category : 'accessing' }
FlashSynthPanel >> wet: aNumber [
	wet := (aNumber max: 0.0) min: 1.0
]