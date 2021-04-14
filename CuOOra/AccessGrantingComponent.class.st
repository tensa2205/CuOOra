"
.
"
Class {
	#name : #AccessGrantingComponent,
	#superclass : #WAComponent,
	#instVars : [
		'userName',
		'password'
	],
	#category : #'CuOOra-ui'
}

{ #category : #accessing }
AccessGrantingComponent >> password [
	^ password 
]

{ #category : #accessing }
AccessGrantingComponent >> password: anPassword [
	password := anPassword 
]

{ #category : #private }
AccessGrantingComponent >> proceedWith: aUser [
	self session user: aUser.
	self call: CuOOraHomeComponent new
]

{ #category : #rendering }
AccessGrantingComponent >> renderButtonsOn: aCanvas [
	self subclassResponsibility 
]

{ #category : #rendering }
AccessGrantingComponent >> renderContentOn: aCanvas [
	aCanvas heading: 'CuOOra'.
	aCanvas
		form: [ 
			self renderInputElementsOn: aCanvas.
			self renderButtonsOn: aCanvas 
			]
]

{ #category : #rendering }
AccessGrantingComponent >> renderInputElementsOn: aCanvas [
	aCanvas paragraph: [ 
		aCanvas label: 'Usuario:'.
		aCanvas space: 10.
		aCanvas textInput 
			callback: [ :valorNuevo | self userName: valorNuevo ];
			with: self userName.  ].
	
	
	aCanvas paragraph: [ 
		aCanvas label: 'Contraseña:'.
		aCanvas space: 5.
		aCanvas passwordInput
		callback: [ :valorNuevo | self password: valorNuevo ];
		with: self password ].
	
]

{ #category : #accessing }
AccessGrantingComponent >> userName [
	^ userName
]

{ #category : #accessing }
AccessGrantingComponent >> userName: anUsername [
	userName := anUsername 
]