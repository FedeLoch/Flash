Class {
	#name : #CoyFlashEffect,
	#superclass : #CoyVisualEffect,
	#category : #'CoypuLive-Effects'
}

{
	#category : #initialization
}
CoyFlashEffect >> initialize
	super initialize.
	duration := 200 milliSeconds

{
	#category : #api
}
CoyFlashEffect >> applyTo: aBlElement withEvent: aCoyMelodyEvent
	targetElement := aBlElement.
	self intensity: (aCoyMelodyEvent velocity ifNil: [ 0.5 ]).
	self buildAnimation.
	animation start

{
	#category : #animation
}
CoyFlashEffect >> buildAnimation
	| startColor endColor |
	startColor := self flashColor.
	endColor := Color transparent.
	animation := BlColorTransition new
		from: startColor;
		to: endColor;
		duration: duration;
		onStepDo: [ :c | targetElement background: c ];
		yourself

{
	#category : #color
}
CoyFlashEffect >> flashColor
	^ color alpha: intensity
