Class {
	#name : #CuOOraHomeComponent,
	#superclass : #WAComponent,
	#category : #'CuOOra-ui'
}

{ #category : #callbacks }
CuOOraHomeComponent >> logout [
	self call: (LoginComponentWithStyle new logout ; yourself)
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
		class: 'btn btn-secondary btn-lg ml-5 mb-4';
		callback: [ self newQuestion  ];
		with: 'HACE UNA NUEVA PREGUNTA FLACO.'.
	aCanvas break.
	self renderLastQuestions: aCanvas.
]

{ #category : #rendering }
CuOOraHomeComponent >> renderLastQuestions: aCanvas [
	aCanvas heading level:2 ; with: 'Ultimas preguntas'.
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

{ #category : #updating }
CuOOraHomeComponent >> updateRoot: anHtmlRoot [
    super updateRoot: anHtmlRoot.
    anHtmlRoot stylesheet url: 'https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css'
	
]
