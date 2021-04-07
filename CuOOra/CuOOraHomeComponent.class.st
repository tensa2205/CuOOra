Class {
	#name : #CuOOraHomeComponent,
	#superclass : #WAComponent,
	#category : #'CuOOra-ui'
}

{ #category : #callbacks }
CuOOraHomeComponent >> logout [
	self call: (LoginComponent new logout ; yourself)
]

{ #category : #rendering }
CuOOraHomeComponent >> renderContentOn: aCanvas [
	aCanvas heading:'CuooRa'.
	
	aCanvas paragraph: [  
		aCanvas space: 50.
		aCanvas text: self session user nombreUsuario.
		aCanvas space: 3.
		aCanvas anchor
			callback: [self logout ];
			with: 'Log out'.
		].
	aCanvas horizontalRule .
	
	 
]
