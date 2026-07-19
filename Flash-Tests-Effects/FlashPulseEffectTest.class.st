Class {
	#name : 'FlashPulseEffectTest',
	#superclass : 'TestCase',
	#category : 'Flash-Tests-Effects',
	#package : 'Flash-Tests-Effects'
}

{ #category : 'tests' }
FlashPulseEffectTest >> testApplyCreatesTransformAnimation [

	| effect target event |
	target := BlElement new extent: 100 @ 100.
	event := FlashMelodyEvent new
		         velocity: 1.0;
		         yourself.
	effect := FlashPulseEffect new
		          color: Color orange;
		          intensity: 1.0.
	effect applyTo: target withEvent: event.
	self assert: effect animation isNotNil
]

{ #category : 'tests' }
FlashPulseEffectTest >> testPulseScaleFactorProportionalToIntensity [
	| effectLow effectHigh |
	effectLow := FlashPulseEffect new intensity: 0.2.
	effectHigh := FlashPulseEffect new intensity: 1.0.
	self assert: effectHigh scaleFactor > effectLow scaleFactor
]
