VAR dorothy_dia3_paso = false   // recibida desde Day3 vía DialogueManager
VAR father_dia3_paso = false    // recibida desde Day3 vía DialogueManager

-> pregonero_dia5

=== pregonero_dia5 ===
# NPC: none
Cuando los primeros rayos de sol empiezan a salir en el reino, lo que ven las calles es el cuerpo del Pregonero, abierto y completamente vaciado, como si hubieran robado sus órganos. La sangre aún cae de su cuerpo, y los papeles con las noticias del día están desparramados por la calle, manchados con ese líquido carmesí que ensucia las botas de los nobles que pasean por ahí como si no pasara nada.
-> ruta_dia5

=== ruta_dia5 ===
{ dorothy_dia3_paso:
    -> dorothy_manana_dia5
- else:
    -> evil_dorothy_manana_dia5
}

// ══════════════════════════════════════════════
// RUTA SIN PARANOIA — Dorothy dejó pasar en día 3
// ══════════════════════════════════════════════

=== dorothy_manana_dia5 ===
# NPC: dorothy
# STATE: neutral
Buenos días, Henry… Ayer no nos vimos, ¿cómo has estado?
# STATE: sad
Yo fui ayer al funeral de mi vecina. Tal y como están las cosas, tuvieron que quemar su cuerpo. Ni siquiera pudieron darle una sepultura digna… Qué pena. Cada vez todo va a peor. Nunca había pensado que viviría algo así. La vida en mi barrio da cada vez más miedo.
-> hub_dorothy_dia5

= hub_dorothy_dia5
* [QUEST: ¿Cómo estaba la familia de su vecina?]
    # STATE: sad
    Destrozada… No entendían cómo ha sido tan rápido… No estaban preparados para su pérdida… No así.
    -> hub_dorothy_dia5
* [QUEST: ¿Qué está ocurriendo en su barrio?]
    # STATE: sad
    Hablar de eso me da… Escalofríos. La gente está rara, llena de dolor. Pero no saben de dónde viene. No tienen manera de curarlo.
    -> hub_dorothy_dia5
+ [DOC: ¿Me enseña su documento de identidad?]
    # STATE: neutral
    Estoy intentando que me lo renueven, pero no parece avanzar la cosa.
    -> hub_dorothy_dia5
+ [DOC: ¿Me muestra su documento de trabajo?]
    # STATE: neutral
    Aquí tienes, hijo.
    -> hub_dorothy_dia5
+ [DOC: Ahora debe pagar diez pulares para poder entrar.]
    # STATE: sad
    ¿Disculpa? ¡Eso es imposible! No, no puedo dártelos, ¡si es el dinero que consigo en un mes! Déjame pasar, por favor. El vestido de Lady Beatrice no se va a terminar sólo.
    -> hub_dorothy_dia5
* [DEC: Dejar pasar]
    # STATE: happy
    ¡Muchísimas gracias, hijo!
    -> cazador_manana_dia5
* [DEC: No dejar pasar]
    # STATE: sad
    # PARANOIA: 1
    Lo entiendo… Es tu trabajo.
    -> cazador_manana_dia5
* [DEC: Llamar a los guardias]
    # STATE: sad
    # PARANOIA: 2
    Ante Henry, los ojos de la anciana se abren de par en par al apreciar que dos hombres armados se acercan a ella con una actitud agresiva. Ella alza las manos, llamando a la paz, pero los guardias no atienden sus súplicas y terminan llevándosela bruscamente, a empujones, lejos de la vista de Henry.
    -> cazador_manana_dia5
- -> cazador_manana_dia5

=== cazador_manana_dia5 ===
# NPC: arthur
# STATE: happy
¡Buenos días, caballero! ¡Ya he pedido el permiso que me faltaba, para mantenerlo todo legal!
# STATE: neutral
Ha tardado un par de días, pero ya estoy listo para exterminarlas a todas… Estoy convencido de que el barrio está infestado,
# STATE: happy
¡Porque estoy seguro de que en la parte alta de la ciudad nadie las aprovecha para comer! Aunque yo preferiría que nadie lo hiciera, porque si no, ¿de qué trabajo entonces…?
# STATE: mad
Tendría que buscarme un nuevo curro, darle a Toby a otra persona… Mejor que no se coman las ratas y me lo dejen a mí.
-> hub_cazador_dia5

= hub_cazador_dia5
* [QUEST: ¿Nunca ha querido tener otro trabajo?]
    # STATE: happy
    Ya he encontrado lo que debo hacer. ¿Qué más quiero? Le doy de comer a mi familia, voy a todos lados con mi Toby, ayudo a controlar las plagas y a dejar la ciudad más limpia… Ya no me veo en ningún otro sitio.
    -> hub_cazador_dia5
* [QUEST: ¿Dónde dejaría a su perro si tuviera que dejar el oficio?]
    # STATE: neutral
    ¡Nunca lo había pensado! Qué gran pregunta… Puede que se lo dejara a mi hermano, que es cazador.
    # STATE: happy
    No le vendría mal un ejemplar como Toby.
    -> hub_cazador_dia5
+ [DOC: ¿Me enseña su documento de identidad?]
    # STATE: neutral
    Tómelo.
    -> hub_cazador_dia5
+ [DOC: A ver ese permiso de trabajo.]
    # STATE: happy
    Je, je, je. Aquí está el esperado.
    -> hub_cazador_dia5
+ [DOC: ¿Últimamente se ha notado alguna roncha?]
    # STATE: neutral
    Sólo las picaduras de algún insecto. ¡Nada importante!
    -> hub_cazador_dia5
+ [DOC: Debe pagar diez pulares para entrar.]
    # STATE: mad
    ¿Diez? Qué caro… Aquí tiene, supongo.
    -> hub_cazador_dia5
* [DEC: Dejar pasar]
    # STATE: happy
    El deber me llama… ¡Hasta luego!
    -> annabel_tarde_dia5
* [DEC: No dejar pasar]
    # STATE: mad
    # PARANOIA: 1
    ¡Venga, hombre, voy a tener que causar una plaga aún mayor yo para que me dejes entrar!
    -> annabel_tarde_dia5
* [DEC: Llamar a los guardias]
    # STATE: mad
    # PARANOIA: 2
    Henry ve a los guardias acercarse al hombre, que ha adoptado una postura muy defensiva. Los guardias se aproximan cautelosos, pero el cazador de ratas se lanza al ataque junto a su perro. Cuando los refuerzos llegan, el cazador está exhausto y se rinde al suelo. Henry, desde el interior, ve al perro ser apaleado hasta que también cae y deja de luchar.
    -> annabel_tarde_dia5
- -> annabel_tarde_dia5

=== annabel_tarde_dia5 ===
# NPC: annabel_con
# STATE: neutral
Buenas noches. La noche es cada vez más escalofriante, ¿verdad…? No sabes qué te va a deparar la siguiente esquina.
# STATE: afflicted
Si le soy sincera, cada vez me da más miedo salir después del trabajo. Estoy escuchando muchas cosas últimamente, y tampoco ayudan las restricciones cada vez más absurdas para entrar en el barrio alto.
-> hub_annabel_tarde_dia5

= hub_annabel_tarde_dia5
* [QUEST: ¿Siente miedo por algo en particular?]
    # STATE: neutral
    No, supongo que no. Son las historias que cuentan los pacientes.
    # STATE: mad
    Creo que escucharles desvariar tanto sobre partes del cuerpo cambiantes está haciendo que me vuelva una paranoica. Es puro cansancio.
    -> hub_annabel_tarde_dia5
* [QUEST: ¿Qué tal en la consulta?]
    # STATE: neutral
    Igual de ocupada. Ahora los casos de psicosis son más frecuentes, y llegan muchas personas con dolores inaguantables en el vientre que no se calman, hagamos lo que hagamos.
    -> hub_annabel_tarde_dia5
+ [DOC: ¿Me enseña su documento de identidad?]
    # STATE: neutral
    Tome.
    -> hub_annabel_tarde_dia5
+ [DOC: ¿Me mostraría su permiso de trabajo?]
    # STATE: neutral
    Naturalmente.
    -> hub_annabel_tarde_dia5
+ [DOC: ¿Sigue sin ronchas?]
    # STATE: neutral
    Ni una sola.
    -> hub_annabel_tarde_dia5
+ [DOC: ¿Y ese lunar?]
    # STATE: neutral
    ¿El lunar? Ah, sí. Hoy no lo he tapado, como hago de costumbre. Se me ha terminado el maquillaje.
    -> hub_annabel_tarde_dia5
+ [DOC: Ahora es necesario pagar diez pulares para entrar.]
    # STATE: afflicted
    ¿Diez? No sé si llevo tantos…
    # STATE: happy
    Aquí tienes.
    -> hub_annabel_tarde_dia5
* [DEC: Dejar pasar]
    # STATE: happy
    Gracias, Henry. Hasta más tarde.
    -> padre_noche_dia5
* [DEC: No dejar pasar]
    # STATE: mad
    # PARANOIA: 1
    Henry, por favor. No puedes dejar que toda esta gente sufra, necesitan que yo les atienda…
    -> padre_noche_dia5
* [DEC: Llamar a los guardias]
    # STATE: mad
    # PARANOIA: 2
    Ante Henry, los ojos de la enfermera se abren como platos cuando ven que los guardias se acercan a ella. Sin embargo la enfermera no opone resistencia. Los guardias se la llevan a empujones lejos de la visión de Henry.
    -> padre_noche_dia5
- -> padre_noche_dia5

=== padre_noche_dia5 ===
{ not father_dia3_paso:
    # NPC: father
    # STATE: angry
    Mi hija… Se la han llevado. Me la han quitado de entre los brazos, por tu culpa. Ella no tenía nada, no era mala. Era sólo una niña.
    -> hub_padre_noche_dia5
}
-> rey_noche_dia5

= hub_padre_noche_dia5
* [QUEST: Lo siento.]
    # STATE: neutral
    Tus palabras no cambian nada.
    -> hub_padre_noche_dia5
* [QUEST: Sólo estaba haciendo mi trabajo.]
    # STATE: neutral
    …
    -> hub_padre_noche_dia5
+ [DEC: Continuar]
    -> rey_noche_dia5
- -> rey_noche_dia5

=== rey_noche_dia5 ===
# NPC: king
# STATE: happy
En cuanto veo a mi querido Henry Sylvester, sé que he vuelto de verdad a casa. ¡Espero que el reino no haya penado en mi ausencia, puesto que mis asuntos en los Picos Altos no podían ignorarse! ¡Qué vistas, qué majestuosidad!
# STATE: neutral
Imagino que una persona como tú no ha visto tanto mundo pero es que, incluso para mí, fue un impacto colosal. Aquello es precioso, Sylvester… Si tuvieras vacaciones, te recomendaría que fueras allí.
# STATE: annoyed
Eso sí, el frescor engaña: el calor es tal que me ha provocado una urticaria por todo el cuerpo.
-> hub_rey_dia5

= hub_rey_dia5
+ [DOC: ¿Me entrega su permiso de trabajo?]
    # STATE: annoyed
    ¡Tengo tantos quehaceres que si tuviera que presentar un permiso por cada uno tendría que llevar cientos de carros con ellos!
    -> hub_rey_dia5
+ [DOC: ¿Me podría mostrar su documento de identificación?]
    # STATE: happy
    Sylvester, he de decir… ¡Que me encantan estos juegos! ¿Cuál es el siguiente documento…? ¿El certificado de nacimiento de mi padre? ¡No sé si ese lo tengo a mano!
    -> hub_rey_dia5
+ [DOC: ¿Cuándo aparecieron sus primeras ronchas?]
    # STATE: happy
    ¡Cuánta preocupación por mi bienestar…! Fue hace unos pocos días, creo recordar. No estoy del todo seguro, porque mis recuerdos se han nublado por el vino y los banquetes.
    # STATE: neutral
    Tengo el vientre incluso adolorido, de lo tensos que eran estos temas, por supuesto.
    -> hub_rey_dia5
+ [DOC: Según mis órdenes, debe pagar diez pulares para entrar.]
    # STATE: neutral
    ¿Sólo diez…? Aquí tienes cincuenta. Quédate el resto, ¿eh? Que seguro que te viene bien.
    # STATE: happy
    Así tendrás ahorros para irte de vacaciones cuando os lo permita.
    -> hub_rey_dia5
* [DEC: Dejar pasar]
    # STATE: happy
    ¡Hasta más ver, querido!
    -> fin_dia5
* [DEC: No dejar pasar]
    # STATE: happy
    # PARANOIA: 1
    Al llamar a los guardias Henry ve cómo estos reciben con una reverencia al monarca, que parece divertido ante la idea de que Henry no le dé paso. El rey Laureano se marcha sin despedirse acompañado de su corte y pronto Henry lo pierde de vista y recuerda que, aunque existan las normas, estas no se aplican por igual a todo el mundo cuando son los más privilegiados los que las imponen.
    -> fin_dia5
* [DEC: Llamar a los guardias]
    # STATE: happy
    # PARANOIA: 2
    Al llamar a los guardias Henry ve cómo estos reciben con una reverencia al monarca, que parece divertido ante la idea de que Henry no le dé paso. El rey Laureano se marcha sin despedirse acompañado de su corte y pronto Henry lo pierde de vista y recuerda que, aunque existan las normas, estas no se aplican por igual a todo el mundo cuando son los más privilegiados los que las imponen.
    -> fin_dia5
* [DEC: Usar la espada]
    # PARANOIA: 5
    En un movimiento rápido, más incluso que el de la respiración más corta, Henry toma su espada y arremete contra el cuello del monarca. Su roja sangre cubre la tierra, salpica el escritorio y mancha las manos de Henry, que ve cómo el rey Laureano chorrea la sangre como si fuera una cascada. Los pasos inundan los oídos del guardia, que pronto es aplacado contra la mesa, inmovilizado completamente en apenas segundos. Después de eso, Henry pierde el conocimiento por un contundente golpe en la cabeza. El sol ataca al guardia cuando vuelve a abrir los ojos. A su alrededor cientos abuchean en la plaza, una que Henry conoce muy bien. No tarda en encontrar la garita, su lugar de trabajo durante tantos años, lo único familiar que encuentra entre el público. Con la soga alrededor del cuello, Henry contempla el cielo y reflexiona acerca de lo que le ha llevado a este momento. Rodeándolo, no reconoce a ninguna persona, a ningún ser humano. Todo se ha convertido en pura especulación para él. Cuando sus pies se elevan, Henry no siente miedo, sino alivio por abandonar en lo que se ha convertido este mundo.
    -> fin_dia5
- -> fin_dia5

// ══════════════════════════════════════════════
// RUTA CON PARANOIA — Dorothy NO dejó pasar en día 3
// ══════════════════════════════════════════════

=== evil_dorothy_manana_dia5 ===
# NPC: evil_dorothy
# STATE: neutral
Buenos días. Otro día más… Ay, hijo, me pregunto cuándo terminará todo esto, este mal cuerpo que yo tengo. ¡Y no he comido nada raro, pero este dolor en la barriga se ha convertido en mi compañero de vida!
-> hub_evil_dorothy_dia5

= hub_evil_dorothy_dia5
* [QUEST: ¿Siente algo más aparte de eso?]
    # STATE: neutral
    ¡Nada de eso! Serán sólo los nervios con todo lo que está pasando.
    -> hub_evil_dorothy_dia5
* [QUEST: ¿Cómo sigue su vecina?]
    # STATE: sad
    Mi vecina… La encontró su hijo ayer, fallecida, sobre su cama…
    -> hub_evil_dorothy_dia5
+ [DOC: ¿Me da su documento de identidad?]
    # STATE: neutral
    No es nada que no hayas visto ya, hijo.
    -> hub_evil_dorothy_dia5
+ [DOC: ¿Me muestra su documento de trabajo?]
    # STATE: neutral
    Aquí está.
    -> hub_evil_dorothy_dia5
+ [DOC: Ahora debe pagar diez pulares para poder entrar.]
    # STATE: sad
    ¿Diez pulares? ¡Ay, hijo, quién los tuviera! No, no puedo dártelos, ¡si es el dinero que consigo en un mes! Déjame pasar, por favor. El vestido de Lady Berenice no se va a terminar sólo.
    -> hub_evil_dorothy_dia5
* [DEC: Dejar pasar]
    # STATE: happy
    ¡Muchas gracias, hijo!
    -> predicador_tarde_dia5
* [DEC: No dejar pasar]
    # STATE: sad
    # PARANOIA: 1
    Lo entiendo… Es tu trabajo.
    -> predicador_tarde_dia5
* [DEC: Llamar a los guardias]
    # STATE: sad
    # PARANOIA: 2
    Ante Henry, los ojos de la anciana se abren de par en par al apreciar que dos hombres armados se acercan a ella con una actitud agresiva. Ella alza las manos, llamando a la paz, pero los guardias no atienden sus súplicas y terminan llevándosela bruscamente, a empujones, lejos de la vista de Henry.
    -> predicador_tarde_dia5
- -> predicador_tarde_dia5

=== predicador_tarde_dia5 ===
# NPC: preacher
# STATE: default
¡El fin se acerca, mi querido Henry! ¡Los Dioses nos están haciendo pagar y pronto todo será negro! Pero no tengas miedo, nos lo merecemos por ser tan egoístas. Riquezas, poder, nada de eso va a importar cuando ellos se hagan paso entre nosotros y se apoderen de nuestras vidas. Se comerán nuestra carne y nos arrancarán nuestros ojos para que podamos ver en lo que convierten nuestro mundo, portando nuestras caras. ¡Espero que no te cojan el primero…!
-> annabel_tarde_dia5_b

=== annabel_tarde_dia5_b ===
# NPC: annabel_con
# STATE: neutral
Buenas noches. La noche es cada vez más escalofriante, ¿verdad…? No sabes qué te va a deparar la siguiente esquina.
# STATE: afflicted
Si le soy sincera, cada vez me da más miedo salir después del trabajo. Estoy escuchando muchas cosas últimamente, y tampoco ayudan las restricciones cada vez más absurdas para entrar en el barrio alto.
-> hub_annabel_tarde_dia5_b

= hub_annabel_tarde_dia5_b
* [QUEST: ¿Siente miedo por algo en particular?]
    # STATE: neutral
    No, supongo que no. Son las historias que cuentan los pacientes.
    # STATE: mad
    Creo que escucharles desvariar tanto sobre partes del cuerpo cambiantes está haciendo que me vuelva una paranoica. Es puro cansancio.
    -> hub_annabel_tarde_dia5_b
* [QUEST: ¿Qué tal en la consulta?]
    # STATE: neutral
    Igual de ocupada. Ahora los casos de psicosis son más frecuentes, y llegan muchas personas con dolores inaguantables en el vientre que no se calman, hagamos lo que hagamos.
    -> hub_annabel_tarde_dia5_b
+ [DOC: ¿Me enseña su documento de identidad?]
    # STATE: neutral
    Tome.
    -> hub_annabel_tarde_dia5_b
+ [DOC: ¿Me mostraría su permiso de trabajo?]
    # STATE: neutral
    Naturalmente.
    -> hub_annabel_tarde_dia5_b
+ [DOC: ¿Sigue sin ronchas?]
    # STATE: neutral
    Ni una sola.
    -> hub_annabel_tarde_dia5_b
+ [DOC: ¿Y ese lunar?]
    # STATE: neutral
    ¿El lunar? Ah, sí. Hoy no lo he tapado, como hago de costumbre. Se me ha terminado el maquillaje.
    -> hub_annabel_tarde_dia5_b
+ [DOC: Ahora es necesario pagar diez pulares para entrar.]
    # STATE: afflicted
    ¿Diez? No sé si llevo tantos…
    # STATE: happy
    Aquí tienes.
    -> hub_annabel_tarde_dia5_b
* [DEC: Dejar pasar]
    # STATE: happy
    Gracias, Henry. Hasta más tarde.
    -> padre_noche_dia5_b
* [DEC: No dejar pasar]
    # STATE: mad
    # PARANOIA: 1
    Henry, por favor. No puedes dejar que toda esta gente sufra, necesitan que yo les atienda…
    -> padre_noche_dia5_b
* [DEC: Llamar a los guardias]
    # STATE: mad
    # PARANOIA: 2
    Ante Henry, los ojos de la enfermera se abren como platos cuando ven que los guardias se acercan a ella. Sin embargo la enfermera no opone resistencia. Los guardias se la llevan a empujones lejos de la visión de Henry.
    -> padre_noche_dia5_b
- -> padre_noche_dia5_b

=== padre_noche_dia5_b ===
{ not father_dia3_paso:
    # NPC: father
    # STATE: angry
    Mi hija… Se la han llevado. Me la han quitado de entre los brazos, por tu culpa. Ella no tenía nada, no era mala. Era sólo una niña.
    -> hub_padre_noche_dia5_b
}
-> rey_noche_dia5_b

= hub_padre_noche_dia5_b
* [QUEST: Lo siento.]
    # STATE: neutral
    Tus palabras no cambian nada.
    -> hub_padre_noche_dia5_b
* [QUEST: Sólo estaba haciendo mi trabajo.]
    # STATE: neutral
    …
    -> hub_padre_noche_dia5_b
+ [DEC: Continuar]
    -> rey_noche_dia5_b
- -> rey_noche_dia5_b

=== rey_noche_dia5_b ===
# NPC: king
# STATE: happy
En cuanto veo a mi querido Henry Sylvester, sé que he vuelto de verdad a casa. ¡Espero que el reino no haya penado en mi ausencia, puesto que mis asuntos en los Picos Altos no podían ignorarse! ¡Qué vistas, qué majestuosidad!
# STATE: neutral
Imagino que una persona como tú no ha visto tanto mundo pero es que, incluso para mí, fue un impacto colosal. Aquello es precioso, Sylvester… Si tuvieras vacaciones, te recomendaría que fueras allí.
# STATE: annoyed
Eso sí, el frescor engaña: el calor es tal que me ha provocado una urticaria por todo el cuerpo.
-> hub_rey_dia5_b

= hub_rey_dia5_b
+ [DOC: ¿Me entrega su permiso de trabajo?]
    # STATE: annoyed
    ¡Tengo tantos quehaceres que si tuviera que presentar un permiso por cada uno tendría que llevar cientos de carros con ellos!
    -> hub_rey_dia5_b
+ [DOC: ¿Me podría mostrar su documento de identificación?]
    # STATE: happy
    Sylvester, he de decir… ¡Que me encantan estos juegos! ¿Cuál es el siguiente documento…? ¿El certificado de nacimiento de mi padre? ¡No sé si ese lo tengo a mano!
    -> hub_rey_dia5_b
+ [DOC: ¿Cuándo aparecieron sus primeras ronchas?]
    # STATE: happy
    ¡Cuánta preocupación por mi bienestar…! Fue hace unos pocos días, creo recordar. No estoy del todo seguro, porque mis recuerdos se han nublado por el vino y los banquetes.
    # STATE: neutral
    Tengo el vientre incluso adolorido, de lo tensos que eran estos temas, por supuesto.
    -> hub_rey_dia5_b
+ [DOC: Según mis órdenes, debe pagar diez pulares para entrar.]
    # STATE: neutral
    ¿Sólo diez…? Aquí tienes cincuenta. Quédate el resto, ¿eh? Que seguro que te viene bien.
    # STATE: happy
    Así tendrás ahorros para irte de vacaciones cuando os lo permita.
    -> hub_rey_dia5_b
* [DEC: Dejar pasar]
    # STATE: happy
    ¡Hasta más ver, querido!
    -> fin_dia5
* [DEC: No dejar pasar]
    # STATE: happy
    # PARANOIA: 1
    Al llamar a los guardias Henry ve cómo estos reciben con una reverencia al monarca, que parece divertido ante la idea de que Henry no le dé paso. El rey Laureano se marcha sin despedirse acompañado de su corte y pronto Henry lo pierde de vista y recuerda que, aunque existan las normas, estas no se aplican por igual a todo el mundo cuando son los más privilegiados los que las imponen.
    -> fin_dia5
* [DEC: Llamar a los guardias]
    # STATE: happy
    # PARANOIA: 2
    Al llamar a los guardias Henry ve cómo estos reciben con una reverencia al monarca, que parece divertido ante la idea de que Henry no le dé paso. El rey Laureano se marcha sin despedirse acompañado de su corte y pronto Henry lo pierde de vista y recuerda que, aunque existan las normas, estas no se aplican por igual a todo el mundo cuando son los más privilegiados los que las imponen.
    -> fin_dia5
* [DEC: Usar la espada]
    # PARANOIA: 5
    En un movimiento rápido, más incluso que el de la respiración más corta, Henry toma su espada y arremete contra el cuello del monarca. Su roja sangre cubre la tierra, salpica el escritorio y mancha las manos de Henry, que ve cómo el rey Laureano chorrea la sangre como si fuera una cascada. Los pasos inundan los oídos del guardia, que pronto es aplacado contra la mesa, inmovilizado completamente en apenas segundos. Después de eso, Henry pierde el conocimiento por un contundente golpe en la cabeza. El sol ataca al guardia cuando vuelve a abrir los ojos. A su alrededor cientos abuchean en la plaza, una que Henry conoce muy bien. No tarda en encontrar la garita, su lugar de trabajo durante tantos años, lo único familiar que encuentra entre el público. Con la soga alrededor del cuello, Henry contempla el cielo y reflexiona acerca de lo que le ha llevado a este momento. Rodeándolo, no reconoce a ninguna persona, a ningún ser humano. Todo se ha convertido en pura especulación para él. Cuando sus pies se elevan, Henry no siente miedo, sino alivio por abandonar en lo que se ha convertido este mundo.
    -> fin_dia5
- -> fin_dia5

=== fin_dia5 ===
# NPC: none
# DAY_END:
-> END
