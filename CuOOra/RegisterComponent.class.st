Class {
	#name : #RegisterComponent,
	#superclass : #AccessGrantingComponent,
	#category : #'CuOOra-ui'
}

{ #category : #rendering }
RegisterComponent >> registerAndLogin [
	| newUser |
	newUser := Usuario nombreUsuario: userName  contraseña: password .
	self model crearUsuarioConNombre: (newUser nombreUsuario) contraseña: (newUser contraseña)  .
	self proceedWith: newUser   
]

{ #category : #rendering }
RegisterComponent >> renderButtonsOn: aCanvas [
	self renderSignUpButtonOn: aCanvas
]

{ #category : #rendering }
RegisterComponent >> renderSignUpButtonOn: aCanvas [
	aCanvas submitButton 
		callback: [ self registerAndLogin ];
		with: 'Registrarse'
]
