Class {
	#name : #FlashThemeEditorElement,
	#superclass : #BlElement,
	#instVars : [
		'themeList',
		'mappingEditor',
		'previewArea',
		'currentTheme',
		'editor'
	],
	#category : #'Flash-Themes-Editor'
}

{
	#category : #initialization
}
FlashThemeEditorElement >> initialize [
	super initialize.
	self layout: BlLinearLayout vertical.
	self size: 600 @ 500.
	self constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	self initializeThemeList.
	self initializeMappingEditor.
	self initializePreviewArea

]
{
	#category : #initialization
}
FlashThemeEditorElement >> initializeThemeList [
	themeList := BlElement new
		size: 600 @ 150;
		background: Color veryDarkGray;
		border: (BlBorder builder width: 1; paint: Color gray; build);
		yourself.
	self addChild: themeList

]
{
	#category : #initialization
}
FlashThemeEditorElement >> initializeMappingEditor [
	mappingEditor := BlElement new
		size: 600 @ 200;
		background: Color darkGray;
		border: (BlBorder builder width: 1; paint: Color gray; build);
		yourself.
	self addChild: mappingEditor

]
{
	#category : #initialization
}
FlashThemeEditorElement >> initializePreviewArea [
	previewArea := BlElement new
		size: 600 @ 100;
		background: Color black;
		border: (BlBorder builder width: 1; paint: Color gray; build);
		yourself.
	self addChild: previewArea

]
{
	#category : #accessing
}
FlashThemeEditorElement >> themeList [
	^ themeList

]
{
	#category : #accessing
}
FlashThemeEditorElement >> mappingEditor [
	^ mappingEditor

]
{
	#category : #accessing
}
FlashThemeEditorElement >> previewArea [
	^ previewArea

]
{
	#category : #accessing
}
FlashThemeEditorElement >> currentTheme [
	^ currentTheme

]
{
	#category : #accessing
}
FlashThemeEditorElement >> currentTheme: aFlashEffectTheme [
	currentTheme := aFlashEffectTheme

]
{
	#category : #accessing
}
FlashThemeEditorElement >> editor [
	^ editor

]
{
	#category : #accessing
}
FlashThemeEditorElement >> editor: aFlashLiveEditor [
	editor := aFlashLiveEditor

]
{
	#category : #api
}
FlashThemeEditorElement >> availableThemes [
	^ FlashEffectTheme allSubclasses select: [ :cls | cls isAbstract not ]

]
{
	#category : #api
}
FlashThemeEditorElement >> selectTheme: aFlashEffectTheme [
	currentTheme := aFlashEffectTheme.
	editor ifNotNil: [ editor effectTheme: aFlashEffectTheme ]

]
{
	#category : #api
}
FlashThemeEditorElement >> previewEffectForCategory: aSymbol [
	| event effect |
	currentTheme ifNil: [ ^ self ].
	event := FlashMelodyEvent new
		soundName: aSymbol;
		velocity: 0.8;
		yourself.
	effect := currentTheme effectForEvent: event.
	effect ifNotNil: [
		effect applyTo: previewArea withEvent: event ]
]
