Class {
	#name : 'FlashParticleTest',
	#superclass : 'TestCase',
	#category : 'Flash-Tests-Particles',
	#package : 'Flash-Tests-Particles'
}

{ #category : 'tests' }
FlashParticleTest >> testAdvanceByMillisecondsIncrementsAge [
	| particle |
	particle := FlashParticle kind: #spark color: Color cyan position: 0 @ 0 lifetimeMs: 300.
	particle advanceByMilliseconds: 100.
	self assert: particle ageMs equals: 100.
	self assert: particle isExpired not
]

{ #category : 'tests' }
FlashParticleTest >> testIsExpiredAfterLifetime [
	| particle |
	particle := FlashParticle kind: #shockwave color: Color green position: 1 @ 1 lifetimeMs: 200.
	particle advanceByMilliseconds: 200.
	self assert: particle isExpired
]

{ #category : 'tests' }
FlashParticleTest >> testPhaseStaysInUnitRange [
	| particle |
	particle := FlashParticle kind: #shower color: Color magenta position: 0 @ 0 lifetimeMs: 100.
	particle advanceByMilliseconds: 500.
	self assert: particle phase equals: 1.0
]

{ #category : 'tests' }
FlashParticleTest >> testStepMovesByVelocity [
	| particle |
	particle := FlashParticle kind: #spark color: Color yellow position: 10 @ 20 lifetimeMs: 400.
	particle velocity: 2 @ -1.
	particle step: 5.
	self assert: particle position equals: (20 @ 15).
	self assert: particle ageMs equals: 5
]