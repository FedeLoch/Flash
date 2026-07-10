Class {
	#name : #FlashGlowEffect,
	#superclass : #FlashVisualEffect,
	#category : #'Flash-Effects'
}

{
	#category : #initialization
}
FlashGlowEffect >> initialize [
	super initialize.
	duration := 400 milliSeconds.
	intensity := 0.3

]
{
	#category : #api
}
FlashGlowEffect >> applyTo: aBlElement withEvent: aFlashMelodyEvent [
	targetElement := aBlElement.
	self intensity: (aFlashMelodyEvent velocity ifNil: [ 0.3 ]).
	self buildAnimation.
	animation start

]
{
	#category : #animation
}
FlashGlowEffect >> buildAnimation [
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

]
{
	#category : #color
}
FlashGlowEffect >> glowColor [
	^ color alpha: intensity
]
