"
!Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:

For the Class part:  State a one line summary. For example, ""I represent a paragraph of text"".

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	descripcion:		<Object>
	nombre:		<Object>
	preguntas:		<Object>


    Implementation Points
"
Class {
	#name : #Topico,
	#superclass : #Object,
	#instVars : [
		'nombre',
		'descripcion',
		'preguntas'
	],
	#category : #'CuOOra-model'
}

{ #category : #constructor }
Topico class >> nombre: nom  descripcion: desc [
	^ self new nombre: nom descripcion: desc
]

{ #category : #converting }
Topico >> asString [ 
	^ self nombre 
]

{ #category : #accessing }
Topico >> bajaPregunta: pregunta [
	preguntas remove: pregunta ifAbsent: [ false ].
]

{ #category : #accessing }
Topico >> descripcion [
	^ descripcion
]

{ #category : #initialization }
Topico >> initialize [
	preguntas := OrderedCollection new
]

{ #category : #accessing }
Topico >> nombre [
	^ nombre
]

{ #category : #constructor }
Topico >> nombre: nom descripcion: desc [
	nombre := nom.
	descripcion := desc.
	self initialize
]

{ #category : #accessing }
Topico >> preguntas [
	^ preguntas
]

{ #category : #accessing }
Topico >> registrarPregunta: pregunta [ 
	preguntas add: pregunta
]

{ #category : #accessing }
Topico >> tienePregunta: preg [ 
	^ (preguntas includes: preg)
]
