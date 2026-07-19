Class {
	#name : #FlashPulseEffect,
	#superclass : #FlashVisualEffect,
	#category : #'Flash-Effects'
}

{
	#category : #initialization
}
FlashPulseEffect >> initialize [
	super initialize.
	duration := 300 milliSeconds.
	intensity := 0.5

]
{
	#category : #api
}
FlashPulseEffect >> applyTo: aBlElement withEvent: aFlashMelodyEvent [
	targetElement := aBlElement.
	self intensity: (aFlashMelodyEvent velocity ifNil: [ 0.5 ]).
	targetElement beInSeparateCompositionLayer.
	self buildAnimation.
	animation start

]
{
	#category : #animation
}
FlashPulseEffect >> buildAnimation [
	| scaleFrom scaleTo |
	scaleFrom := 1.0.
	scaleTo := self scaleFactor.
	animation := BlTransformAnimation new
		from: (BlTransformationBuilder new scaleBy: scaleFrom; build);
		to: (BlTransformationBuilder new scaleBy: scaleTo; build);
		duration: duration;
		yourself

]
{
	#category : #accessing
}
FlashPulseEffect >> scaleFactor [
	^ 1.0 + (intensity * 0.1)
]
