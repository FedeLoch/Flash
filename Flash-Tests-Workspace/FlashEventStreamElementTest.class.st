Class {
	#name : 'FlashEventStreamElementTest',
	#superclass : 'TestCase',
	#category : 'Flash-Tests-Workspace',
	#package : 'Flash-Tests-Workspace'
}

{ #category : 'tests' }
FlashEventStreamElementTest >> testInitialStateIsEmpty [
	| stream |
	stream := FlashEventStreamElement new.
	self assert: stream rowCount equals: 0
]

{ #category : 'tests' }
FlashEventStreamElementTest >> testRefreshAddsRows [
	| stream |
	stream := FlashEventStreamElement new.
	stream refreshWith: #( 'a' 'b' 'c' ).
	self assert: stream rowCount equals: 3
]

{ #category : 'tests' }
FlashEventStreamElementTest >> testRefreshKeepsLastSix [
	| stream entries |
	entries := (1 to: 10) collect: [ :i | i printString ].
	stream := FlashEventStreamElement new.
	stream refreshWith: entries asArray.
	self assert: stream rowCount equals: 6
]