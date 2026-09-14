Class {
	#name : 'FlashMiniMatrixElement',
	#superclass : 'BlElement',
	#instVars : [
		'workspace',
		'cells',
		'stepIndex'
	],
	#category : 'Flash-Stage',
	#package : 'Flash-Stage'
}

{ #category : 'instance creation' }
FlashMiniMatrixElement class >> onWorkspace: aWorkspace [
	^ self new workspace: aWorkspace
]

{ #category : 'building' }
FlashMiniMatrixElement >> buildRows [
	| container |
	container := BlElement new.
	container layout: BlLinearLayout vertical.
	container constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].

	workspace laneKeys do: [ :key |
		| row cellRow |
		row := BlElement new.
		row layout: BlLinearLayout horizontal.
		row height: 14.
		row addChild: (self laneLabel: key).
		cellRow := (1 to: 16) collect: [ :step | self cellForLane: key atStep: step ].
		cellRow do: [ :cell | row addChild: cell ].
		cells at: key put: cellRow.
		container addChild: row ].

	self addChild: container
]

{ #category : 'building' }
FlashMiniMatrixElement >> cellForLane: aSymbol atStep: anInteger [
	| cell active |
	cell := BlElement new.
	cell size: 6 @ 6.
	cell geometry: BlRoundedRectangleGeometry new.
	active := (workspace laneForKey: aSymbol) isActiveAt: anInteger.
	cell background: (active
		ifTrue: [ Color fromHexString: '#00F2FF' ]
		ifFalse: [ Color fromHexString: '#0A0E14' ]).
	^ cell
]

{ #category : 'initialization' }
FlashMiniMatrixElement >> initialize [
	super initialize.
	workspace := FlashWorkspace new.
	cells := Dictionary new.
	stepIndex := -1.
	self layout: BlLinearLayout vertical.
	self extent: 180 @ 44.
	self background: (Color fromHexString: '#11151C').
	self buildRows
]

{ #category : 'building' }
FlashMiniMatrixElement >> laneLabel: aSymbol [
	| text |
	text := BlTextElement new text: (aSymbol asString asUppercase asRopedText).
	text constraintsDo: [ :c |
		c horizontal exact: 42.
		c vertical exact: 12 ].
	^ text
]

{ #category : 'querying' }
FlashMiniMatrixElement >> isLaneActiveAtStep: anIndex lane: aSymbol [
	| lane |
	lane := workspace laneForKey: aSymbol.
	^ lane isNotNil and: [ lane isActiveAt: anIndex + 1 ]
]

{ #category : 'accessing' }
FlashMiniMatrixElement >> stepIndex [
	^ stepIndex
]

{ #category : 'events' }
FlashMiniMatrixElement >> tickToStep: anInteger [
	stepIndex := anInteger.
	workspace laneKeys do: [ :key |
		| cellRow |
		cellRow := cells at: key ifAbsent: [ #() ].
		cellRow doWithIndex: [ :cell :i |
			| active isCurrent |
			active := self isLaneActiveAtStep: i - 1 lane: key.
			isCurrent := (i - 1) = anInteger.
			cell background: (
				isCurrent
					ifTrue: [ active ifTrue: [ Color fromHexString: '#4DE8FF' ] ifFalse: [ Color fromHexString: '#2B7A8A' ] ]
					ifFalse: [ active ifTrue: [ Color fromHexString: '#00F2FF' ] ifFalse: [ Color fromHexString: '#0A0E14' ] ]) ] ].
	^ anInteger
]

{ #category : 'accessing' }
FlashMiniMatrixElement >> workspace [
	^ workspace
]

{ #category : 'accessing' }
FlashMiniMatrixElement >> workspace: aWorkspace [
	workspace := aWorkspace.
	self removeChildren.
	self buildRows
]