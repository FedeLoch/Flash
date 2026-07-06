Class {
	#name : #CoyColorShiftEffect,
	#superclass : #CoyVisualEffect,
	#instVars : [
		'originalColor'
	],
	#category : #'CoypuLive-Effects'
}

{
	#category : #initialization
}
CoyColorShiftEffect >> initialize
	super initialize.
	duration := 300 milliSeconds.
	color := Color cyan.
	originalColor := Color white

{
	#category : #accessing
}
CoyColorShiftEffect >> originalColor
	^ originalColor

{
	#category : #accessing
}
CoyColorShiftEffect >> originalColor: aColor
	originalColor := aColor

{
	#category : #accessing
}
CoyColorShiftEffect >> shiftColor
	^ Color
		r: (originalColor red + ((color red - originalColor red) * intensity))
		g: (originalColor green + ((color green - originalColor green) * intensity))
		b: (originalColor blue + ((color blue - originalColor blue) * intensity))
		alpha: 1.0

{
	#category : #accessing
}
CoyColorShiftEffect >> restoreColor
	^ originalColor

{
	#category : #api
}
CoyColorShiftEffect >> applyTo: aBlElement withEvent: aCoyMelodyEvent
	targetElement := aBlElement.
	self intensity: (aCoyMelodyEvent velocity ifNil: [ 0.5 ]).
	self buildAnimation.
	animation start

{
	#category : #animation
}
CoyColorShiftEffect >> buildAnimation
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

{
	#category : #api
}
CoyColorShiftEffect >> stop
	super stop.
	targetElement ifNotNil: [ targetElement background: originalColor ]
