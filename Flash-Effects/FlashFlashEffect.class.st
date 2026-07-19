Class {
	#name : #FlashFlashEffect,
	#superclass : #FlashVisualEffect,
	#category : #'Flash-Effects'
}

{
	#category : #initialization
}
FlashFlashEffect >> initialize [
	super initialize.
	duration := 200 milliSeconds

]
{
	#category : #api
}
FlashFlashEffect >> applyTo: aBlElement withEvent: aFlashMelodyEvent [
	targetElement := aBlElement.
	self intensity: (aFlashMelodyEvent velocity ifNil: [ 0.5 ]).
	self buildAnimation.
	animation start

]
{
	#category : #animation
}
FlashFlashEffect >> buildAnimation [
	| startColor endColor |
	startColor := self flashColor.
	endColor := Color transparent.
	animation := BlColorTransition new
		from: startColor;
		to: endColor;
		duration: duration;
		onStepDo: [ :c | targetElement background: c ];
		yourself

]
{
	#category : #color
}
FlashFlashEffect >> flashColor [
	^ color alpha: intensity
]
