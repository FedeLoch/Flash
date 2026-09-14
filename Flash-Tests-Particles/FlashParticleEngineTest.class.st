Class {
	#name : 'FlashParticleEngineTest',
	#superclass : 'TestCase',
	#category : 'Flash-Tests-Particles',
	#package : 'Flash-Tests-Particles'
}

{ #category : 'helpers' }
FlashParticleEngineTest >> drumEvent [
	^ FlashMelodyEvent new
		noteValue: 36;
		velocity: 0.9;
		forceSoundCategory: #drum;
		yourself
]

{ #category : 'helpers' }
FlashParticleEngineTest >> bassEvent [
	^ FlashMelodyEvent new
		noteValue: 45;
		velocity: 0.7;
		forceSoundCategory: #bass;
		yourself
]

{ #category : 'helpers' }
FlashParticleEngineTest >> leadEvent [
	^ FlashMelodyEvent new
		noteValue: 60;
		velocity: 0.6;
		forceSoundCategory: #lead;
		yourself
]

{ #category : 'tests' }
FlashParticleEngineTest >> testDrumEventSpawnsShockwave [
	| engine |
	engine := FlashParticleEngine new.
	engine spawnForEvent: self drumEvent at: 700 @ 160.
	self assert: engine size equals: 16.
	self assert: (engine activeParticles allSatisfy: [ :p | p kind = #shockwave ])
]

{ #category : 'tests' }
FlashParticleEngineTest >> testDefaultSpawnPoint [
	| engine |
	engine := FlashParticleEngine new.
	engine spawnForEvent: self drumEvent.
	self assert: engine size equals: 16
]

{ #category : 'tests' }
FlashParticleEngineTest >> testLeadEventSpawnsShower [
	| engine |
	engine := FlashParticleEngine new.
	engine spawnForEvent: self leadEvent.
	self assert: engine size equals: 20.
	self assert: (engine activeParticles allSatisfy: [ :p | p kind = #shower ])
]

{ #category : 'tests' }
FlashParticleEngineTest >> testMaxParticlesIsEnforced [
	| engine |
	engine := FlashParticleEngine new.
	20 timesRepeat: [ engine spawnForEvent: self leadEvent ].
	self assert: engine size <= engine maxParticles
]

{ #category : 'tests' }
FlashParticleEngineTest >> testBassEventSpawnsSparks [
	| engine |
	engine := FlashParticleEngine new.
	engine spawnForEvent: self bassEvent.
	self assert: engine size equals: 14.
	self assert: (engine activeParticles allSatisfy: [ :p | p kind = #spark ])
]

{ #category : 'tests' }
FlashParticleEngineTest >> testStepByMillisecondsRemovesExpired [
	| engine |
	engine := FlashParticleEngine new.
	engine spawnForEvent: self drumEvent at: 0 @ 0.
	engine stepByMilliseconds: 5000.
	self assert: engine size equals: 0
]