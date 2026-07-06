Class {
	#name : #CoyBorderFlashEffectTest,
	#superclass : #TestCase,
	#category : #'CoypuLive-Tests-Effects'
}

{
	#category : #tests
}
CoyBorderFlashEffectTest >> testApplySetsBorderOnTarget
	| effect target event |
	target := BlElement new size: 200@200.
	event := CoyMelodyEvent new velocity: 0.6; yourself.
	effect := CoyBorderFlashEffect new color: Color white; intensity: 0.6.
	effect applyTo: target withEvent: event.
	self assert: effect animation isNotNil

{
	#category : #tests
}
CoyBorderFlashEffectTest >> testBorderWidthProportionalToIntensity
	| effectLow effectHigh |
	effectLow := CoyBorderFlashEffect new intensity: 0.2.
	effectHigh := CoyBorderFlashEffect new intensity: 1.0.
	self assert: effectHigh borderWidth > effectLow borderWidth
