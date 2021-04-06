Class {
	#name : #LoginComponent,
	#superclass : #AccessGrantingComponent,
	#category : #'CuOOra-ui'
}

{ #category : #'app-initialization' }
LoginComponent class >> initialize [
	| application |
	application := WAAdmin register: self asApplicationAt: 'CuOOra'.
	application sessionClass: SessionWithUser .
	
]

{ #category : #rendering }
LoginComponent >> renderButtonsOn: aCanvas [
	self renderSignInButtonOn: aCanvas.
	aCanvas horizontalRule.
	aCanvas paragraph: 'No tenes una cuenta?'.
	self renderSignUpButtonOn: aCanvas.
]

{ #category : #rendering }
LoginComponent >> renderSignInButtonOn: aCanvas [
	aCanvas submitButton 
		callback: [ self login ];
		with: 'Iniciar sesion'
]

{ #category : #rendering }
LoginComponent >> renderSignUpButtonOn: aCanvas [
	aCanvas submitButton 
		callback: [ self registerNewUser ];
		with: 'Registrate, ES GRATAROLA'
]
