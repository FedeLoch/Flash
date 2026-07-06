Class {
	#name : #FlashColorShiftEffectTest,
	#superclass : #TestCase,
	#category : #'Flash-Tests-Effects'
}

{
	#category : #tests
}
FlashColorShiftEffectTest >> testApplyChangesTextColor
	| effect event |
	effect := FlashColorShiftEffect new color: Color cyan; intensity: 1.0.
	event := FlashMelodyEvent new velocity: 1.0; soundName: 'superpiano'; yourself.
	self assert: effect shiftColor isNotNil.
	self assert: (effect shiftColor isKindOf: Color)

{
	#category : #tests
}
FlashColorShiftEffectTest >> testOriginalColorIsRestoredAfterEffect
	| effect |
	effect := FlashColorShiftEffect new.
	effect originalColor: Color white.
	effect stop.
	self assert: effect restoreColor equals: Color white

{
	#category : #tests
}
FlashColorShiftEffectTest >> testShiftColorBlendsBetweenOriginalAndEffectColor
	| effect |
	effect := FlashColorShiftEffect new color: Color cyan; intensity: 0.5.
	effect originalColor: Color white.
	self assert: (effect shiftColor red closeTo: (Color white red + Color cyan red) / 2)
