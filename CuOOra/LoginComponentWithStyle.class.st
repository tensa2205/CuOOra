Class {
	#name : #LoginComponentWithStyle,
	#superclass : #AccessGrantingComponentWithStyle,
	#category : #'CuOOra-ui'
}

{ #category : #'app-initialization' }
LoginComponentWithStyle class >> initialize [
	| application |
	application := WAAdmin register: self asApplicationAt: 'CuOOra'.
	application sessionClass: SessionWithUser .
	
]

{ #category : #callbacks }
LoginComponentWithStyle >> login [
	(self model autenticarUsuarioConNombre: userName  protegidoPor: password ) "Si existe dicho usuario, lo devuelve"
		ifNotNil: [ :it | self proceedWith: it ]. "Supongamos que it debe ser el usuario (?"
	userName := nil.
	password := nil
]

{ #category : #callbacks }
LoginComponentWithStyle >> logout [
	self session unregister.
	self requestContext redirectTo: self application url
]

{ #category : #callbacks }
LoginComponentWithStyle >> registerNewUser [
	self call: RegisterComponent new.
]

{ #category : #rendering }
LoginComponentWithStyle >> renderButtonsOn: aCanvas [
	self renderSignInButtonOn: aCanvas.
	aCanvas horizontalRule.
	aCanvas paragraph: 'No tenes una cuenta?'.
	self renderSignUpButtonOn: aCanvas.
]

{ #category : #rendering }
LoginComponentWithStyle >> renderSignInButtonOn: aCanvas [
	aCanvas space: 25.
	aCanvas submitButton
		class: 'btn btn-primary';
		callback: [ self login ];
		with: 'Iniciar sesion'
]

{ #category : #rendering }
LoginComponentWithStyle >> renderSignUpButtonOn: aCanvas [
	aCanvas submitButton 
	class: 'btn btn-success';
		callback: [ self registerNewUser ];
		with: 'Registrate, ES GRATAROLA'
]
