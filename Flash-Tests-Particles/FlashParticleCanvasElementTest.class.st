Class {
	#name : 'FlashParticleCanvasElementTest',
	#superclass : 'TestCase',
	#category : 'Flash-Tests-Particles',
	#package : 'Flash-Tests-Particles'
}

{ #category : 'helpers' }
FlashParticleCanvasElementTest >> testEvent [
	^ FlashMelodyEvent new
		noteValue: 60;
		velocity: 0.8;
		forceSoundCategory: #lead;
		yourself
]

{ #category : 'tests' }
FlashParticleCanvasElementTest >> testCanvasIsBlElement [
	self assert: (FlashParticleCanvasElement new isKindOf: BlElement)
]

{ #category : 'tests' }
FlashParticleCanvasElementTest >> testEngineIsReady [
	| canvas |
	canvas := FlashParticleCanvasElement new.
	self assert: canvas engine isNotNil
]

{ #category : 'tests' }
FlashParticleCanvasElementTest >> testLabelUpdatesAfterPulse [
	| canvas |
	canvas := FlashParticleCanvasElement new.
	canvas pulseFor: self testEvent.
	self assert: (canvas labelText text asString beginsWith: 'PARTICLES')
]

{ #category : 'tests' }
FlashParticleCanvasElementTest >> testPulseSpawnsVisual [
	| canvas |
	canvas := FlashParticleCanvasElement new.
	canvas pulseFor: self testEvent.
	self assert: canvas visualsPane children size >= 1.
	canvas pulseFor: self testEvent.
	self assert: canvas visualsPane children size >= 2
]

{ #category : 'tests' }
FlashParticleCanvasElementTest >> testResetClearsVisuals [
	| canvas |
	canvas := FlashParticleCanvasElement new.
	canvas pulseFor: self testEvent.
	canvas panic.
	self assert: canvas engine size equals: 0.
	self assert: canvas children size >= 1
]