Class {
	#name : 'FlashGlowEffectTest',
	#superclass : 'TestCase',
	#category : 'Flash-Tests-Effects',
	#package : 'Flash-Tests-Effects'
}

{ #category : 'tests' }
FlashGlowEffectTest >> testApplyAddsBorderToTarget [

	| effect target event |
	target := BlElement new extent: 100 @ 100.
	event := FlashMelodyEvent new
		         velocity: 0.5;
		         yourself.
	effect := FlashGlowEffect new
		          color: Color cyan;
		          intensity: 0.5.
	effect applyTo: target withEvent: event.
	self assert: effect animation isNotNil
]

{ #category : 'tests' }
FlashGlowEffectTest >> testGlowDurationIsLongerThanFlash [
	| glow flash |
	glow := FlashGlowEffect new.
	flash := FlashFlashEffect new.
	self assert: glow duration >= flash duration
]
