Class {
	#name : 'FlashDemoPatternsTest',
	#superclass : 'TestCase',
	#category : 'Flash-Tests-Support',
	#package : 'Flash-Tests-Support'
}

{ #category : 'tests' }
FlashDemoPatternsTest >> testAcidPatternHasSixteenSteps [
	self assert: (FlashDemoPatterns defaultLanes at: #acid) gates size equals: 16
]

{ #category : 'tests' }
FlashDemoPatternsTest >> testHiHatPattern [
	self deny: (FlashDemoPatterns hiHatSteps at: 1).
	self assert: (FlashDemoPatterns hiHatSteps at: 3).
	self assert: (FlashDemoPatterns hiHatSteps at: 16)
]

{ #category : 'tests' }
FlashDemoPatternsTest >> testStepPitchesHasSixteenEntries [
	self assert: FlashDemoPatterns stepPitches size equals: 16
]