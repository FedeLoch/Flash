Class {
	#name : #FlashMelodyEventTest,
	#superclass : #TestCase,
	#category : #'Flash-Tests-Events'
}

{
	#category : #tests
}
FlashMelodyEventTest >> testCreationWithBasicProperties [
	| event |
	event := FlashMelodyEvent new
		sequencerKey: #kick;
		soundName: 'bd';
		noteValue: 60;
		velocity: 0.9;
		channel: 1;
		orbit: 0;
		yourself.
	self assert: event sequencerKey equals: #kick.
	self assert: event soundName equals: 'bd'.
	self assert: event noteValue equals: 60.
	self assert: event velocity equals: 0.9.
	self assert: event channel equals: 1.
	self assert: event orbit equals: 0

]
{
	#category : #tests
}
FlashMelodyEventTest >> testSoundCategoryForDrumSounds [
	| event |
	event := FlashMelodyEvent new soundName: 'bd'.
	self assert: event soundCategory equals: #drum.
	event soundName: 'sn'.
	self assert: event soundCategory equals: #drum.
	event soundName: 'hh'.
	self assert: event soundCategory equals: #drum.
	event soundName: 'cp'.
	self assert: event soundCategory equals: #drum

]
{
	#category : #tests
}
FlashMelodyEventTest >> testSoundCategoryForBassSounds [
	| event |
	event := FlashMelodyEvent new soundName: 'bass'.
	self assert: event soundCategory equals: #bass.
	event soundName: 'bass1'.
	self assert: event soundCategory equals: #bass

]
{
	#category : #tests
}
FlashMelodyEventTest >> testSoundCategoryForSynthSounds [
	| event |
	event := FlashMelodyEvent new soundName: 'superpiano'.
	self assert: event soundCategory equals: #lead.
	event soundName: 'supersquare'.
	self assert: event soundCategory equals: #lead

]
{
	#category : #tests
}
FlashMelodyEventTest >> testSoundCategoryDefaultsToSample [
	| event |
	event := FlashMelodyEvent new soundName: 'myCustomSound'.
	self assert: event soundCategory equals: #sample

]
{
	#category : #tests
}
FlashMelodyEventTest >> testIsPercussive [
	| event |
	event := FlashMelodyEvent new soundName: 'bd'.
	self assert: event isPercussive.
	event soundName: 'superpiano'.
	self deny: event isPercussive

]
{
	#category : #tests
}
FlashMelodyEventTest >> testNormalizedPitch [
	| event |
	event := FlashMelodyEvent new noteValue: 0.
	self assert: event normalizedPitch equals: 0.0.
	event noteValue: 127.
	self assert: (event normalizedPitch closeTo: 1.0).
	event noteValue: 60.
	self assert: (event normalizedPitch closeTo: 60/127)

]
{
	#category : #tests
}
FlashMelodyEventTest >> testHasEffect [
	| event |
	event := FlashMelodyEvent new extraParams: (Dictionary new at: #delay put: 0.5; yourself).
	self assert: (event hasEffect: #delay).
	self deny: (event hasEffect: #reverb)

]
{
	#category : #tests
}
FlashMelodyEventTest >> testFromSequencerFactory [
	| seq event |
	seq := SequencerMono new.
	seq seqKey: #testSeq.
	seq gates: #(1 0 1 0) asRhythm.
	seq notes: #(60 62 64 65).
	seq noteIndex: 0.
	seq dirtMessage: (Dictionary new at: 's' put: #('bd') asDirtArray; yourself).
	event := FlashMelodyEvent fromSequencer: seq at: 0.
	self assert: event sequencerKey equals: #testSeq.
	self assert: event noteValue equals: 60
]
{
	#category : #tests
}
FlashMelodyEventTest >> testFreqHzAndNoteName [
	| event |
	event := FlashMelodyEvent new noteValue: 60.
	self assert: (event freqHz closeTo: 261.63 precision: 0.02).
	self assert: event noteName equals: 'C4'.
	event noteValue: 51.
	self assert: event noteName equals: 'Eb3'
]
{
	#category : #tests
}
FlashMelodyEventTest >> testTriggerKind [
	| event |
	event := FlashMelodyEvent new
		soundName: 'bd';
		noteValue: 36;
		yourself.
	self assert: event triggerKind equals: #drum.
	event := FlashMelodyEvent new
		soundName: 'bass';
		noteValue: 36;
		yourself.
	self assert: event triggerKind equals: #bass.
	event := FlashMelodyEvent new
		soundName: 'superpiano';
		noteValue: 60;
		yourself.
	self assert: event triggerKind equals: #synth
]
