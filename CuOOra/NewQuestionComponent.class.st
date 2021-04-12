Class {
	#name : #NewQuestionComponent,
	#superclass : #CuOOraHomeComponent,
	#instVars : [
		'titulo',
		'texto',
		'topicos'
	],
	#category : #'CuOOra-ui'
}

{ #category : #callbacks }
NewQuestionComponent >> goBackHome [
	self answer 
]

{ #category : #rendering }
NewQuestionComponent >> registrar [
	CuOOra soleInstance agregarPreguntaATopico: ((self topicos) asOrderedCollection)  yUsuario: (self session user) conTitulo: (self titulo)  conDescripcion: (self texto).
	self goBackHome .
	
]

{ #category : #rendering }
NewQuestionComponent >> renderButtonsOn: aCanvas [
	aCanvas button 
		callback: [ self goBackHome  ];
		with: 'Cancelar'.
	aCanvas space: 5.
	aCanvas submitButton 
		callback: [ self registrar ];
		with: 'Guardar'
]

{ #category : #rendering }
NewQuestionComponent >> renderContentOn: aCanvas [
	self renderLoggedUser: aCanvas.
	aCanvas horizontalRule .
	aCanvas heading level:2 ; with: 'Nueva pregunta'.
	aCanvas form:[
		self renderInputElementsOn: aCanvas.
		aCanvas break.
		self renderButtonsOn: aCanvas.
		].
	aCanvas horizontalRule.
]

{ #category : #rendering }
NewQuestionComponent >> renderInputElementsOn: aCanvas [
		
		aCanvas paragraph: [ 
			aCanvas label: 'Titulo:' ].
		aCanvas paragraph: [ 
			aCanvas space: 10.
			aCanvas textArea
				columns: 80;
				rows: 3;
				callback: [ :valorNuevo | self titulo: valorNuevo ];
				with: 'Escriba aqui el titulo de su pregunta.' ].
	
		aCanvas break.
		
		aCanvas paragraph: [ 
			aCanvas label: 'Desarrollo:' ].
		aCanvas paragraph: [ 
			aCanvas space: 10.
			aCanvas textArea
				columns:80;
				rows:7;
				callback: [ :valorNuevo | self texto: valorNuevo ];
				with: 'Escriba aqui el desarrollo de su pregunta.' ].
		
		aCanvas paragraph:[
			aCanvas label:'Topicos:'].
		aCanvas space: 10.
		aCanvas multiSelect
 			list: (CuOOra soleInstance) topicos ;
 			selected: topicos;
 			callback: [ :valores | self topicos: valores ].
	
]

{ #category : #accessing }
NewQuestionComponent >> texto [ 
	^ texto 
]

{ #category : #accessing }
NewQuestionComponent >> texto: text [ 
	texto := text
]

{ #category : #accessing }
NewQuestionComponent >> titulo [ 
	^ titulo 
]

{ #category : #accessing }
NewQuestionComponent >> titulo: title [ 
	titulo := title
]

{ #category : #accessing }
NewQuestionComponent >> topicos [
	^ topicos 
]

{ #category : #accessing }
NewQuestionComponent >> topicos: topics [ 
	topicos := topics
]
