Class {
	#name : 'FlashScanlineOverlay',
	#superclass : 'BlElement',
	#category : 'Flash-Effects',
	#package : 'Flash-Effects'
}

{ #category : 'initialization' }
FlashScanlineOverlay >> initialize [
	super initialize.
	self background: Color transparent.
	self layout: (BlLinearLayout vertical cellSpacing: 3).
	self constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	self preventMeAndChildrenMouseEvents.
	1 to: self class scanlineCount do: [ :i |
		self addChild: (BlElement new
			background: (Color black alpha: 0.14);
			constraintsDo: [ :c |
				c horizontal matchParent.
				c vertical exact: 1 ];
			yourself) ]
]

{ #category : 'accessing' }
FlashScanlineOverlay >> tint: aColor [
	"Recolor every scanline strip with a translucent version of aColor."

	self children do: [ :strip |
		strip background: (aColor alpha: 0.16) ]
]

{ #category : 'accessing' }
FlashScanlineOverlay class >> scanlineCount [
	^ 240
]