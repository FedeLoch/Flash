Class {
	#name : #CoyFlashEffectTest,
	#superclass : #TestCase,
	#category : #'CoypuLive-Tests-Effects'
}

{
	#category : #tests
}
CoyFlashEffectTest >> testApplyChangesBackgroundColor
	| effect target event |
	target := BlElement new size: 100@100.
	event := CoyMelodyEvent new velocity: 0.8; yourself.
	effect := CoyFlashEffect new color: Color green; intensity: 0.8.
	effect applyTo: target withEvent: event.
	self assert: effect animation isNotNil

{
	#category : #tests
}
CoyFlashEffectTest >> testFlashColorDerivedFromEffectColor
	| effect flashColor |
	effect := CoyFlashEffect new color: (Color fromHexString: '00FF41'); intensity: 0.6.
	flashColor := effect flashColor.
	self assert: (flashColor red closeTo: (Color fromHexString: '00FF41') red).
	self assert: (flashColor alpha closeTo: 0.6)

{
	#category : #tests
}
CoyFlashEffectTest >> testFlashDurationIsShort
	| effect |
	effect := CoyFlashEffect new.
	self assert: effect duration <= 500 milliSeconds
