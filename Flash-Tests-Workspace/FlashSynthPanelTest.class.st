Class {
	#name : 'FlashSynthPanelTest',
	#superclass : 'TestCase',
	#category : 'Flash-Tests-Workspace',
	#package : 'Flash-Tests-Workspace'
}

{ #category : 'tests' }
FlashSynthPanelTest >> testClamping [
	| panel |
	panel := FlashSynthPanel new.
	panel cutoff: 5.
	self assert: panel cutoff equals: 20.0.
	panel reso: 3.
	self assert: panel reso equals: 1.0.
	panel wet: -1.
	self assert: panel wet equals: 0.0
]

{ #category : 'tests' }
FlashSynthPanelTest >> testDefaults [
	| panel |
	panel := FlashSynthPanel new.
	self assert: panel cutoff equals: 600.
	self assert: panel reso closeTo: 0.35 precision: 0.001.
	self assert: panel decay closeTo: 0.4 precision: 0.001.
	self assert: panel wet closeTo: 0.2 precision: 0.001
]

{ #category : 'tests' }
FlashSynthPanelTest >> testIncrements [
	| panel |
	panel := FlashSynthPanel new.
	panel valueFor: #cutoff increment: 0.12.
	self assert: panel cutoff closeTo: 672 precision: 0.001.
	panel valueFor: #wet increment: 0.1.
	self assert: panel wet closeTo: 0.3 precision: 0.001
]

{ #category : 'tests' }
FlashSynthPanelTest >> testPanelHasParameterLabels [
	| element |
	element := FlashSynthPanelElement new.
	self assert: element valueLabels size equals: 4.
	element updateValueLabels.
	self assert: (element valueLabels at: #cutoff) isNotNil
]

{ #category : 'tests' }
FlashSynthPanelTest >> testPanelValuesVisible [
	| element |
	element := FlashSynthPanelElement new.
	element panel cutoff: 1000.
	element updateValueLabels.
	self assert: (element valueLabels at: #cutoff) text asString equals: '1000Hz'
]