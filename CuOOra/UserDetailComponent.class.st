Class {
	#name : #UserDetailComponent,
	#superclass : #CuOOraHomeComponent,
	#instVars : [
		'usuario'
	],
	#category : #'CuOOra-ui'
}

{ #category : #callbacks }
UserDetailComponent >> follow [
	self model  seguirUsuario: usuario conUsuario: (self session user)  
]

{ #category : #rendering }
UserDetailComponent >> renderContentOn: aCanvas [
	self renderLoggedUser: aCanvas.
	aCanvas horizontalRule.
	self renderDetailsOn: aCanvas.
	
]

{ #category : #rendering }
UserDetailComponent >> renderDetailsOn: aCanvas [
	self renderUserHeadOn: aCanvas.
	self renderUserQuestionsOn: aCanvas
]

{ #category : #rendering }
UserDetailComponent >> renderUserHeadOn: aCanvas [
	aCanvas paragraph: [ 
		aCanvas heading 
				level: 2;
				with: 'Preguntas de ' , usuario nombreUsuario . 
		aCanvas space: 2.
		aCanvas anchor
			callback:[self follow];
			with: 'follow'.
	].
	aCanvas break.
]

{ #category : #rendering }
UserDetailComponent >> renderUserQuestionsOn: aCanvas [
	aCanvas
		unorderedList: [ 
			(self model obtenerPreguntasHechasDeUsuario: self usuario)
				do:[ :each | 
					(self renderQuestion: each with: aCanvas)].
		].
]

{ #category : #accessing }
UserDetailComponent >> usuario [ 
	^ usuario
]

{ #category : #accessing }
UserDetailComponent >> usuario: anUser [ 
	usuario := anUser
]
