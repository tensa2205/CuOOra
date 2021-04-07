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

{ #category : #callbacks }
LoginComponent >> login [
	(self model autenticarUsuarioConNombre: userName  protegidoPor: password ) "Si existe dicho usuario, lo devuelve"
		ifNotNil: [ :it | self proceedWith: it ]. "Supongamos que it debe ser el usuario (?"
	userName := nil.
	password := nil
]

{ #category : #callbacks }
LoginComponent >> logout [
	self session unregister.
	self requestContext redirectTo: self application url
]

{ #category : #callbacks }
LoginComponent >> registerNewUser [
	self call: RegisterComponent new.
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
	aCanvas space: 25.
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
