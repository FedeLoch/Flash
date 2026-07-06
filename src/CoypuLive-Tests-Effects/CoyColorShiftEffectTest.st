Class {
	#name : #CoyColorShiftEffectTest,
	#superclass : #TestCase,
	#category : #'CoypuLive-Tests-Effects'
}

{
	#category : #tests
}
CoyColorShiftEffectTest >> testApplyChangesTextColor
	| effect event |
	effect := CoyColorShiftEffect new color: Color cyan; intensity: 1.0.
	event := CoyMelodyEvent new velocity: 1.0; soundName: 'superpiano'; yourself.
	self assert: effect shiftColor isNotNil.
	self assert: (effect shiftColor isKindOf: Color)

{
	#category : #tests
}
CoyColorShiftEffectTest >> testOriginalColorIsRestoredAfterEffect
	| effect |
	effect := CoyColorShiftEffect new.
	effect originalColor: Color white.
	effect stop.
	self assert: effect restoreColor equals: Color white

{
	#category : #tests
}
CoyColorShiftEffectTest >> testShiftColorBlendsBetweenOriginalAndEffectColor
	| effect |
	effect := CoyColorShiftEffect new color: Color cyan; intensity: 0.5.
	effect originalColor: Color white.
	self assert: (effect shiftColor red closeTo: (Color white red + Color cyan red) / 2)
