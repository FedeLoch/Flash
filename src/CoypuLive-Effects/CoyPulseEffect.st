Class {
	#name : #CoyPulseEffect,
	#superclass : #CoyVisualEffect,
	#category : #'CoypuLive-Effects'
}

{
	#category : #initialization
}
CoyPulseEffect >> initialize
	super initialize.
	duration := 300 milliSeconds.
	intensity := 0.5

{
	#category : #api
}
CoyPulseEffect >> applyTo: aBlElement withEvent: aCoyMelodyEvent
	targetElement := aBlElement.
	self intensity: (aCoyMelodyEvent velocity ifNil: [ 0.5 ]).
	targetElement beInSeparateCompositionLayer.
	self buildAnimation.
	animation start

{
	#category : #animation
}
CoyPulseEffect >> buildAnimation
	| scaleFrom scaleTo |
	scaleFrom := 1.0.
	scaleTo := self scaleFactor.
	animation := BlTransformAnimation new
		from: (BlTransformationBuilder new scaleBy: scaleFrom; build);
		to: (BlTransformationBuilder new scaleBy: scaleTo; build);
		duration: duration;
		yourself

{
	#category : #accessing
}
CoyPulseEffect >> scaleFactor
	^ 1.0 + (intensity * 0.1)
