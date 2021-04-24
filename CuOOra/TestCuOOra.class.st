Class {
	#name : #TestCuOOra,
	#superclass : #TestCase,
	#instVars : [
		'sistema',
		'topico',
		'user1',
		'user2'
	],
	#category : #'CuOOra-tests'
}

{ #category : #running }
TestCuOOra >> setUp [
	sistema := CuOOra new.
	topico := sistema agregarTopicoConNombre: 'General' descripcion: 'Discusión General'.
	user1 := sistema crearUsuarioConNombre: 'El pepe' contraseña: '1'.
	user2 := sistema crearUsuarioConNombre: 'La moni' contraseña: '2'.
	
	
	

]

{ #category : #tests }
TestCuOOra >> testAgregarPreguntaTopico [
	sistema agregarPreguntaATopico: sistema topicos yUsuario: user1  conTitulo: 'p1'  conDescripcion: 'dp1'.
	self assert: topico preguntas size equals: 1
]

{ #category : #tests }
TestCuOOra >> testCrearTopico [
	sistema agregarTopicoConNombre: 'General' descripcion: 'Foro de discusion general'.
	self assert: sistema topicos size equals: 1.
]

{ #category : #tests }
TestCuOOra >> testCrearUsuario [
	self assert: (sistema usuarios) size equals: 2.
	
]

{ #category : #tests }
TestCuOOra >> testDevolverPuntajeDeUsuario [
	|topics p1 p2 p3 p4 r1 r2|
	topics := sistema topicos.
			
	p1 := sistema agregarPreguntaATopico: topics yUsuario: user2  conTitulo: 'Contesten' conDescripcion: 'UwU'.
	p2 := sistema agregarPreguntaATopico: topics yUsuario: user2  conTitulo: 'Contesten mi segunda' conDescripcion: 'UwU v2'.
	p3 := sistema agregarPreguntaATopico: topics yUsuario: user1  conTitulo: 'Stop it moni, get some help' conDescripcion: 'Vea el titulo'.
	p4 := sistema agregarPreguntaATopico: topics yUsuario: user1  conTitulo: 'Les paso este temazo' conDescripcion: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ'.
		
	
	p3
		recibirReaccion: true deUn: '1';
		recibirReaccion: true deUn: '2'; 
		recibirReaccion: true deUn: '3'; 
		recibirReaccion: true deUn: '4'; 
		recibirReaccion: true deUn: '5';
		recibirReaccion: false deUn: '6';
		recibirReaccion: false deUn: '7'. 
	p4
		recibirReaccion: true deUn: '1';
		recibirReaccion: true deUn: '2'; 
		recibirReaccion: true deUn: '3'; 
		recibirReaccion: true deUn: '4'; 
		recibirReaccion: true deUn: '5';
		recibirReaccion: false deUn: '6';
		recibirReaccion: false deUn: '7'. 
	
	"Respuestas y obtenciones de las mismas."
	r1 := sistema agregarRespuestaDeUsuario: user1 aPregunta: p1 conTexto: 'Contesto pregunta 1, over'.
	r2 := sistema agregarRespuestaDeUsuario: user1 aPregunta: p2 conTexto: 'Contesto pregunta 2, over'.
	sistema agregarRespuestaDeUsuario: user1 aPregunta: p3 conTexto: 'Esta respuesta no deberia contar en el puntaje.'.
	
	r1
		recibirReaccion: true deUn: '1';
		recibirReaccion: true deUn: '2'.
	r2
		recibirReaccion: true deUn: '1';
		recibirReaccion: true deUn: '2'. 
	
	self assert: (sistema devolverPuntajeDeUsuario: user1) equals: 150
	
	
	  
]

{ #category : #tests }
TestCuOOra >> testObtenerRespuestasUsuario [
	|p1 p2 p3 respuestas|
		 	
	p1 := sistema agregarPreguntaATopico: sistema topicos yUsuario: user1 conTitulo: 'Primer pregunta' conDescripcion: 'd1'.
	p2 := sistema agregarPreguntaATopico: sistema topicos yUsuario: user1 conTitulo: 'Segunda pregunta' conDescripcion: 'd2'.
	p3 := sistema agregarPreguntaATopico: sistema topicos yUsuario: user2 conTitulo: 'Tercer pregunta' conDescripcion: 'd3'.
		
	sistema 
		agregarRespuestaDeUsuario: user2 aPregunta: p1 conTexto: 'Respuesta p1';
		agregarRespuestaDeUsuario: user2 aPregunta: p2 conTexto: 'Respuesta p2';
		agregarRespuestaDeUsuario: user2 aPregunta: p3 conTexto: 'Respuesta p3'.
	
	respuestas := sistema obtenerRespuestasHechasDeUsuario: user2.
	
	self assert: respuestas size equals:2
		
	
	
]

{ #category : #tests }
TestCuOOra >> testObtenerTopicosDePregunta [
	| t2 colec pregunta|
	t2 := sistema agregarTopicoConNombre: 'Soy el segundo topico' descripcion: 'Yo cuento en los calculos!!!'.
	sistema agregarTopicoConNombre: 'Soy el tercer topico' descripcion: 'Yo no cuento en los calculos.'.
	
	colec := OrderedCollection new.
	colec
		add:topico;
		add:t2.
	
	pregunta := sistema agregarPreguntaATopico: colec yUsuario: user1 conTitulo: 'Me estan testeando' conDescripcion: 'Wiii'.
	
	self assert: (sistema obtenerTopicosDePregunta: pregunta)  size equals: 2
]
