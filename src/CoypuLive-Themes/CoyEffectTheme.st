Class {
	#name : #CoyEffectTheme,
	#superclass : #Object,
	#instVars : [
		'name',
		'mappings',
		'defaultEffect',
		'backgroundColor',
		'textColor',
		'accentColors'
	],
	#category : #'CoypuLive-Themes'
}

{
	#category : #initialization
}
CoyEffectTheme >> initialize
	super initialize.
	mappings := Dictionary new.
	accentColors := Dictionary new.
	defaultEffect := CoyFlashEffect -> { #color -> Color green. #intensity -> 0.3 } asDictionary

{
	#category : #accessing
}
CoyEffectTheme >> name
	^ name

{
	#category : #accessing
}
CoyEffectTheme >> name: aString
	name := aString

{
	#category : #accessing
}
CoyEffectTheme >> mappings
	^ mappings

{
	#category : #accessing
}
CoyEffectTheme >> mappings: aDictionary
	mappings := aDictionary

{
	#category : #accessing
}
CoyEffectTheme >> defaultEffect
	^ defaultEffect

{
	#category : #accessing
}
CoyEffectTheme >> defaultEffect: anAssociation
	defaultEffect := anAssociation

{
	#category : #accessing
}
CoyEffectTheme >> backgroundColor
	^ backgroundColor

{
	#category : #accessing
}
CoyEffectTheme >> backgroundColor: aColor
	backgroundColor := aColor

{
	#category : #accessing
}
CoyEffectTheme >> textColor
	^ textColor

{
	#category : #accessing
}
CoyEffectTheme >> textColor: aColor
	textColor := aColor

{
	#category : #accessing
}
CoyEffectTheme >> accentColors
	^ accentColors

{
	#category : #accessing
}
CoyEffectTheme >> accentColors: aDictionary
	accentColors := aDictionary

{
	#category : #api
}
CoyEffectTheme >> effectForEvent: aCoyMelodyEvent
	| category mapping |
	category := aCoyMelodyEvent soundCategory.
	mapping := mappings at: category ifAbsent: [
		mappings at: aCoyMelodyEvent soundName ifAbsent: [ nil ] ].
	mapping ifNil: [ ^ self buildEffectFromConfig: defaultEffect ].
	^ self buildEffectFromConfig: mapping

{
	#category : #api
}
CoyEffectTheme >> effectForEvent: aCoyMelodyEvent ifConfigured: aBlock
	| effect |
	effect := self effectForEvent: aCoyMelodyEvent.
	effect ifNotNil: aBlock

{
	#category : #'private building'
}
CoyEffectTheme >> buildEffectFromConfig: aDictionary
	| effectClass config effect |
	effectClass := aDictionary at: #effectClass ifAbsent: [ CoyFlashEffect ].
	config := aDictionary at: #config ifAbsent: [ Dictionary new ].
	effect := effectClass new.
	config at: #color ifPresent: [ :c | effect color: c ].
	config at: #intensity ifPresent: [ :i | effect intensity: i ].
	config at: #duration ifPresent: [ :d | effect duration: d ].
	^ effect

{
	#category : #api
}
CoyEffectTheme >> colorForEvent: aCoyMelodyEvent
	^ accentColors at: aCoyMelodyEvent soundCategory ifAbsent: [ self textColor ]

{
	#category : #api
}
CoyEffectTheme >> applyToEditor: aCoyLiveEditor
	aCoyLiveEditor background: backgroundColor.
	aCoyLiveEditor editor background: backgroundColor.
	"Additional text color styling would go here if AlbEditor API exposes it"
