"
""Expresion a evaluar para registrar la aplicación:""
    (WAAdmin register: LoginComponent asApplicationAt: 'CuOOra') sessionClass: SessionWithUser .

""Para limpiar la instancia única:""
    CuOOra clearSoleInstance .

""Para crear la instancia única:""
    CuOOra soleInstance .
"
Class {
	#name : #LoginComponent,
	#superclass : #AccessGrantingComponent,
	#category : #'CuOOra-ui'
}

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
