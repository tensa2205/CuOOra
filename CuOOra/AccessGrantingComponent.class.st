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
	
	aCanvas div
			class: 'form-group col-2';
			with:[
			 	aCanvas text: 'Usuario'.
		  		aCanvas textInput 
				class: 'form-control required ml-4';	
				callback: [ :valorNuevo | self userName: valorNuevo ];
				with: self userName.  ].

	aCanvas div
			class: 'form-group col-2';
			with:[
			 	aCanvas text: 'Contraseña'.
		  		aCanvas passwordInput 
				class: 'form-control required ml-4';	
				callback: [ :valorNuevo | self password: valorNuevo ];
				with: self password ].
	
]

{ #category : #updating }
AccessGrantingComponent >> updateRoot: anHtmlRoot [ 
    super updateRoot: anHtmlRoot.
    anHtmlRoot stylesheet url: 'https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css'


]

{ #category : #accessing }
AccessGrantingComponent >> userName [
	^ userName
]

{ #category : #accessing }
AccessGrantingComponent >> userName: anUsername [
	userName := anUsername 
]
