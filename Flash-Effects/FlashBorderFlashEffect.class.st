Class {
	#name : 'FlashBorderFlashEffect',
	#superclass : 'FlashVisualEffect',
	#category : 'Flash-Effects',
	#package : 'Flash-Effects'
}

{ #category : 'api' }
FlashBorderFlashEffect >> applyTo: aBlElement withEvent: aFlashMelodyEvent [
	targetElement := aBlElement.
	self intensity: (aFlashMelodyEvent velocity ifNil: [ 0.5 ]).
	self buildAnimation.
	animation start

]

{ #category : 'accessing' }
FlashBorderFlashEffect >> borderWidth [
	^ (intensity * 4) asFloat max: 1.0
]

{ #category : 'animation' }
FlashBorderFlashEffect >> buildAnimation [
	| startBorder endBorder |
	startBorder := BlBorder builder
		width: self borderWidth;
		paint: (color alpha: intensity);
		build.
	endBorder := BlBorder empty.
	animation := BlColorTransition new
		from: (color alpha: intensity);
		to: Color transparent;
		duration: duration;
		onStepDo: [ :c |
			targetElement border: (BlBorder builder
				width: self borderWidth * c alpha;
				paint: (Color r: c red g: c green b: c blue alpha: c alpha * intensity);
				build) ];
		yourself

]

{ #category : 'initialization' }
FlashBorderFlashEffect >> initialize [
	super initialize.
	duration := 250 milliSeconds.
	intensity := 0.5

]
