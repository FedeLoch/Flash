Class {
	#name : #CoyBorderFlashEffect,
	#superclass : #CoyVisualEffect,
	#category : #'CoypuLive-Effects'
}

{
	#category : #initialization
}
CoyBorderFlashEffect >> initialize
	super initialize.
	duration := 250 milliSeconds.
	intensity := 0.5

{
	#category : #api
}
CoyBorderFlashEffect >> applyTo: aBlElement withEvent: aCoyMelodyEvent
	targetElement := aBlElement.
	self intensity: (aCoyMelodyEvent velocity ifNil: [ 0.5 ]).
	self buildAnimation.
	animation start

{
	#category : #animation
}
CoyBorderFlashEffect >> buildAnimation
	| startBorder endBorder |
	startBorder := BlBorder builder
		width: self borderWidth;
		paint: (color alpha: intensity);
		build.
	endBorder := BlBorder empty.
	animation := BlColorTransition new
		duration: duration;
		onStepDo: [ :c |
			targetElement border: (BlBorder builder
				width: self borderWidth * c alpha;
				paint: (Color r: c red g: c green b: c blue alpha: c alpha * intensity);
				build) ];
		yourself

{
	#category : #accessing
}
CoyBorderFlashEffect >> borderWidth
	^ (intensity * 4) asFloat max: 1.0
