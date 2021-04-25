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
	contraseña:		<Object>
	nombreUsuario:		<Object>
	seguidos:		<Object>
	timeStamp:		<Object>


    Implementation Points
"
Class {
	#name : #Usuario,
	#superclass : #Object,
	#instVars : [
		'nombreUsuario',
		'contraseña',
		'timeStamp',
		'seguidos',
		'topicosInteres',
		'preguntasHechas'
	],
	#category : #'CuOOra-model'
}

{ #category : #constructor }
Usuario class >> nombreUsuario: arg1 contraseña: arg2 [
	^ self new nombreUsuario: arg1 contraseña: arg2
]

{ #category : #accessing }
Usuario >> bajaPregunta: pregunta [ 
	preguntasHechas remove: pregunta ifAbsent: [ false ]
	
	
]

{ #category : #accessing }
Usuario >> contraseña [
	^ contraseña
]

{ #category : #accessing }
Usuario >> devolverPreguntasRelevantes [

	^ ((seguidos collect:[: seguido | seguido preguntasHechas ]) union: (topicosInteres collect:[:topico | topico preguntas ])) flattened.
	"| relevantes |
	relevantes := OrderedCollection new.
	relevantes addAll:  (seguidos collect:[: seguido | seguido preguntasHechas ]).
	relevantes addAll:  (topicosInteres collect:[:topico | topico preguntas ]).
	relevantes := relevantes flatCollect: [ : each | each ].
	^ relevantes removeDuplicates "

	

]

{ #category : #accessing }
Usuario >> devolverPuntajePreguntas [
	^ preguntasHechas sumNumbers: [ :pregunta | pregunta calcularPuntaje  ]
]

{ #category : #accessing }
Usuario >> devolverRespuestasDeUsuarioEspecifico: user [
	^ (preguntasHechas
		collect: [ :preg | preg devolverRespuestasUsuario: user ]) flattened 
]

{ #category : #initialization }
Usuario >> initialize [
	seguidos := Set new.
	topicosInteres := OrderedCollection new.
	preguntasHechas := OrderedCollection new
]

{ #category : #accessing }
Usuario >> nombreUsuario [
	^ nombreUsuario
]

{ #category : #constructor }
Usuario >> nombreUsuario: nom contraseña: password [
	nombreUsuario := nom.
	contraseña := password.
	timeStamp := DateAndTime now.
]

{ #category : #accessing }
Usuario >> preguntasHechas [
	^ preguntasHechas
]

{ #category : #accessing }
Usuario >> registrarPregunta: pregunta [
	preguntasHechas add: pregunta
]

{ #category : #accessing }
Usuario >> registrarTopicoDeInteres: topico [
	topicosInteres add: topico
]

{ #category : #accessing }
Usuario >> seguidos [
	^ seguidos
]

{ #category : #accessing }
Usuario >> seguirUsuario: user [
	seguidos add: user
]

{ #category : #accessing }
Usuario >> topicosInteres [
	^ topicosInteres
]
