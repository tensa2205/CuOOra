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
	topicos:		<Object>
	usuarios:		<Object>


    Implementation Points
"
Class {
	#name : #CuOOra,
	#superclass : #Object,
	#instVars : [
		'usuarios',
		'topicos'
	],
	#classInstVars : [
		'soleInstance'
	],
	#category : #'CuOOra-model'
}

{ #category : #'instance creation' }
CuOOra class >> clearSoleInstance [
	soleInstance := nil
]

{ #category : #'instance creation' }
CuOOra class >> soleInstance [
	soleInstance ifNil: [ soleInstance := self new ].
	^ soleInstance 
]

{ #category : #accessing }
CuOOra >> agregarPreguntaATopico: topics yUsuario: user conTitulo: title conDescripcion: desc [
	| preg |
	preg := Pregunta titulo: title texto: desc usuario: user.
	user registrarPregunta: preg.
	topics do: [ :topic | topic registrarPregunta: preg ].
	^ preg
]

{ #category : #accessing }
CuOOra >> agregarRespuestaDeUsuario: user aPregunta: preg conTexto: text [
	^ (preg agregarRespuestaConTexto: text usuario: user )
]

{ #category : #topicos }
CuOOra >> agregarTopicoConNombre: nom descripcion: desc [
	(topicos anySatisfy: [ :topico | topico nombre = nom ])
	ifTrue: [ ^ self ].
	^ topicos add: (Topico nombre: nom descripcion: desc)
]

{ #category : #usuarios }
CuOOra >> autenticarUsuarioConNombre: unNombre protegidoPor: unaPassword [
	^ usuarios
		detect: [ :user | user nombreUsuario = unNombre & (user contraseña = unaPassword)  ] 
		ifNone: [ nil ]
]

{ #category : #accessing }
CuOOra >> borrarPregunta: pregunta [
	"Es necesario recorrer cada tópico para ver si la pregunta está ahí? Esto podría evitarlo haciendo una dirección bidireccional, Pero que tan sano sería usar una relación así?"
	| usuario |
	topicos do: [ : topico | topico bajaPregunta: pregunta ].
	usuario := pregunta usuario .
	usuario bajaPregunta: pregunta
	
	
]

{ #category : #usuarios }
CuOOra >> crearUsuarioConNombre: nom contraseña: password [
	(usuarios anySatisfy: [ :usuario | usuario nombreUsuario = nom ])
	ifTrue: [ ^ self ].
	^ usuarios add: (Usuario nombreUsuario: nom contraseña: password)
]

{ #category : #usuarios }
CuOOra >> devolverPuntajeDeUsuario: user [
	| respuestas diferenciaLYD|
	respuestas := self obtenerRespuestasHechasDeUsuario: user.
	diferenciaLYD := respuestas sumNumbers: [ : respuesta | respuesta devolverDiferenciaReacciones  ].
	^ ( ( (respuestas size * 50) + diferenciaLYD) + user devolverPuntajePreguntas  )

	
]

{ #category : #initialization }
CuOOra >> initialize [
	usuarios := OrderedCollection new.
	topicos := OrderedCollection new
]

{ #category : #topicos }
CuOOra >> obtenerPreguntasDeTopico: topic [
	^ topic preguntas
]

{ #category : #usuarios }
CuOOra >> obtenerPreguntasHechasDeUsuario: user [
	^ user preguntasHechas
]

{ #category : #usuarios }
CuOOra >> obtenerPreguntasRelevantesDeUsuario: user [
	| relevantes |
	relevantes := user devolverPreguntasRelevantes.
	relevantes := relevantes sort:[ :pregunta1 :pregunta2 | pregunta1 devolverFecha > pregunta2 devolverFecha ].
	(relevantes size < 5)
	ifTrue:[^ relevantes].
	^ relevantes collect: [ :each | each ] from: 1 to: 5
]

{ #category : #accessing }
CuOOra >> obtenerRespuestasDePregunta: preg [
	^ preg respuestas
]

{ #category : #usuarios }
CuOOra >> obtenerRespuestasHechasDeUsuario: user [
	"Reject then Collect lo que hace es ver la colección de tal forma que estén todos los usuarios menos aquel usuario donde usuarioRechazar == user haya evaluado true.
	Esto permite que se procesen todos los usuarios excepto el usuario que pasamos como parámetro (de tal forma que no tomemos respuestas a preguntas que hizo el mismo usuario)."
	^ (usuarios reject: [ : usuarioRechazar | usuarioRechazar == user ] thenCollect: [ : usuario | usuario devolverRespuestasDeUsuarioEspecifico: user ]) flatCollect: [ : each | each ]
]

{ #category : #accessing }
CuOOra >> obtenerTopicosDePregunta: preg [
	^ (topicos select: [:topico | topico tienePregunta: preg]) collect: [ :each | each nombre ]
]

{ #category : #accessing }
CuOOra >> registrarDislikeDeUsuario: user aPost: post [
	post darDislike: user
]

{ #category : #accessing }
CuOOra >> registrarLikeDeUsuario: user aPost: post [
	post darLike: user
]

{ #category : #accessing }
CuOOra >> registrarTopicoDeInteres: topic paraUsuario: user [
	user registrarTopicoDeInteres: topic
]

{ #category : #usuarios }
CuOOra >> seguirUsuario: usuarioSeguir conUsuario: seguidor [
	seguidor seguirUsuario: usuarioSeguir
]

{ #category : #accessing }
CuOOra >> topicos [
	^ topicos
]

{ #category : #usuarios }
CuOOra >> usuarios [
	^ usuarios
]
