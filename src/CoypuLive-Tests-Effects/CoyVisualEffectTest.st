Class {
	#name : #CoyVisualEffectTest,
	#superclass : #TestCase,
	#category : #'CoypuLive-Tests-Effects'
}

{
	#category : #tests
}
CoyVisualEffectTest >> testDefaultDuration
	| effect |
	effect := CoyFlashEffect new.
	self assert: effect duration isNotNil.
	self assert: effect duration > 0 asDuration

{
	#category : #tests
}
CoyVisualEffectTest >> testSetIntensity
	| effect |
	effect := CoyFlashEffect new.
	effect intensity: 0.5.
	self assert: effect intensity equals: 0.5.
	effect intensity: 1.5.
	self assert: effect intensity equals: 1.0.
	effect intensity: -0.3.
	self assert: effect intensity equals: 0.0

{
	#category : #tests
}
CoyVisualEffectTest >> testStopMarksEffectAsFinished
	| effect |
	effect := CoyFlashEffect new.
	effect stop.
	self assert: effect isFinished

{
	#category : #tests
}
CoyVisualEffectTest >> testAllSubclassesRespondToApply
	CoyVisualEffect allSubclasses do: [ :cls |
		cls isAbstract ifFalse: [
			self assert: (cls canUnderstand: #applyTo:withEvent:) ] ]
