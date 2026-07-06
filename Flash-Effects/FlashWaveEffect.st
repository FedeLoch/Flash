Class {
	#name : #FlashWaveEffect,
	#superclass : #FlashVisualEffect,
	#category : #'Flash-Effects'
}

{
	#category : #initialization
}
FlashWaveEffect >> initialize
	super initialize.
	duration := 400 milliSeconds.
	intensity := 0.5

{
	#category : #api
}
FlashWaveEffect >> applyTo: aBlElement withEvent: aFlashMelodyEvent
	targetElement := aBlElement.
	self intensity: (aFlashMelodyEvent velocity ifNil: [ 0.5 ]).
	targetElement beInSeparateCompositionLayer.
	self buildAnimation.
	animation start

{
	#category : #animation
}
FlashWaveEffect >> buildAnimation
	| displacement |
	displacement := self displacement.
	animation := BlSequentialAnimation new
		add: (BlTransformAnimation new
			from: (BlTransformationBuilder new translateBy: 0 @ 0; build);
			to: (BlTransformationBuilder new translateBy: displacement @ 0; build);
			duration: duration / 3);
		add: (BlTransformAnimation new
			from: (BlTransformationBuilder new translateBy: displacement @ 0; build);
			to: (BlTransformationBuilder new translateBy: (displacement negated) @ 0; build);
			duration: duration / 3);
		add: (BlTransformAnimation new
			from: (BlTransformationBuilder new translateBy: (displacement negated) @ 0; build);
			to: (BlTransformationBuilder new translateBy: 0 @ 0; build);
			duration: duration / 3);
		yourself

{
	#category : #accessing
}
FlashWaveEffect >> displacement
	^ (intensity * 8) asInteger max: 1
