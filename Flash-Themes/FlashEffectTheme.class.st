Class {
	#name : 'FlashEffectTheme',
	#superclass : 'Object',
	#instVars : [
		'name',
		'mappings',
		'defaultEffect',
		'backgroundColor',
		'textColor',
		'accentColors'
	],
	#category : 'Flash-Themes',
	#package : 'Flash-Themes'
}

{ #category : 'accessing' }
FlashEffectTheme >> accentColors [
	^ accentColors

]

{ #category : 'accessing' }
FlashEffectTheme >> accentColors: aDictionary [
	accentColors := aDictionary

]

{ #category : 'api' }
FlashEffectTheme >> applyToEditor: aFlashLiveEditor [

	aFlashLiveEditor background: backgroundColor.
	aFlashLiveEditor editor background: backgroundColor.
	textColor ifNotNil: [
		aFlashLiveEditor editor
			selectionColor: (textColor alpha: 0.3).
		aFlashLiveEditor editor cursor
			ifNotNil: [ :c | c color: textColor ].
		| text |
		text := aFlashLiveEditor editor text.
		text isEmpty
			ifTrue: [
				text := String new asRopedText.
				text foreground: textColor.
				aFlashLiveEditor editor text: text
			]
			ifFalse: [ text foreground: textColor ]
	]
]

{ #category : 'accessing' }
FlashEffectTheme >> backgroundColor [
	^ backgroundColor

]

{ #category : 'accessing' }
FlashEffectTheme >> backgroundColor: aColor [
	backgroundColor := aColor

]

{ #category : 'private building' }
FlashEffectTheme >> buildEffectFromConfig: aDictionary [
	| effectClass config effect |
	effectClass := aDictionary at: #effectClass ifAbsent: [ FlashFlashEffect ].
	config := aDictionary at: #config ifAbsent: [ Dictionary new ].
	effect := effectClass new.
	config at: #color ifPresent: [ :c | effect color: c ].
	config at: #intensity ifPresent: [ :i | effect intensity: i ].
	config at: #duration ifPresent: [ :d | effect duration: d ].
	^ effect

]

{ #category : 'api' }
FlashEffectTheme >> colorForEvent: aFlashMelodyEvent [
	^ accentColors at: aFlashMelodyEvent soundCategory ifAbsent: [ self textColor ]

]

{ #category : 'accessing' }
FlashEffectTheme >> defaultEffect [
	^ defaultEffect

]

{ #category : 'accessing' }
FlashEffectTheme >> defaultEffect: anAssociation [
	defaultEffect := anAssociation

]

{ #category : 'api' }
FlashEffectTheme >> effectForEvent: aFlashMelodyEvent [
	| category mapping |
	category := aFlashMelodyEvent soundCategory.
	mapping := mappings at: category ifAbsent: [
		mappings at: aFlashMelodyEvent soundName ifAbsent: [ nil ] ].
	mapping ifNil: [ ^ self buildEffectFromConfig: defaultEffect ].
	^ self buildEffectFromConfig: mapping

]

{ #category : 'api' }
FlashEffectTheme >> effectForEvent: aFlashMelodyEvent ifConfigured: aBlock [
	| effect |
	effect := self effectForEvent: aFlashMelodyEvent.
	effect ifNotNil: aBlock

]

{ #category : 'initialization' }
FlashEffectTheme >> initialize [
	super initialize.
	mappings := Dictionary new.
	accentColors := Dictionary new.
	defaultEffect := { #effectClass -> FlashFlashEffect. #config -> { #color -> Color green. #intensity -> 0.3 } asDictionary } asDictionary

]

{ #category : 'accessing' }
FlashEffectTheme >> mappings [
	^ mappings

]

{ #category : 'accessing' }
FlashEffectTheme >> mappings: aDictionary [
	mappings := aDictionary

]

{ #category : 'accessing' }
FlashEffectTheme >> name [
	^ name

]

{ #category : 'accessing' }
FlashEffectTheme >> name: aString [
	name := aString

]

{ #category : 'accessing' }
FlashEffectTheme >> textColor [
	^ textColor

]

{ #category : 'accessing' }
FlashEffectTheme >> textColor: aColor [
	textColor := aColor

]
