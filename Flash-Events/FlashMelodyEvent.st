Class {
	#name : #FlashMelodyEvent,
	#superclass : #Announcement,
	#instVars : [
		'sequencerKey',
		'soundName',
		'noteValue',
		'velocity',
		'channel',
		'orbit',
		'duration',
		'gateValue',
		'extraParams',
		'timestamp',
		'performer'
	],
	#category : #'Flash-Events'
}

{
	#category : #'instance creation'
}
FlashMelodyEvent class >> fromSequencer: aSequencer at: anIndex [
	^ self new
		sequencerKey: aSequencer seqKey;
		noteValue: (aSequencer notes at: (anIndex min: aSequencer notes size) max: 1);
		velocity: (aSequencer velocity ifNotNil: [ :v | v ] ifNil: [ 0.8 ]);
		gateValue: (aSequencer gates at: (anIndex min: aSequencer gates size) max: 1);
		soundName: (self extractSoundNameFrom: aSequencer);
		extraParams: (aSequencer dirtMessage ifNil: [ Dictionary new ] ifNotNil: [ aSequencer dirtMessage ]);
		timestamp: DateAndTime now;
		yourself

]
{
	#category : #'private utilities'
}
FlashMelodyEvent class >> extractSoundNameFrom: aSequencer [
	| message |
	message := aSequencer dirtMessage.
	message ifNil: [ ^ 'unknown' ].
	^ (message at: 's' ifAbsent: [
		message at: #s ifAbsent: [ ^ 'unknown' ] ]) asString

]
{
	#category : #accessing
}
FlashMelodyEvent >> sequencerKey [
	^ sequencerKey

]
{
	#category : #accessing
}
FlashMelodyEvent >> sequencerKey: anObject [
	sequencerKey := anObject

]
{
	#category : #accessing
}
FlashMelodyEvent >> soundName [
	^ soundName

]
{
	#category : #accessing
}
FlashMelodyEvent >> soundName: aString [
	soundName := aString

]
{
	#category : #accessing
}
FlashMelodyEvent >> noteValue [
	^ noteValue

]
{
	#category : #accessing
}
FlashMelodyEvent >> noteValue: anInteger [
	noteValue := anInteger

]
{
	#category : #accessing
}
FlashMelodyEvent >> velocity [
	^ velocity

]
{
	#category : #accessing
}
FlashMelodyEvent >> velocity: aFloat [
	velocity := aFloat

]
{
	#category : #accessing
}
FlashMelodyEvent >> channel [
	^ channel

]
{
	#category : #accessing
}
FlashMelodyEvent >> channel: anInteger [
	channel := anInteger

]
{
	#category : #accessing
}
FlashMelodyEvent >> orbit [
	^ orbit

]
{
	#category : #accessing
}
FlashMelodyEvent >> orbit: anInteger [
	orbit := anInteger

]
{
	#category : #accessing
}
FlashMelodyEvent >> duration [
	^ duration

]
{
	#category : #accessing
}
FlashMelodyEvent >> duration: aFloat [
	duration := aFloat

]
{
	#category : #accessing
}
FlashMelodyEvent >> gateValue [
	^ gateValue

]
{
	#category : #accessing
}
FlashMelodyEvent >> gateValue: anInteger [
	gateValue := anInteger

]
{
	#category : #accessing
}
FlashMelodyEvent >> extraParams [
	^ extraParams

]
{
	#category : #accessing
}
FlashMelodyEvent >> extraParams: aDictionary [
	extraParams := aDictionary

]
{
	#category : #accessing
}
FlashMelodyEvent >> timestamp [
	^ timestamp

]
{
	#category : #accessing
}
FlashMelodyEvent >> timestamp: aDateAndTime [
	timestamp := aDateAndTime

]
{
	#category : #accessing
}
FlashMelodyEvent >> performer [
	^ performer

]
{
	#category : #accessing
}
FlashMelodyEvent >> performer: aPerformer [
	performer := aPerformer

]
{
	#category : #classification
}
FlashMelodyEvent >> soundCategory [
	| name |
	name := soundName ifNil: [ ^ #sample ].
	(#('bd' 'kick' 'sn' 'snare' 'hh' 'hihat' 'cp' 'clap' 'rim' 'tom' 'crash' 'ride' 'cymbal') includes: name)
		ifTrue: [ ^ #drum ].
	(#('bass' 'sub' 'bass1' 'bass2' 'bass3') anySatisfy: [ :each | name beginsWith: each ])
		ifTrue: [ ^ #bass ].
	(#('superpiano' 'supersquare' 'supersaw' 'superfm' 'supercomparg') anySatisfy: [ :each | name beginsWith: each ])
		ifTrue: [ ^ #lead ].
	(#('pad' 'ambient' 'drone') anySatisfy: [ :each | name beginsWith: each ])
		ifTrue: [ ^ #pad ].
	(#('fx' 'noise' 'beat' 'loop') anySatisfy: [ :each | name beginsWith: each ])
		ifTrue: [ ^ #fx ].
	^ #sample

]
{
	#category : #classification
}
FlashMelodyEvent >> isPercussive [
	^ self soundCategory = #drum

]
{
	#category : #classification
}
FlashMelodyEvent >> normalizedPitch [
	noteValue ifNil: [ ^ 0.5 ].
	^ (noteValue max: 0 min: 127) / 127.0

]
{
	#category : #classification
}
FlashMelodyEvent >> hasEffect: aSymbol [
	^ extraParams isNotNil and: [ extraParams includesKey: aSymbol ]

]
{
	#category : #testing
}
FlashMelodyEvent >> forceSoundCategory: aSymbol [
	"Used for testing — forces a specific sound category."
	soundName := aSymbol asString
]
