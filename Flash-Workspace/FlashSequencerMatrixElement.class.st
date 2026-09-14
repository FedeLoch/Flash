Class {
	#name : 'FlashSequencerMatrixElement',
	#superclass : 'BlElement',
	#instVars : [
		'workspace',
		'rowPanels',
		'cells',
		'stepIndex',
		'header'
	],
	#category : 'Flash-Workspace',
	#package : 'Flash-Workspace'
}

{ #category : 'instance creation' }
FlashSequencerMatrixElement class >> onWorkspace: aWorkspace [
	^ self new workspace: aWorkspace
]

{ #category : 'building' }
FlashSequencerMatrixElement >> accentColor [
	^ Color fromHexString: '#00F2FF'
]

{ #category : 'building' }
FlashSequencerMatrixElement >> activeColor [
	^ Color fromHexString: '#1D232B'
]

{ #category : 'building' }
FlashSequencerMatrixElement >> buildHeader [
	| headerRow |
	headerRow := BlElement new.
	headerRow layout: BlLinearLayout horizontal.
	headerRow constraintsDo: [ :c |
		c horizontal matchParent ].
	headerRow addChild: (self headerLabel: 'STEP' paddedTo: 46).
	1 to: 16 do: [ :i |
		headerRow addChild: (self headerLabel: (i - 1) printString paddedTo: 18) ].
	^ headerRow
]

{ #category : 'building' }
FlashSequencerMatrixElement >> buildRows [
	| container |
	rowPanels := Dictionary new.
	cells := Dictionary new.
	container := BlElement new.
	container layout: BlLinearLayout vertical.
	container constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	container addChild: self buildHeader.
	workspace laneKeys asSortedCollection do: [ :key |
		| row cellRow |
		row := BlElement new.
		row layout: BlLinearLayout horizontal.
		row height: 18.
		row addChild: (self laneLabel: key).
		cellRow := (1 to: 16) collect: [ :step | self cellForLane: key atStep: step ].
		cellRow do: [ :cell | row addChild: cell ].
		rowPanels at: key put: row.
		cells at: key put: cellRow.
		container addChild: row ].
	self addChild: container
]

{ #category : 'building' }
FlashSequencerMatrixElement >> cellForLane: aSymbol atStep: anInteger [
	| cell active |
	cell := BlElement new.
	cell size: 18 @ 18.
	cell geometry: BlRoundedRectangleGeometry new.
	active := (workspace laneForKey: aSymbol) isActiveAt: anInteger.
	cell background: (active
		ifTrue: [ self activeColor ]
		ifFalse: [ Color fromHexString: '#0A0E14' ]).
	^ cell
]

{ #category : 'building' }
FlashSequencerMatrixElement >> headerLabel: aString paddedTo: anInteger [
	| text |
	text := BlTextElement new text: ((aString asRopedText) foreground: (Color fromHexString: '#C5CDD8')).
	text constraintsDo: [ :c |
		c horizontal exact: anInteger.
		c vertical exact: 16 ].
	^ text
]

{ #category : 'initialization' }
FlashSequencerMatrixElement >> initialize [
	super initialize.
	workspace := FlashWorkspace new.
	stepIndex := -1.
	self layout: BlLinearLayout vertical.
	self extent: 700 @ 90.
	self background: (Color fromHexString: '#11151C').
	self border: (BlBorder paint: (Color fromHexString: '#1D232B') width: 1).
	self buildRows
]

{ #category : 'querying' }
FlashSequencerMatrixElement >> isLaneActiveAtStep: anIndex lane: aSymbol [
	| lane |
	lane := workspace laneForKey: aSymbol.
	^ lane isNotNil and: [ lane isActiveAt: anIndex + 1 ]
]

{ #category : 'building' }
FlashSequencerMatrixElement >> laneLabel: aSymbol [
	| text |
	text := BlTextElement new text: ((aSymbol asString asUppercase asRopedText) foreground: (Color fromHexString: '#C5CDD8')).
	text constraintsDo: [ :c |
		c horizontal exact: 44.
		c vertical exact: 16 ].
	^ text
]

{ #category : 'quering' }
FlashSequencerMatrixElement >> laneRowForKey: aSymbol [
	^ rowPanels at: aSymbol ifAbsent: [ nil ]
]

{ #category : 'accessing' }
FlashSequencerMatrixElement >> rowPanels [
	^ rowPanels
]

{ #category : 'querying' }
FlashSequencerMatrixElement >> stepIndex [
	^ stepIndex
]

{ #category : 'events' }
FlashSequencerMatrixElement >> tickToStep: anInteger [
	stepIndex := anInteger.
	workspace laneKeys do: [ :key |
		| cellsRow |
		cellsRow := cells at: key ifAbsent: [ #() ].
		cellsRow doWithIndex: [ :cell :i |
			| active isCurrent |
			active := self isLaneActiveAtStep: i - 1 lane: key.
			isCurrent := (i - 1) = anInteger.
			cell background: (
				isCurrent
					ifTrue: [ active ifTrue: [ Color fromHexString: '#4DE8FF' ] ifFalse: [ Color fromHexString: '#2B7A8A' ] ]
					ifFalse: [ active ifTrue: [ self activeColor ] ifFalse: [ Color fromHexString: '#0A0E14' ] ]) ] ].
	^ anInteger
]

{ #category : 'accessing' }
FlashSequencerMatrixElement >> workspace [
	^ workspace
]

{ #category : 'accessing' }
FlashSequencerMatrixElement >> workspace: aWorkspace [
	workspace := aWorkspace.
	self removeChildren.
	self buildRows
]