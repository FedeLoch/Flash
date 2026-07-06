Class {
	#name : #CoyPulseEffectTest,
	#superclass : #TestCase,
	#category : #'CoypuLive-Tests-Effects'
}

{
	#category : #tests
}
CoyPulseEffectTest >> testApplyCreatesTransformAnimation
	| effect target event |
	target := BlElement new size: 100@100.
	event := CoyMelodyEvent new velocity: 1.0; yourself.
	effect := CoyPulseEffect new color: Color amber; intensity: 1.0.
	effect applyTo: target withEvent: event.
	self assert: effect animation isNotNil

{
	#category : #tests
}
CoyPulseEffectTest >> testPulseScaleFactorProportionalToIntensity
	| effectLow effectHigh |
	effectLow := CoyPulseEffect new intensity: 0.2.
	effectHigh := CoyPulseEffect new intensity: 1.0.
	self assert: effectHigh scaleFactor > effectLow scaleFactor
