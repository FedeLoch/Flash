Class {
	#name : 'FlashWaveEffectTest',
	#superclass : 'TestCase',
	#category : 'Flash-Tests-Effects',
	#package : 'Flash-Tests-Effects'
}

{ #category : 'tests' }
FlashWaveEffectTest >> testApplyCreatesSequentialAnimation [

	| effect target event |
	target := BlElement new extent: 200 @ 50.
	event := FlashMelodyEvent new
		         velocity: 0.7;
		         yourself.
	effect := FlashWaveEffect new
		          color: Color green;
		          intensity: 0.7.
	effect applyTo: target withEvent: event.
	self assert: effect animation isNotNil
]

{ #category : 'tests' }
FlashWaveEffectTest >> testWaveDisplacementProportionalToIntensity [
	| effectLow effectHigh |
	effectLow := FlashWaveEffect new intensity: 0.2.
	effectHigh := FlashWaveEffect new intensity: 1.0.
	self assert: effectHigh displacement > effectLow displacement
]
