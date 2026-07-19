Class {
	#name : 'FlashVisualEffect',
	#superclass : 'Object',
	#instVars : [
		'duration',
		'intensity',
		'color',
		'targetElement',
		'animation'
	],
	#category : 'Flash-Effects',
	#package : 'Flash-Effects'
}

{ #category : 'accessing' }
FlashVisualEffect >> animation [
	^ animation

]

{ #category : 'api' }
FlashVisualEffect >> applyTo: aBlElement withEvent: aFlashMelodyEvent [
	self subclassResponsibility

]

{ #category : 'testing' }
FlashVisualEffect >> beFinished [
	animation := nil
]

{ #category : 'accessing' }
FlashVisualEffect >> color [
	^ color

]

{ #category : 'accessing' }
FlashVisualEffect >> color: aColor [
	color := aColor

]

{ #category : 'accessing' }
FlashVisualEffect >> duration [
	^ duration

]

{ #category : 'accessing' }
FlashVisualEffect >> duration: aDuration [
	duration := aDuration

]

{ #category : 'initialization' }
FlashVisualEffect >> initialize [
	super initialize.
	duration := 200 milliSeconds.
	intensity := 0.5.
	color := Color green.

]

{ #category : 'accessing' }
FlashVisualEffect >> intensity [
	^ intensity

]

{ #category : 'accessing' }
FlashVisualEffect >> intensity: aFloat [
	intensity := (aFloat max: 0.0) min: 1.0

]

{ #category : 'testing' }
FlashVisualEffect >> isFinished [

	^ animation isNil or: [ animation isComplete ]
]

{ #category : 'api' }
FlashVisualEffect >> stop [
	animation ifNotNil: [
		animation stop.
		animation := nil ]

]

{ #category : 'accessing' }
FlashVisualEffect >> targetElement [
	^ targetElement

]
