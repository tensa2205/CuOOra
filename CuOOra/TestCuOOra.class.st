Class {
	#name : #TestCuOOra,
	#superclass : #TestCase,
	#instVars : [
		'sistema'
	],
	#category : #'CuOOra-tests'
}

{ #category : #running }
TestCuOOra >> setUp [
	sistema := CuOOra new.
	
	
	

]

{ #category : #tests }
TestCuOOra >> testAgregarPreguntaTopico [
	|topicAux|
	sistema agregarTopicoConNombre: 'General' descripcion: 'Foro de discusion general'.
	sistema crearUsuarioConNombre: 'El pepe' contraseña: '123'. 
	sistema agregarPreguntaATopico: sistema topicos yUsuario: sistema usuarios first  conTitulo: 'p1'  conDescripcion: 'dp1'.
	
	topicAux := sistema topicos first.
	self assert: topicAux preguntas size equals: 1
]

{ #category : #tests }
TestCuOOra >> testCrearTopico [
	sistema agregarTopicoConNombre: 'General' descripcion: 'Foro de discusion general'.
	self assert: sistema topicos size equals: 1.
]

{ #category : #tests }
TestCuOOra >> testCrearUsuario [
	sistema crearUsuarioConNombre: 'El pepe' contraseña: '123'.
	sistema crearUsuarioConNombre: 'La moni' contraseña: '456'.
	self assert: (sistema usuarios) size equals: 2.
	
]

{ #category : #tests }
TestCuOOra >> testDevolverPuntajeDeUsuario [
	|pepe moni topics respuestas p1 p2 p3 p4 r1 r2|
	sistema agregarTopicoConNombre: 'General' descripcion: 'Un topico'.
	sistema 
		crearUsuarioConNombre: 'El pepe' contraseña: '1';
		crearUsuarioConNombre: 'La moni' contraseña: '2'. 
	
	pepe := sistema usuarios at: 1.
	moni := sistema usuarios at: 2.
	
	topics := sistema topicos.
	
	"Preguntas y obtenciones de las mismas."
	sistema 
		agregarPreguntaATopico: topics yUsuario: moni  conTitulo: 'Contesten' conDescripcion: 'UwU' ; "p1"
		agregarPreguntaATopico: topics yUsuario: moni  conTitulo: 'Contesten mi segunda' conDescripcion: 'UwU v2'; "p2"
		agregarPreguntaATopico: topics yUsuario: pepe  conTitulo: 'Stop it moni, get some help' conDescripcion: 'Vea el titulo'; "p3"
		agregarPreguntaATopico: topics yUsuario: pepe  conTitulo: 'Les paso este temazo' conDescripcion: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ'. "p4" 
	
	p1 := topics first preguntas at:  1.
	p2 := topics first preguntas at:  2.
	p3 := topics first preguntas at:  3.
	p4 := topics first preguntas at:  4.
	
	p3
		darLike: '1';
		darLike: '2';
		darLike: '3';
		darLike: '4';
		darLike: '5';
		darDislike: '6';
		darDislike: '7'.
	
	p4
		darLike: '1';
		darLike: '2';
		darLike: '3';
		darLike: '4';
		darLike: '5';
		darDislike: '6';
		darDislike: '7'.
	
	"Respuestas y obtenciones de las mismas."
	sistema
		agregarRespuestaDeUsuario: pepe aPregunta: p1 conTexto: 'Contesto pregunta 1, over';
		agregarRespuestaDeUsuario: pepe aPregunta: p2 conTexto: 'Contesto pregunta 2, over';
		agregarRespuestaDeUsuario: pepe aPregunta: p3 conTexto: 'Esta respuesta no deberia contar en el puntaje.'.
	
	respuestas := sistema obtenerRespuestasHechasDeUsuario: pepe.
	self assert: respuestas size equals: 2.
	
	r1 := respuestas at: 1.
	r2 := respuestas at: 2.
	self 
		assert: r1 texto equals: 'Contesto pregunta 1, over';
		assert: r2 texto equals: 'Contesto pregunta 2, over'.
	r1
		darLike: '1';
		darLike: '2'.
	r2
		darLike: '1';
		darLike: '2'.
	
	self assert: (sistema devolverPuntajeDeUsuario: pepe) equals: 150
	
	
	  
]

{ #category : #tests }
TestCuOOra >> testObtenerRespuestasUsuario [
	| u1 u2 p1 p2 p3 preguntasTopico respuestas|
	sistema agregarTopicoConNombre: 'General' descripcion: 'Discusion general'.
	sistema 
		crearUsuarioConNombre: 'User1' contraseña: '1';
		crearUsuarioConNombre: 'User2' contraseña: '2'.
	
	u1 := sistema usuarios at: 1.
	u2 := sistema usuarios at: 2.
	
	sistema 
		agregarPreguntaATopico: sistema topicos yUsuario: u1 conTitulo: 'Primer pregunta' conDescripcion: 'd1';
		agregarPreguntaATopico: sistema topicos yUsuario: u1 conTitulo: 'Segunda pregunta' conDescripcion: 'd2';
	 	agregarPreguntaATopico: sistema topicos yUsuario: u2 conTitulo: 'Tercer pregunta' conDescripcion: 'd3'.
	
	preguntasTopico := (sistema topicos first) preguntas .
	p1 := preguntasTopico at: 1.
	p2 := preguntasTopico at: 2.
	p3 := preguntasTopico at: 3.
	self 
		assert: p1 titulo equals: 'Primer pregunta';
		assert: p2 titulo equals: 'Segunda pregunta';
		assert: p3 titulo equals: 'Tercer pregunta'.
	
	sistema 
		agregarRespuestaDeUsuario: u2 aPregunta: p1 conTexto: 'Respuesta p1';
		agregarRespuestaDeUsuario: u2 aPregunta: p2 conTexto: 'Respuesta p2';
		agregarRespuestaDeUsuario: u2 aPregunta: p3 conTexto: 'Respuesta p3'.
	
	respuestas := sistema obtenerRespuestasHechasDeUsuario: u2.
	self assert: (respuestas at: 1) texto equals:'Respuesta p1'.
	self assert: (respuestas at: 2) texto equals:'Respuesta p2'.
	
	self assert: respuestas size equals:2
		
	
	
]
