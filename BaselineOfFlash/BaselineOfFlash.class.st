Class {
	#name : 'BaselineOfFlash',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfFlash',
	#package : 'BaselineOfFlash'
}

{ #category : 'baselines' }
BaselineOfFlash >> baseline: spec [

	<baseline>
	spec for: #common do: [
			spec baseline: 'Coypu' with: [ spec repository: 'github://lucretiomsp/coypu:master' ].
			spec baseline: 'Bloc' with: [ spec repository: 'github://pharo-graphics/Bloc:master' ].
			spec baseline: 'Album' with: [ spec repository: 'github://pharo-graphics/Album:master' ].
			
			spec package: 'Flash-Core' with: [ spec requires: #( 'Coypu' 'Bloc' 'Album' ) ].
			spec package: 'Flash-Events' with: [ spec requires: #( 'Coypu' 'Bloc' 'Album' ) ].
			spec package: 'Flash-Effects' with: [ spec requires: #( 'Coypu' 'Bloc' 'Album' ) ].
			spec package: 'Flash-Themes' with: [ spec requires: #( 'Coypu' 'Bloc' 'Album' ) ].
			spec package: 'Flash-Themes-Editor' with: [ spec requires: #( 'Coypu' 'Bloc' 'Album' ) ].
			spec package: 'Flash-Tests-Core' with: [ spec requires: #( 'Coypu' 'Bloc' 'Album' ) ].
			spec package: 'Flash-Tests-Events' with: [ spec requires: #( 'Coypu' 'Bloc' 'Album' ) ].
			spec package: 'Flash-Tests-Effects' with: [ spec requires: #( 'Coypu' 'Bloc' 'Album' ) ].
			spec package: 'Flash-Tests-Themes' with: [ spec requires: #( 'Coypu' 'Bloc' 'Album' ) ].
			spec package: 'Flash-Tests-Integration' with: [ spec requires: #( 'Coypu' 'Bloc' 'Album' ) ]
	]
]
