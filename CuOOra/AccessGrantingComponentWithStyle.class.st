Class {
	#name : #AccessGrantingComponentWithStyle,
	#superclass : #WAComponent,
	#instVars : [
		'userName',
		'password'
	],
	#category : #'CuOOra-ui'
}

{ #category : #model }
AccessGrantingComponentWithStyle >> model [
	^ CuOOra soleInstance 
]

{ #category : #accessing }
AccessGrantingComponentWithStyle >> password [
	^ password 
]

{ #category : #accessing }
AccessGrantingComponentWithStyle >> password: anPassword [
	password := anPassword 
]

{ #category : #private }
AccessGrantingComponentWithStyle >> proceedWith: aUser [
	self session user: aUser.
	self call: CuOOraHomeComponent new
]

{ #category : #rendering }
AccessGrantingComponentWithStyle >> renderButtonsOn: aCanvas [
	self subclassResponsibility 
]

{ #category : #rendering }
AccessGrantingComponentWithStyle >> renderContentOn: aCanvas [
	aCanvas heading: 'CuOOra'.
	aCanvas
		form: [ 
			self renderInputElementsOn: aCanvas.
			self renderButtonsOn: aCanvas 
			]
]

{ #category : #rendering }
AccessGrantingComponentWithStyle >> renderInputElementsOn: aCanvas [
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

{ #category : #updating }
AccessGrantingComponentWithStyle >> updateRoot: anHtmlRoot [
    super updateRoot: anHtmlRoot.
    anHtmlRoot stylesheet url: 'https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css'
]

{ #category : #accessing }
AccessGrantingComponentWithStyle >> userName [
	^ userName
]

{ #category : #accessing }
AccessGrantingComponentWithStyle >> userName: anUsername [
	userName := anUsername 
]
