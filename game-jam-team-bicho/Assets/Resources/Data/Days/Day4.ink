VAR annabel_dia4_paso = false
VAR bernard_dia4_paso = false
VAR father_dia3_paso = false   // recibida desde Day3 vía DialogueManager

-> pregonero_dia4

=== pregonero_dia4 ===
# NPC: none
¡Oíd, oíd! ¡Cof, cof! Los días en el reino se están tornando oscuros, pero la esperanza es lo último que hay que perder. Hay que estar atentos, pues criaturas están entre nosotros, suplantando nuestras vidas y todo lo que queremos ¡cof, cof!. Quizá… quizá hasta yo sea uno de ellos.
-> annabel_manana_dia4

=== annabel_manana_dia4 ===
# NPC: annabel_sin
# STATE: happy
Buenos días, Henry.
# STATE: neutral
Me dijo una compañera que ahora debíamos presentar un permiso de trabajo para pasar, así que ya lo tengo preparado… Espero que no sigan pidiendo más papeleo, porque mi jefa ya parecía harta. Muchas otras han tenido que pedírselo.
-> hub_annabel_dia4

= hub_annabel_dia4
* [QUEST: ¿Qué tal las pacientes del otro día?]
    # STATE: neutral
    No progresan, y además comenzamos a ver otros síntomas, como ronchas...
    # STATE: afflicted
    Creo que es más mi cansancio, pero parecía que algunas de sus facciones… No lo sé. Cada día, es como si estuviera viendo la cara de otra persona.
    -> hub_annabel_dia4
* [QUEST: ¿Has tenido muchos problemas para conseguirlo?]
    # STATE: mad
    Bueno, el ambiente en la consulta es tenso. Cada vez hay más pacientes, y nosotras somos pocas. Ahora no tengo energía ni para cocinarle a mi hermana pequeña al llegar a casa, pero la saco de donde no la hay.
    -> hub_annabel_dia4
+ [DOC: ¿Me concede su documento de identidad?]
    # STATE: neutral
    Por supuesto.
    -> hub_annabel_dia4
+ [DOC: ¿Me enseña el permiso de trabajo, entonces?]
    # STATE: neutral
    Aquí tiene. ¿Es ese el documento correcto?
    -> hub_annabel_dia4
+ [DOC: ¿Usted tiene ronchas?]
    # STATE: neutral
    No, por ahora, no he notado nada así.
    -> hub_annabel_dia4
* [DEC: Dejar pasar]
    # STATE: happy
    ~ annabel_dia4_paso = true
    Gracias, Henry. Tenga un buen día.
    -> bernard_manana_dia4
* [DEC: No dejar pasar]
    # STATE: mad
    # PARANOIA: 1
    Henry, no es el momento.
    -> bernard_manana_dia4
* [DEC: Llamar a los guardias]
    # STATE: mad
    # PARANOIA: 2
    Los guardias se dirigen a la enfermera con un paso firme mientras ella recoge sus documentos para marcharse, pero es detenida por uno de ellos. La enfermera, aunque intenta justificarse, termina siendo arrastrada por los guardias lejos de la vista de Henry.
    -> bernard_manana_dia4
- -> bernard_manana_dia4

=== bernard_manana_dia4 ===
# NPC: bernard
# STATE: happy
Buenos días. Vengo a tratar unos asuntos en la parte alta de la ciudad.
-> hub_bernard_dia4

= hub_bernard_dia4
* [QUEST: ¿De qué carácter?]
    # STATE: neutral
    Unas gestiones que debo hacer con mi socio. Quiero cambiar de proveedor para sacar más beneficios a mi fábrica de algodón.
    -> hub_bernard_dia4
* [QUEST: ¿Cuántos días más estará por la ciudad?]
    # STATE: concerned
    ¿Cuántos días…?
    # STATE: neutral
    Una semana.
    -> hub_bernard_dia4
+ [DOC: ¿Puedo ver su documento de identidad?]
    # STATE: neutral
    Aquí tiene.
    -> hub_bernard_dia4
+ [DOC: ¿Me pasa su permiso de trabajo?]
    # STATE: neutral
    Todo suyo.
    -> hub_bernard_dia4
+ [DOC: ¿Ha notado ronchas en su cuerpo últimamente?]
    # STATE: neutral
    No, ninguna.
    -> hub_bernard_dia4
* [DEC: Dejar pasar]
    # STATE: happy
    ~ bernard_dia4_paso = true
    Gracias, tenga un buen día.
    -> predicador_dia4
* [DEC: No dejar pasar]
    # STATE: angry
    # PARANOIA: 1
    ¡Le exijo que lo reconsidere inmediatamente!
    -> predicador_dia4
* [DEC: Llamar a los guardias]
    # STATE: angry
    # PARANOIA: 2
    Henry ve a los guardias acercarse al empresario con más recelo del habitual. El hombre intenta que no le agarren, pero los guardias terminan maniatándole y llevándolo a un lugar apartado para someterle a preguntas.
    -> predicador_dia4
- -> predicador_dia4

=== predicador_dia4 ===
# NPC: preacher
# STATE: default
Buenas noches. Soy Franklin, portador de la voz espectral, el avistador entre planos del pasado, el presente y el futuro. Nada bloquea la visión de mi espíritu… Soy conocedor de lo que existe y lo que no. He venido a anunciar un mal presagio, pues el fin se acerca y nuestra existencia como la conocemos pronto será erradicada por algo mucho mayor que nosotros. Hemos enfadado a los dioses con nuestras bajas vibraciones, y ahora, no nos queda más que pagar.
-> padre_noche_dia4

=== padre_noche_dia4 ===
{ not father_dia3_paso:
    # NPC: father
    # STATE: angry
    Tú… ¡Tú! ¿¡A quién dejas entrar!? ¿¡A esos que han asesinado a mi hija!? ¡No me engañas! ¡Eres tú el que no es humano, no toda esta gente que ni siquiera está infectada!
}
-> fin_dia4

=== fin_dia4 ===
# NPC: none
# DAY_END:
-> END
