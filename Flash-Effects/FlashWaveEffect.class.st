Class {
	#name : 'FlashWaveEffect',
	#superclass : 'FlashVisualEffect',
	#category : 'Flash-Effects',
	#package : 'Flash-Effects'
}

{ #category : 'api' }
FlashWaveEffect >> applyTo: aBlElement withEvent: aFlashMelodyEvent [

	targetElement := aBlElement.
	self intensity: (aFlashMelodyEvent velocity ifNil: [ 0.5 ]).
	targetElement beInSeparateCompositionLayer.
	self buildAnimation.
	targetElement addAnimation: animation.
	animation start
]

{ #category : 'animation' }
FlashWaveEffect >> buildAnimation [

	| displacement offset |
	displacement := self displacement.
	offset := displacement @ 0.
	animation := BlSequentialAnimation new
		             add: ((BlTransformAnimation translate: offset)
				              duration: duration / 3;
				              yourself);
		             add: ((BlTransformAnimation translate: offset * -2)
				              duration: duration / 3;
				              yourself);
		             add: ((BlTransformAnimation translate: offset)
				              duration: duration / 3;
				              yourself);
		             yourself
]

{ #category : 'accessing' }
FlashWaveEffect >> displacement [
	^ (intensity * 8) asInteger max: 1
]

{ #category : 'initialization' }
FlashWaveEffect >> initialize [
	super initialize.
	duration := 400 milliSeconds.
	intensity := 0.5

]
