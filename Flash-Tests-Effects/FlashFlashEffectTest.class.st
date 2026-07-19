Class {
	#name : 'FlashFlashEffectTest',
	#superclass : 'TestCase',
	#category : 'Flash-Tests-Effects',
	#package : 'Flash-Tests-Effects'
}

{ #category : 'tests' }
FlashFlashEffectTest >> testApplyChangesBackgroundColor [

	| effect target event |
	target := BlElement new extent: 100 @ 100.
	event := FlashMelodyEvent new
		         velocity: 0.8;
		         yourself.
	effect := FlashFlashEffect new
		          color: Color green;
		          intensity: 0.8.
	effect applyTo: target withEvent: event.
	self assert: effect animation isNotNil
]

{ #category : 'tests' }
FlashFlashEffectTest >> testFlashColorDerivedFromEffectColor [
	| effect flashColor |
	effect := FlashFlashEffect new color: (Color fromHexString: '00FF41'); intensity: 0.6.
	flashColor := effect flashColor.
	self assert: (flashColor red closeTo: (Color fromHexString: '00FF41') red).
	self assert: (flashColor alpha closeTo: 0.6)

]

{ #category : 'tests' }
FlashFlashEffectTest >> testFlashDurationIsShort [
	| effect |
	effect := FlashFlashEffect new.
	self assert: effect duration <= 500 milliSeconds
]
