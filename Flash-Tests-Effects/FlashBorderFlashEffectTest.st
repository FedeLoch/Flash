Class {
	#name : #FlashBorderFlashEffectTest,
	#superclass : #TestCase,
	#category : #'Flash-Tests-Effects'
}

{
	#category : #tests
}
FlashBorderFlashEffectTest >> testApplySetsBorderOnTarget [
	| effect target event |
	target := BlElement new size: 200@200.
	event := FlashMelodyEvent new velocity: 0.6; yourself.
	effect := FlashBorderFlashEffect new color: Color white; intensity: 0.6.
	effect applyTo: target withEvent: event.
	self assert: effect animation isNotNil

]
{
	#category : #tests
}
FlashBorderFlashEffectTest >> testBorderWidthProportionalToIntensity [
	| effectLow effectHigh |
	effectLow := FlashBorderFlashEffect new intensity: 0.2.
	effectHigh := FlashBorderFlashEffect new intensity: 1.0.
	self assert: effectHigh borderWidth > effectLow borderWidth
]
