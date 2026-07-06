Class {
	#name : #FlashVisualEffectTest,
	#superclass : #TestCase,
	#category : #'Flash-Tests-Effects'
}

{
	#category : #tests
}
FlashVisualEffectTest >> testDefaultDuration
	| effect |
	effect := FlashFlashEffect new.
	self assert: effect duration isNotNil.
	self assert: effect duration > 0 asDuration

{
	#category : #tests
}
FlashVisualEffectTest >> testSetIntensity
	| effect |
	effect := FlashFlashEffect new.
	effect intensity: 0.5.
	self assert: effect intensity equals: 0.5.
	effect intensity: 1.5.
	self assert: effect intensity equals: 1.0.
	effect intensity: -0.3.
	self assert: effect intensity equals: 0.0

{
	#category : #tests
}
FlashVisualEffectTest >> testStopMarksEffectAsFinished
	| effect |
	effect := FlashFlashEffect new.
	effect stop.
	self assert: effect isFinished

{
	#category : #tests
}
FlashVisualEffectTest >> testAllSubclassesRespondToApply
	FlashVisualEffect allSubclasses do: [ :cls |
		cls isAbstract ifFalse: [
			self assert: (cls canUnderstand: #applyTo:withEvent:) ] ]
