Class {
	#name : #CoyWaveEffect,
	#superclass : #CoyVisualEffect,
	#category : #'CoypuLive-Effects'
}

{
	#category : #initialization
}
CoyWaveEffect >> initialize
	super initialize.
	duration := 400 milliSeconds.
	intensity := 0.5

{
	#category : #api
}
CoyWaveEffect >> applyTo: aBlElement withEvent: aCoyMelodyEvent
	targetElement := aBlElement.
	self intensity: (aCoyMelodyEvent velocity ifNil: [ 0.5 ]).
	targetElement beInSeparateCompositionLayer.
	self buildAnimation.
	animation start

{
	#category : #animation
}
CoyWaveEffect >> buildAnimation
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
CoyWaveEffect >> displacement
	^ (intensity * 8) asInteger max: 1
