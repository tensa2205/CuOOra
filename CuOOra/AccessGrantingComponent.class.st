Class {
	#name : #AccessGrantingComponent,
	#superclass : #WAComponent,
	#instVars : [
		'userName',
		'password'
	],
	#category : #'CuOOra-ui'
}

{ #category : #model }
AccessGrantingComponent >> model [
	^ CuOOra soleInstance 
]

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
	aCanvas
		form: [ 
			self renderInputElementsOn: aCanvas.
			self renderButtonsOn: aCanvas 
			]
]

{ #category : #rendering }
AccessGrantingComponent >> renderInputElementsOn: aCanvas [
	aCanvas label: 'Nombre de usuario'.
	aCanvas paragraph: [ 
		aCanvas textInput 
			callback: [ :valorNuevo | self userName: valorNuevo ];
			with: self userName.  ].
	
	aCanvas label: 'Contraseña'.
	aCanvas paragraph: [ 
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
