Class {
	#name : #CoyGlowEffect,
	#superclass : #CoyVisualEffect,
	#category : #'CoypuLive-Effects'
}

{
	#category : #initialization
}
CoyGlowEffect >> initialize
	super initialize.
	duration := 400 milliSeconds.
	intensity := 0.3

{
	#category : #api
}
CoyGlowEffect >> applyTo: aBlElement withEvent: aCoyMelodyEvent
	targetElement := aBlElement.
	self intensity: (aCoyMelodyEvent velocity ifNil: [ 0.3 ]).
	self buildAnimation.
	animation start

{
	#category : #animation
}
CoyGlowEffect >> buildAnimation
	| startBorder endBorder |
	startBorder := BlBorder builder
		width: (2 * intensity) asFloat;
		paint: (color alpha: intensity);
		build.
	endBorder := BlBorder empty.
	animation := BlColorTransition new
		duration: duration;
		onStepDo: [ :c |
			| currentColor |
			currentColor := Color r: c red g: c green b: c blue alpha: c alpha * intensity.
			targetElement border: (BlBorder builder width: 2; paint: currentColor; build) ];
		yourself

{
	#category : #color
}
CoyGlowEffect >> glowColor
	^ color alpha: intensity
