Class {
	#name : #CoyMelodyEvent,
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
	#category : #'CoypuLive-Events'
}

{
	#category : #'instance creation'
}
CoyMelodyEvent class >> fromSequencer: aSequencer at: anIndex
	^ self new
		sequencerKey: aSequencer seqKey;
		noteValue: (aSequencer notes at: (anIndex min: aSequencer notes size) max: 1);
		velocity: (aSequencer velocity ifNotNil: [ :v | v ] ifNil: [ 0.8 ]);
		gateValue: (aSequencer gates at: (anIndex min: aSequencer gates size) max: 1);
		soundName: (self extractSoundNameFrom: aSequencer);
		extraParams: (aSequencer dirtMessage ifNil: [ Dictionary new ] ifNotNil: [ aSequencer dirtMessage ]);
		timestamp: DateAndTime now;
		yourself

{
	#category : #'private utilities'
}
CoyMelodyEvent class >> extractSoundNameFrom: aSequencer
	| message |
	message := aSequencer dirtMessage.
	message ifNil: [ ^ 'unknown' ].
	^ (message at: 's' ifAbsent: [
		message at: #s ifAbsent: [ ^ 'unknown' ] ]) asString

{
	#category : #accessing
}
CoyMelodyEvent >> sequencerKey
	^ sequencerKey

{
	#category : #accessing
}
CoyMelodyEvent >> sequencerKey: anObject
	sequencerKey := anObject

{
	#category : #accessing
}
CoyMelodyEvent >> soundName
	^ soundName

{
	#category : #accessing
}
CoyMelodyEvent >> soundName: aString
	soundName := aString

{
	#category : #accessing
}
CoyMelodyEvent >> noteValue
	^ noteValue

{
	#category : #accessing
}
CoyMelodyEvent >> noteValue: anInteger
	noteValue := anInteger

{
	#category : #accessing
}
CoyMelodyEvent >> velocity
	^ velocity

{
	#category : #accessing
}
CoyMelodyEvent >> velocity: aFloat
	velocity := aFloat

{
	#category : #accessing
}
CoyMelodyEvent >> channel
	^ channel

{
	#category : #accessing
}
CoyMelodyEvent >> channel: anInteger
	channel := anInteger

{
	#category : #accessing
}
CoyMelodyEvent >> orbit
	^ orbit

{
	#category : #accessing
}
CoyMelodyEvent >> orbit: anInteger
	orbit := anInteger

{
	#category : #accessing
}
CoyMelodyEvent >> duration
	^ duration

{
	#category : #accessing
}
CoyMelodyEvent >> duration: aFloat
	duration := aFloat

{
	#category : #accessing
}
CoyMelodyEvent >> gateValue
	^ gateValue

{
	#category : #accessing
}
CoyMelodyEvent >> gateValue: anInteger
	gateValue := anInteger

{
	#category : #accessing
}
CoyMelodyEvent >> extraParams
	^ extraParams

{
	#category : #accessing
}
CoyMelodyEvent >> extraParams: aDictionary
	extraParams := aDictionary

{
	#category : #accessing
}
CoyMelodyEvent >> timestamp
	^ timestamp

{
	#category : #accessing
}
CoyMelodyEvent >> timestamp: aDateAndTime
	timestamp := aDateAndTime

{
	#category : #accessing
}
CoyMelodyEvent >> performer
	^ performer

{
	#category : #accessing
}
CoyMelodyEvent >> performer: aPerformer
	performer := aPerformer

{
	#category : #classification
}
CoyMelodyEvent >> soundCategory
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

{
	#category : #classification
}
CoyMelodyEvent >> isPercussive
	^ self soundCategory = #drum

{
	#category : #classification
}
CoyMelodyEvent >> normalizedPitch
	noteValue ifNil: [ ^ 0.5 ].
	^ (noteValue max: 0 min: 127) / 127.0

{
	#category : #classification
}
CoyMelodyEvent >> hasEffect: aSymbol
	^ extraParams isNotNil and: [ extraParams includesKey: aSymbol ]

{
	#category : #testing
}
CoyMelodyEvent >> forceSoundCategory: aSymbol
	"Used for testing — forces a specific sound category."
	soundName := aSymbol asString
