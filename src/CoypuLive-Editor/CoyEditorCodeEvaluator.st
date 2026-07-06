Class {
	#name : #CoyEditorCodeEvaluator,
	#superclass : #Object,
	#instVars : [
		'compiler',
		'context',
		'editor'
	],
	#category : #'CoypuLive-Editor'
}

{
	#category : #initialization
}
CoyEditorCodeEvaluator >> initialize
	super initialize.
	compiler := Smalltalk compiler

{
	#category : #accessing
}
CoyEditorCodeEvaluator >> compiler
	^ compiler

{
	#category : #accessing
}
CoyEditorCodeEvaluator >> context
	^ context

{
	#category : #accessing
}
CoyEditorCodeEvaluator >> context: anObject
	context := anObject

{
	#category : #accessing
}
CoyEditorCodeEvaluator >> editor
	^ editor

{
	#category : #accessing
}
CoyEditorCodeEvaluator >> editor: aCoyLiveEditor
	editor := aCoyLiveEditor

{
	#category : #evaluation
}
CoyEditorCodeEvaluator >> evaluate: aString
	^ compiler evaluate: aString receiver: context logged: true

{
	#category : #evaluation
}
CoyEditorCodeEvaluator >> evaluateSelection
	| selection result |
	selection := self selectedText.
	selection ifEmpty: [ ^ self ].
	result := self evaluate: selection.
	^ result

{
	#category : #evaluation
}
CoyEditorCodeEvaluator >> printSelection
	| selection result |
	selection := self selectedText.
	selection ifEmpty: [ ^ self ].
	result := self evaluate: selection.
	self insertResult: result printString

{
	#category : #evaluation
}
CoyEditorCodeEvaluator >> inspectSelection
	| selection result |
	selection := self selectedText.
	selection ifEmpty: [ ^ self ].
	result := self evaluate: selection.
	result inspect

{
	#category : #evaluation
}
CoyEditorCodeEvaluator >> debugSelection
	| selection |
	selection := self selectedText.
	selection ifEmpty: [ ^ self ].
	compiler evaluate: selection receiver: context logged: true debug: true

{
	#category : #'text access'
}
CoyEditorCodeEvaluator >> selectedText
	| editorElement |
	editor ifNil: [ ^ '' ].
	editorElement := editor editor.
	editorElement hasSelection ifTrue: [
		^ editorElement text asString copyFrom: editorElement selectionStart to: editorElement selectionEnd ].
	^ editorElement text asString

{
	#category : #'text access'
}
CoyEditorCodeEvaluator >> insertResult: aString
	| editorElement text index |
	editor ifNil: [ ^ self ].
	editorElement := editor editor.
	text := editorElement text asString.
	index := editorElement cursorPosition.
	editorElement text: (text copyReplaceFrom: index to: index - 1 with: ' ' , aString) asRopedText
