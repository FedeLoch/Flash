Class {
	#name : #CoyWaveEffectTest,
	#superclass : #TestCase,
	#category : #'CoypuLive-Tests-Effects'
}

{
	#category : #tests
}
CoyWaveEffectTest >> testApplyCreatesSequentialAnimation
	| effect target event |
	target := BlElement new size: 200@50.
	event := CoyMelodyEvent new velocity: 0.7; yourself.
	effect := CoyWaveEffect new color: Color green; intensity: 0.7.
	effect applyTo: target withEvent: event.
	self assert: effect animation isNotNil

{
	#category : #tests
}
CoyWaveEffectTest >> testWaveDisplacementProportionalToIntensity
	| effectLow effectHigh |
	effectLow := CoyWaveEffect new intensity: 0.2.
	effectHigh := CoyWaveEffect new intensity: 1.0.
	self assert: effectHigh displacement > effectLow displacement
