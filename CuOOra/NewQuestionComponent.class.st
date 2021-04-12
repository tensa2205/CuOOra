Class {
	#name : #NewQuestionComponent,
	#superclass : #WAComponent,
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
		class:'btn btn-danger ml-4'; 
		callback: [ self goBackHome  ];
		with: 'Cancelar'.
	aCanvas submitButton 
		class:'btn btn-success ml-3';
		callback: [ self registrar ];
		with: 'Guardar'
]

{ #category : #rendering }
NewQuestionComponent >> renderContentOn: aCanvas [
	aCanvas heading: 'CuOOra'.
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
		
		
		 aCanvas div
			class: 'form-group col-6';
			with:[
			 	aCanvas text: 'Titulo'.
		  		aCanvas textInput 
				class: 'form-control required ml-4';	
				callback: [ :valorNuevo | self titulo: valorNuevo ]].
				aCanvas break.	
		
		 aCanvas div
			class: 'form-group col-6';
			with:[
			 	aCanvas text: 'Descripcion'.
		  		aCanvas textArea 
				class: 'form-control required ml-4';	
				rows:4;
				callback: [ :valorNuevo | self texto: valorNuevo ]].
				aCanvas break.	
					
		 aCanvas div
			class: 'form-group col-2';
			with:[
				aCanvas text:'Seleccione topicos'.
				aCanvas multiSelect
					class:'form-control ml-4';
 					list: (CuOOra soleInstance) topicos ;
 					selected: topicos;
 					callback: [ :valores | self topicos: valores ].
				]
						
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

{ #category : #updating }
NewQuestionComponent >> updateRoot: anHtmlRoot [
    super updateRoot: anHtmlRoot.
    anHtmlRoot stylesheet url: 'https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css'
	
]
