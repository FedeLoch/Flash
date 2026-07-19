Class {
	#name : 'FlashPulseEffect',
	#superclass : 'FlashVisualEffect',
	#category : 'Flash-Effects',
	#package : 'Flash-Effects'
}

{ #category : 'api' }
FlashPulseEffect >> applyTo: aBlElement withEvent: aFlashMelodyEvent [

	targetElement := aBlElement.
	self intensity: (aFlashMelodyEvent velocity ifNil: [ 0.5 ]).
	targetElement beInSeparateCompositionLayer.
	self buildAnimation.
	targetElement addAnimation: animation.
	animation start
]

{ #category : 'animation' }
FlashPulseEffect >> buildAnimation [

	animation := (BlTransformAnimation scale: self scaleFactor)
		             duration: duration;
		             yourself
]

{ #category : 'initialization' }
FlashPulseEffect >> initialize [
	super initialize.
	duration := 300 milliSeconds.
	intensity := 0.5

]

{ #category : 'accessing' }
FlashPulseEffect >> scaleFactor [
	^ 1.0 + (intensity * 0.1)
]
