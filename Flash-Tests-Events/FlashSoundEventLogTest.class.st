Class {
	#name : #FlashSoundEventLogTest,
	#superclass : #TestCase,
	#category : #'Flash-Tests-Events'
}

{
	#category : #helpers
}
FlashSoundEventLogTest >> newEvent [
	^ FlashMelodyEvent new
		noteValue: 60;
		soundName: 'superpiano';
		timestamp: (DateAndTime year: 2026 month: 9 day: 14 hour: 12 minute: 30 second: 5);
		yourself
]

{
	#category : #tests
}
FlashSoundEventLogTest >> testAddFormatsRow [
	| log |
	log := FlashSoundEventLog new.
	log add: self newEvent.
	self assert: log size equals: 1.
	self assert: (log entries first beginsWith: '[12:30:05.000]')
]

{
	#category : #tests
}
FlashSoundEventLogTest >> testClear [
	| log |
	log := FlashSoundEventLog new.
	log add: self newEvent.
	log clear.
	self assert: log isEmpty
]

{
	#category : #tests
}
FlashSoundEventLogTest >> testRingBufferBounds [
	| log |
	log := FlashSoundEventLog new.
	log maxEntries: 5.
	8 timesRepeat: [ log add: self newEvent ].
	self assert: log size equals: 5
]