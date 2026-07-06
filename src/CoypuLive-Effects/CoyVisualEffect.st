Class {
	#name : #CoyVisualEffect,
	#superclass : #Object,
	#instVars : [
		'duration',
		'intensity',
		'color',
		'targetElement',
		'animation'
	],
	#category : #'CoypuLive-Effects'
}

{
	#category : #initialization
}
CoyVisualEffect >> initialize
	super initialize.
	duration := 200 milliSeconds.
	intensity := 0.5.
	color := Color green.

{
	#category : #accessing
}
CoyVisualEffect >> duration
	^ duration

{
	#category : #accessing
}
CoyVisualEffect >> duration: aDuration
	duration := aDuration

{
	#category : #accessing
}
CoyVisualEffect >> intensity
	^ intensity

{
	#category : #accessing
}
CoyVisualEffect >> intensity: aFloat
	intensity := (aFloat max: 0.0) min: 1.0

{
	#category : #accessing
}
CoyVisualEffect >> color
	^ color

{
	#category : #accessing
}
CoyVisualEffect >> color: aColor
	color := aColor

{
	#category : #accessing
}
CoyVisualEffect >> targetElement
	^ targetElement

{
	#category : #accessing
}
CoyVisualEffect >> animation
	^ animation

{
	#category : #api
}
CoyVisualEffect >> applyTo: aBlElement withEvent: aCoyMelodyEvent
	self subclassResponsibility

{
	#category : #api
}
CoyVisualEffect >> stop
	animation ifNotNil: [
		animation stop.
		animation := nil ]

{
	#category : #testing
}
CoyVisualEffect >> isFinished
	^ animation isNil or: [ animation isFinished ]
