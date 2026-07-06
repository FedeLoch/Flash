Class {
	#name : #CoyThemeEditorElement,
	#superclass : #BlElement,
	#instVars : [
		'themeList',
		'mappingEditor',
		'previewArea',
		'currentTheme',
		'editor'
	],
	#category : #'CoypuLive-Themes-Editor'
}

{
	#category : #initialization
}
CoyThemeEditorElement >> initialize
	super initialize.
	self layout: BlLinearLayout vertical.
	self size: 600 @ 500.
	self constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	self initializeThemeList.
	self initializeMappingEditor.
	self initializePreviewArea

{
	#category : #initialization
}
CoyThemeEditorElement >> initializeThemeList
	themeList := BlElement new
		size: 600 @ 150;
		background: Color veryDarkGray;
		border: (BlBorder builder width: 1; paint: Color gray; build);
		yourself.
	self addChild: themeList

{
	#category : #initialization
}
CoyThemeEditorElement >> initializeMappingEditor
	mappingEditor := BlElement new
		size: 600 @ 200;
		background: Color darkGray;
		border: (BlBorder builder width: 1; paint: Color gray; build);
		yourself.
	self addChild: mappingEditor

{
	#category : #initialization
}
CoyThemeEditorElement >> initializePreviewArea
	previewArea := BlElement new
		size: 600 @ 100;
		background: Color black;
		border: (BlBorder builder width: 1; paint: Color gray; build);
		yourself.
	self addChild: previewArea

{
	#category : #accessing
}
CoyThemeEditorElement >> themeList
	^ themeList

{
	#category : #accessing
}
CoyThemeEditorElement >> mappingEditor
	^ mappingEditor

{
	#category : #accessing
}
CoyThemeEditorElement >> previewArea
	^ previewArea

{
	#category : #accessing
}
CoyThemeEditorElement >> currentTheme
	^ currentTheme

{
	#category : #accessing
}
CoyThemeEditorElement >> currentTheme: aCoyEffectTheme
	currentTheme := aCoyEffectTheme

{
	#category : #accessing
}
CoyThemeEditorElement >> editor
	^ editor

{
	#category : #accessing
}
CoyThemeEditorElement >> editor: aCoyLiveEditor
	editor := aCoyLiveEditor

{
	#category : #api
}
CoyThemeEditorElement >> availableThemes
	^ CoyEffectTheme allSubclasses select: [ :cls | cls isAbstract not ]

{
	#category : #api
}
CoyThemeEditorElement >> selectTheme: aCoyEffectTheme
	currentTheme := aCoyEffectTheme.
	editor ifNotNil: [ editor effectTheme: aCoyEffectTheme ]
	"Update UI elements to reflect the selected theme"

{
	#category : #api
}
CoyThemeEditorElement >> previewEffectForCategory: aSymbol
	| event effect |
	currentTheme ifNil: [ ^ self ].
	event := CoyMelodyEvent new
		soundName: aSymbol;
		velocity: 0.8;
		yourself.
	effect := currentTheme effectForEvent: event.
	effect ifNotNil: [
		effect applyTo: previewArea withEvent: event ]
