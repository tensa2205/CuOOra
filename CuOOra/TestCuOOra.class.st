Class {
	#name : #TestCuOOra,
	#superclass : #TestCase,
	#instVars : [
		'sistema',
		'topico',
		'user1',
		'user2',
		'p1',
		'pA',
		'pB',
		'pC',
		'pD',
		'r1',
		'r2',
		'rA',
		'rB',
		't2',
		't3'
	],
	#category : #'CuOOra-tests'
}

{ #category : #running }
TestCuOOra >> setUp [
	sistema := CuOOra new.
	topico := sistema agregarTopicoConNombre: 'General' descripcion: 'Discusión General'.
	user1 := sistema crearUsuarioConNombre: 'El pepe' contraseña: '1'.
	user2 := sistema crearUsuarioConNombre: 'La moni' contraseña: '2'.
	
	p1 := 	sistema agregarPreguntaATopico: sistema topicos yUsuario: user1  conTitulo: 'p1'  conDescripcion: 'dp1'.
		
	
	pA := sistema agregarPreguntaATopico: (sistema topicos) yUsuario: user2  conTitulo: 'Contesten' conDescripcion: 'UwU'.
	pB := sistema agregarPreguntaATopico: (sistema topicos) yUsuario: user2  conTitulo: 'Contesten mi segunda' conDescripcion: 'UwU v2'.
	
	t2 := sistema agregarTopicoConNombre: 'Soy el segundo topico' descripcion: 'Yo cuento en los calculos!!!'.
	
	pC := sistema agregarPreguntaATopico: (sistema topicos) yUsuario: user1  conTitulo: 'Stop it moni, get some help' conDescripcion: 'Vea el titulo'.
	pD := sistema agregarPreguntaATopico: (sistema topicos) yUsuario: user1  conTitulo: 'Les paso este temazo' conDescripcion: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ'.
	
	r1 := pA agregarRespuestaConTexto: 'Contesto pregunta A, over' usuario: user1.
	r2 := pB agregarRespuestaConTexto: 'Contesto pregunta B, over' usuario: user1. 
	pC agregarRespuestaConTexto: 'Esta respuesta no deberia contar en el puntaje.' usuario: user1.
	
	rA := pD agregarRespuestaConTexto: 'Respuesta pD' usuario: user2.
	rB := pD agregarRespuestaConTexto: 'Respuesta pD version 2' usuario: user2.
	
	t3 := sistema agregarTopicoConNombre: 'Soy el tercer topico' descripcion: 'Yo no cuento en los calculos.'.
	
	
	

]

{ #category : #tests }
TestCuOOra >> testAgregarPreguntaTopicoYUsuario [
	self 
		assert: topico preguntas size equals: 5;
		assert: (topico preguntas includes: p1);
		assert: (topico preguntas includes: pA);
		assert: (topico preguntas includes: pB);
		assert: (topico preguntas includes: pC);
		assert: (topico preguntas includes: pD);
		assert: (user1 preguntasHechas includes: p1);
		assert: (user1 preguntasHechas includes: pC);
		assert: (user1 preguntasHechas includes: pD).
]

{ #category : #tests }
TestCuOOra >> testBorrarPregunta [
	"Chequeo de que las preguntas están ahí."
	self
		assert: (topico preguntas includes: p1);
		assert: (user1 preguntasHechas includes: p1);
		assert: (topico preguntas includes: pB);
		assert: (user2 preguntasHechas includes: pB) ;
		assert: (topico preguntas includes: pC);
		assert: (t2 preguntas includes: pC);
		assert: (user1 preguntasHechas includes: pC).
	
	"Empieza el borrado."
	sistema 
		borrarPregunta: p1;
		borrarPregunta: pB;
		borrarPregunta: pC.
	self
		"Borrado de p1"
		assert: (topico preguntas includes: p1) not;
		assert: (user1 preguntasHechas includes: p1) not;
		"Borrado de pB"
		assert: (topico preguntas includes: pB) not;
		assert: (user2 preguntasHechas includes: pB) not;
		"Borrado de pC"
		assert: (topico preguntas includes: pC) not;
		assert: (t2 preguntas includes: pC) not;
		assert: (user1 preguntasHechas includes: pC) not
]

{ #category : #tests }
TestCuOOra >> testCrearTopico [
	self 
		assert: sistema topicos size equals: 3;
		assert: (sistema topicos includes: topico);
		assert: (sistema topicos includes: t2);
		assert: (sistema topicos includes: t3).
]

{ #category : #tests }
TestCuOOra >> testCrearUsuario [
	self 
		assert: (sistema usuarios) size equals: 2;
		assert: (sistema usuarios includes: user1);
		assert: (sistema usuarios includes: user2).
	
]

{ #category : #tests }
TestCuOOra >> testDevolverPuntajeDeUsuario [	
	pC
		recibirReaccion: true deUn: '1';
		recibirReaccion: true deUn: '2'; 
		recibirReaccion: false deUn: '7'. 
	self assert: (sistema devolverPuntajeDeUsuario: user1) equals: 161.
	pD
		recibirReaccion: false deUn: '6';
		recibirReaccion: false deUn: '7'. 
	self assert: (sistema devolverPuntajeDeUsuario: user1) equals: 159.
	r1
		recibirReaccion: true deUn: '1';
		recibirReaccion: true deUn: '2'.
	self assert: (sistema devolverPuntajeDeUsuario: user1) equals: 161.
	r2
		recibirReaccion: true deUn: '1';
		recibirReaccion: true deUn: '2'. 
	self assert: (sistema devolverPuntajeDeUsuario: user1) equals: 163.
	
	
	  
]

{ #category : #tests }
TestCuOOra >> testObtenerRespuestasUsuario [
	| respuestas |
	respuestas := sistema todasLasRespuestasDeUsuario: user2.
	self 
		assert: respuestas size equals: 2;
		assert: (respuestas includes: rA);
		assert: (respuestas includes: rB).
		
	
	
]

{ #category : #tests }
TestCuOOra >> testObtenerTopicosDePregunta [
	|colec pregunta topicosPregunta|
	colec := OrderedCollection new.
	colec
		add:topico;
		add:t2.
	
	pregunta := sistema agregarPreguntaATopico: colec yUsuario: user1 conTitulo: 'Me estan testeando' conDescripcion: 'Wiii'.
	topicosPregunta := (sistema obtenerTopicosDePregunta: pregunta).
	
	self 
		assert: topicosPregunta size equals: 2;
		assert: (topicosPregunta includes: 'General');
		assert: (topicosPregunta includes: 'Soy el segundo topico');
		assert: (topicosPregunta includes: 'Soy el tercer topico') not.
]
