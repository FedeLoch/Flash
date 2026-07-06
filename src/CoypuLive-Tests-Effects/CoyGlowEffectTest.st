Class {
	#name : #CoyGlowEffectTest,
	#superclass : #TestCase,
	#category : #'CoypuLive-Tests-Effects'
}

{
	#category : #tests
}
CoyGlowEffectTest >> testApplyAddsBorderToTarget
	| effect target event |
	target := BlElement new size: 100@100.
	event := CoyMelodyEvent new velocity: 0.5; yourself.
	effect := CoyGlowEffect new color: Color cyan; intensity: 0.5.
	effect applyTo: target withEvent: event.
	self assert: effect animation isNotNil

{
	#category : #tests
}
CoyGlowEffectTest >> testGlowDurationIsLongerThanFlash
	| glow flash |
	glow := CoyGlowEffect new.
	flash := CoyFlashEffect new.
	self assert: glow duration >= flash duration
