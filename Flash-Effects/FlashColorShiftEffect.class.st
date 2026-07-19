Class {
	#name : #FlashColorShiftEffect,
	#superclass : #FlashVisualEffect,
	#instVars : [
		'originalColor'
	],
	#category : #'Flash-Effects'
}

{
	#category : #initialization
}
FlashColorShiftEffect >> initialize [
	super initialize.
	duration := 300 milliSeconds.
	color := Color cyan.
	originalColor := Color white

]
{
	#category : #accessing
}
FlashColorShiftEffect >> originalColor [
	^ originalColor

]
{
	#category : #accessing
}
FlashColorShiftEffect >> originalColor: aColor [
	originalColor := aColor

]
{
	#category : #accessing
}
FlashColorShiftEffect >> shiftColor [
	^ Color
		r: (originalColor red + ((color red - originalColor red) * intensity))
		g: (originalColor green + ((color green - originalColor green) * intensity))
		b: (originalColor blue + ((color blue - originalColor blue) * intensity))
		alpha: 1.0

]
{
	#category : #accessing
}
FlashColorShiftEffect >> restoreColor [
	^ originalColor

]
{
	#category : #api
}
FlashColorShiftEffect >> applyTo: aBlElement withEvent: aFlashMelodyEvent [
	targetElement := aBlElement.
	self intensity: (aFlashMelodyEvent velocity ifNil: [ 0.5 ]).
	self buildAnimation.
	animation start

]
{
	#category : #animation
}
FlashColorShiftEffect >> buildAnimation [
	| shift |
	shift := self shiftColor.
	animation := BlColorTransition new
		from: shift;
		to: originalColor;
		duration: duration;
		onStepDo: [ :c |
			targetElement ifNotNil: [
				targetElement background: c ] ];
		yourself

]
{
	#category : #api
}
FlashColorShiftEffect >> stop [
	super stop.
	targetElement ifNotNil: [ targetElement background: originalColor ]
]
