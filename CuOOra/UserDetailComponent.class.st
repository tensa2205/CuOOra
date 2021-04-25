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
	self session user seguirUsuario: usuario.  
]

{ #category : #rendering }
UserDetailComponent >> renderContentOn: aCanvas [
	aCanvas div
	class: 'container';
	with:[ 
		aCanvas div 
			class: 'row';
			with:
			[
			aCanvas div
				class: 'col align-self-center';
				with: [ 
					self renderLoggedUser: aCanvas.
					aCanvas horizontalRule.
					self renderDetailsOn: aCanvas.
					]]]
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
			(self usuario preguntasHechas )
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
