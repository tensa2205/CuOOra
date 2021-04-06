Class {
	#name : #CuOOraHomeComponent,
	#superclass : #WAComponent,
	#category : #'CuOOra-ui'
}

{ #category : #rendering }
CuOOraHomeComponent >> renderContentOn: aCanvas [
	aCanvas heading: 'CuOOra'.
	aCanvas space: 10.
	aCanvas paragraph: self session user nombreUsuario 
]
