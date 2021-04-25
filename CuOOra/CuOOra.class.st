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
	soleInstance ifNil: [ soleInstance := self new instanciaPrueba ].
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

{ #category : #topicos }
CuOOra >> agregarTopicoConNombre: nom descripcion: desc [
	(topicos anySatisfy: [ :topico | topico nombre = nom ])
	ifTrue: [ ^ nil ].
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
	| usuario |
	topicos do: [ : topico | topico bajaPregunta: pregunta ].
	usuario := pregunta usuario .
	usuario bajaPregunta: pregunta
	
	
]

{ #category : #topicos }
CuOOra >> comprobarExistenciaTopico: nombreTopico [
	^ topicos detect: [ :topic | topic comprobarNombre: nombreTopico  ] ifNone: [ ^ nil ] 
]

{ #category : #usuarios }
CuOOra >> crearUsuarioConNombre: nom contraseña: password [
	(usuarios anySatisfy: [ :usuario | usuario nombreUsuario = nom ])
	ifTrue: [ ^ nil ].
	^ usuarios add: (Usuario nombreUsuario: nom contraseña: password)
]

{ #category : #usuarios }
CuOOra >> devolverPuntajeDeUsuario: user [
	^ (self devolverPuntajeRespuestas: user) + user devolverPuntajePreguntas 

	
]

{ #category : #usuarios }
CuOOra >> devolverPuntajeRespuestas: user [ 
	^ (self obtenerRespuestasHechasDeUsuario: user) sumNumbers: [ :respuesta | respuesta calcularPuntaje  ]
]

{ #category : #initialization }
CuOOra >> initialize [
	usuarios := OrderedCollection new.
	topicos := OrderedCollection new
]

{ #category : #'instancia-prueba' }
CuOOra >> instanciaPrueba [
	| pedro diego juan preguntaP preguntaD topicoOO topicoTest topicoCharlita colec1 colec2|
	pedro := self crearUsuarioConNombre: 'pedro@cuoora.com' contraseña: 'pedro@cuoora.com'.
	diego := self crearUsuarioConNombre: 'diego@cuoora.com' contraseña: 'diego@cuoora.com'.
	juan := self crearUsuarioConNombre: 'juan@cuoora.com' contraseña: 'juan@cuoora.com'.
	
	topicoOO := self agregarTopicoConNombre: 'OO1' descripcion: 'Soy OO1'.
	topicoTest := self agregarTopicoConNombre: 'Test de unidad' descripcion: 'Soy topico de test de unidad'.
	topicoCharlita := self agregarTopicoConNombre: 'Smalltalk' descripcion: 'Soy smalltalk, podés llamarme... CHARLITA'.
	
	colec1 := OrderedCollection new.
	colec2 := OrderedCollection new.
	
	colec1
		add:topicoOO;
		add:topicoTest.
	colec2
		add:topicoOO;
		add:topicoCharlita.
	
	"Juan sigue a Diego"
	juan seguirUsuario: diego.
	"Pedro sigue a Juan"
	pedro seguirUsuario: juan.
	
	
	
	"Pregunta de pedro"
	preguntaP := self agregarPreguntaATopico: colec1  yUsuario: pedro conTitulo: '¿Para que sirve el metodo setUp?' conDescripcion: 'Exacto, para que me sirve.' .
	preguntaP agregarRespuestaConTexto: 'Sirve para instanciar los objetos que son
							evaluados por el test en un único método y que se ejecute siempre antes de cada test.'
							usuario: diego.
							
	"Pregunta de diego"
	preguntaD := self agregarPreguntaATopico: colec2  yUsuario: diego  conTitulo: '¿Que significa #messageNotUnderstood?' conDescripcion: 'No se que significa.' .
	preguntaD agregarRespuestaConTexto: 'Significa que el objeto que recibió el mensaje no encontró ningún método para ejecutar en respuesta.' usuario: pedro
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

{ #category : #usuarios }
CuOOra >> obtenerRespuestasHechasDeUsuario: user [
	" ESTE MÉTODO SE USA PARA EL CALCULO DE PUNTAJE DE UN USUARIO. "
	^ (usuarios reject: [ : usuarioRechazar | usuarioRechazar == user ] thenCollect: [ : usuario | usuario devolverRespuestasDeUsuarioEspecifico: user ]) flattened
]

{ #category : #accessing }
CuOOra >> obtenerTopicosDePregunta: preg [
	^ (topicos select: [:topico | topico tienePregunta: preg]) collect: [ :each | each nombre ]
]

{ #category : #usuarios }
CuOOra >> todasLasRespuestasDeUsuario: user [
	"Este método incluye también las respuestas que un usuario hace a sus propias preguntas. Tal como se pide en el enunciado"
	^ (usuarios collect: [ :usuario | usuario devolverRespuestasDeUsuarioEspecifico: user]) flattened 
]

{ #category : #accessing }
CuOOra >> topicos [
	^ topicos
]

{ #category : #usuarios }
CuOOra >> usuarios [
	^ usuarios
]
