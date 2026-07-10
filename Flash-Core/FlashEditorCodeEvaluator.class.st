Class {
	#name : 'FlashEditorCodeEvaluator',
	#superclass : 'Object',
	#instVars : [
		'compiler',
		'context',
		'editor'
	],
	#category : 'Flash-Core',
	#package : 'Flash-Core'
}

{ #category : 'accessing' }
FlashEditorCodeEvaluator >> compiler [
	^ compiler

]

{ #category : 'accessing' }
FlashEditorCodeEvaluator >> context [
	^ context

]

{ #category : 'accessing' }
FlashEditorCodeEvaluator >> context: anObject [
	context := anObject

]

{ #category : 'evaluation' }
FlashEditorCodeEvaluator >> debugSelection [
	| selection |
	selection := self selectedText.
	selection ifEmpty: [ ^ self ].
	compiler evaluate: selection receiver: context logged: true debug: true

]

{ #category : 'accessing' }
FlashEditorCodeEvaluator >> editor [
	^ editor

]

{ #category : 'accessing' }
FlashEditorCodeEvaluator >> editor: aFlashLiveEditor [
	editor := aFlashLiveEditor

]

{ #category : 'evaluation' }
FlashEditorCodeEvaluator >> evaluate: aString [
	^ compiler evaluate: aString receiver: context logged: true

]

{ #category : 'evaluation' }
FlashEditorCodeEvaluator >> evaluateSelection [
	| selection result |
	selection := self selectedText.
	selection ifEmpty: [ ^ self ].
	result := self evaluate: selection.
	^ result

]

{ #category : 'initialization' }
FlashEditorCodeEvaluator >> initialize [
	super initialize.
	compiler := Smalltalk compiler

]

{ #category : 'text access' }
FlashEditorCodeEvaluator >> insertResult: aString [
	| editorElement text index |
	editor ifNil: [ ^ self ].
	editorElement := editor editor.
	text := editorElement text asString.
	index := editorElement cursorPosition.
	editorElement text: (text copyReplaceFrom: index to: index - 1 with: ' ' , aString) asRopedText
]

{ #category : 'evaluation' }
FlashEditorCodeEvaluator >> inspectSelection [
	| selection result |
	selection := self selectedText.
	selection ifEmpty: [ ^ self ].
	result := self evaluate: selection.
	result inspect

]

{ #category : 'evaluation' }
FlashEditorCodeEvaluator >> printSelection [
	| selection result |
	selection := self selectedText.
	selection ifEmpty: [ ^ self ].
	result := self evaluate: selection.
	self insertResult: result printString

]

{ #category : 'text access' }
FlashEditorCodeEvaluator >> selectedText [
	| editorElement |
	editor ifNil: [ ^ '' ].
	editorElement := editor editor.
	editorElement hasSelection ifTrue: [
		^ editorElement text asString copyFrom: editorElement selectionStart to: editorElement selectionEnd ].
	^ editorElement text asString

]
