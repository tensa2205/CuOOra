Class {
	#name : #CuOOraHomeComponent,
	#superclass : #WAComponent,
	#category : #'CuOOra-ui'
}

{ #category : #callbacks }
CuOOraHomeComponent >> logout [
	self call: (LoginComponent new logout ; yourself)
]

{ #category : #callbacks }
CuOOraHomeComponent >> newQuestion [
	self call: NewQuestionComponent new.
]

{ #category : #rendering }
CuOOraHomeComponent >> renderContentOn: aCanvas [
	self renderLoggedUser: aCanvas.
	aCanvas horizontalRule .
	aCanvas anchor
		callback: [ self newQuestion  ];
		with: 'HACE UNA NUEVA PREGUNTA FLACO.'.
	aCanvas break.
	self renderLastQuestions: aCanvas.
]

{ #category : #rendering }
CuOOraHomeComponent >> renderLastQuestions: aCanvas [
	aCanvas heading: 'Ultimas preguntas'.
	aCanvas
		unorderedList: [ 
			((CuOOra soleInstance) obtenerPreguntasRelevantesDeUsuario: self session user)
				do:[ :each | 
					aCanvas emphasis: each titulo .
					aCanvas paragraph: [ 
						aCanvas text: 'Realizada por '.
						aCanvas strong: (each usuario) nombreUsuario.
						aCanvas text: ' | ', each 						devolverCantidadRespuestas asString , ' respuestas'
						].
					aCanvas text: each cantLikes asString, ' likes', ' | ', each cantDislikes asString, ' dislikes' . 
					aCanvas horizontalRule . ].	 
				]
	
]

{ #category : #rendering }
CuOOraHomeComponent >> renderLoggedUser: aCanvas [
	aCanvas heading:'CuooRa'.
	
	aCanvas paragraph: [  
		aCanvas space: 50.
		aCanvas text: self session user nombreUsuario.
		aCanvas space: 3.
		aCanvas anchor
			callback: [self logout ];
			with: 'Log out'.
		].
]
