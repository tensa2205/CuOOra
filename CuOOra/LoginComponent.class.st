"
Expresion a evaluar para registrar la aplicacion
    (WAAdmin register: LoginComponent asApplicationAt: 'CuOOra') sessionClass: SessionWithUser .

Metodos para limpiar la instancia unica.
    CuOOra clearSoleInstance .

Metodo para crear una instancia unica de prueba:
    CuOOra soleInstance
"
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
	(CuOOra soleInstance  autenticarUsuarioConNombre: userName  protegidoPor: password ) "Si existe dicho usuario, lo devuelve"
		ifNotNil: [ :it | self proceedWith: it ]. "Supongamos que it debe ser el usuario (?"
	userName := nil.
	password := nil
]

{ #category : #rendering }
LoginComponent >> renderButtonsOn: aCanvas [
	self renderSignInButtonOn: aCanvas.
	aCanvas horizontalRule.
]

{ #category : #rendering }
LoginComponent >> renderSignInButtonOn: aCanvas [
	aCanvas space: 25.
	aCanvas submitButton 
		callback: [ self login ];
		with: 'Iniciar sesion'
]
