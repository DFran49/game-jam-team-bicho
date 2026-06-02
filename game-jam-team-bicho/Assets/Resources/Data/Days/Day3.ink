VAR father_dia3_paso = false
VAR dorothy_dia3_paso = false

-> pregonero_dia3

=== pregonero_dia3 ===
# NPC: none
¡Oíd, oíd! Quien enfermo se encuentre no ose a molestar la paz del prójimo de buen porvenir, puesto a que son quienes sacarán este reino adelante. El futuro es incierto, pero el ánimo no debe decaer, pues debemos confiar en nuestros guardias.
-> padre_manana_dia3

=== padre_manana_dia3 ===
# NPC: father
# STATE: neutral
Hola. ¿Qué tengo que presentar para entrar?
# STATE: happy
Tengo una reunión con un arrendador y no puedo llegar tarde, porque después debo recoger a mi hija en la estación.
-> hub_padre_dia3

= hub_padre_dia3
* [QUEST: ¿Piensa mudarse pronto a la parte alta de la ciudad?]
    # STATE: neutral
    Sí, con ella. Estoy intentando darle el mejor lugar posible donde crecer… Ahora estamos sólo ella y yo.
    -> hub_padre_dia3
* [QUEST: ¿Por qué viene ella por su cuenta?]
    # STATE: neutral
    Tenía que arreglarlo antes de venir… No podía exponerla a todo esto…
    -> hub_padre_dia3
+ [DOC: ¿Me entrega su documento de identidad?]
    # STATE: neutral
    Aquí tiene.
    -> hub_padre_dia3
+ [DOC: ¿Tiene un permiso de trabajo?]
    # STATE: neutral
    Trabajo en otra zona de la ciudad, ¿es realmente necesario?
    -> hub_padre_dia3
* [DEC: Dejar pasar]
    # STATE: happy
    Muchísimas gracias, eres un buen hombre.
    -> campesino_manana_dia3
* [DEC: No dejar pasar]
    # STATE: angry
    # PARANOIA: 1
    ¿Pero qué dices? ¡Si no me dejas entrar, mi hija no tendrá esta noche ningún lugar en el que dormir!
    -> campesino_manana_dia3
* [DEC: Llamar a los guardias]
    # STATE: angry
    # PARANOIA: 2
    Henry llama a los guardias, pero cuando vuelve a mirar hacia delante, el hombre ya no se encuentra frente a él.
    -> campesino_manana_dia3
- -> campesino_manana_dia3

=== campesino_manana_dia3 ===
# NPC: campesino
# STATE: afflicted
¡Por favor, déjame entrar! ¡No puedo seguir viviendo al otro lado, no hay nada que comer! ¡Necesito que abras la compuerta, por favor! Mi mujer vive del otro lado, pero ella… Ella se ha olvidado de mí… ¡Necesito verla, por favor, necesito recuperar la vida!
-> hub_campesino_dia3

= hub_campesino_dia3
* [QUEST: ¿Por qué dices que se ha olvidado de ti?]
    # STATE: neutral
    Bueno, ella… No estaba de acuerdo con cómo… Usaba mi dinero.
    -> hub_campesino_dia3
* [QUEST: ¿Por qué vive del otro lado sin ti?]
    # STATE: neutral
    Ella… Se mudó con su hermana…
    -> hub_campesino_dia3
+ [DEC: ...]
    -> fin_campesino_dia3
- -> fin_campesino_dia3

=== fin_campesino_dia3 ===
# NPC: campesino
# STATE: afflicted
Antes de que Henry tenga tiempo de preguntar nada más los guardias se dirigen hacia el campesino y lo inmovilizan. No sólo son dos, llegan a ser cuatro guardias para controlar a un hombre que ni siquiera está forcejeando, sólo lastimándose por sus decisiones en la vida.
-> dorothy_manana_dia3

=== dorothy_manana_dia3 ===
# NPC: dorothy
# STATE: sad
¡Cielos! Henry, ¿has visto cómo se lo han llevado…? ¿Qué mal podría estar haciendo ese hombre para que se lo lleven de esa manera…? Tal y como están las cosas… Parece que todo el mundo vive con un miedo que nos separa más que unirnos… Con cada vez más requisitos para entrar…
-> hub_dorothy_dia3

= hub_dorothy_dia3
* [QUEST: ¿Cómo son las restricciones en tu barrio?]
    # STATE: happy
    ¿En mi barrio? ¡Ja, ja, ja! ¡Hijo, en mi barrio todos son bienvenidos! No importa si tienes o no un permiso, o tu documento está caducado. A nadie le importamos tanto como para que no haya paso libre.
    -> hub_dorothy_dia3
* [QUEST: ¿Cómo está su vecina?]
    # STATE: sad
    No muy bien, hijo. Sigue en la cama, apenas tirando con su cuerpo. Su familia ya no tiene dinero para buscar a otro curandero, así que están intentando darle remedios para que no sufra tanto…
    -> hub_dorothy_dia3
+ [DOC: ¿Me entrega su documento de identidad?]
    # STATE: neutral
    Toma, hijo.
    -> hub_dorothy_dia3
+ [DOC: ¿Tiene un permiso de trabajo?]
    # STATE: neutral
    Aquí tienes.
    -> hub_dorothy_dia3
+ [DOC: ¿Y usted tiene alguna roncha?]
    # STATE: neutral
    No, ninguna. ¡Y eso que me rasco sin parar…!
    # STATE: happy
    Creo que mi nieto tiene un nido de piojos en la cabeza…
    -> hub_dorothy_dia3
* [DEC: Dejar pasar]
    # STATE: happy
    ~ dorothy_dia3_paso = true
    Gracias, Henry. Entre nosotros, nos apoyamos.
    -> padre_hija_noche_dia3
* [DEC: No dejar pasar]
    # STATE: sad
    # PARANOIA: 1
    ¿Cómo voy a seguir trabajando en el vestido de Lady Beatrice entonces?
    -> padre_hija_noche_dia3
* [DEC: Llamar a los guardias]
    # STATE: sad
    # PARANOIA: 2
    Ante Henry, los ojos de la anciana se abren de par en par al apreciar que dos hombres armados se acercan a ella con una actitud agresiva. Ella alza las manos, llamando a la paz, pero los guardias no atienden sus súplicas y terminan llevándosela bruscamente, a empujones, lejos de la vista de Henry.
    -> padre_hija_noche_dia3
- -> padre_hija_noche_dia3

=== padre_hija_noche_dia3 ===
# NPC: father_daughter
# STATE: happy
Niña: Buenas noches, señor.
# STATE: neutral
Padre: Buenas noches, caballero. No sé si me recordará, le comenté antes que vendría con mi hija.
# STATE: happy
Niña: ¡Acabo de bajar de un vagón donde había muuuuuchas personas!
-> hub_padre_hija_dia3

= hub_padre_hija_dia3
* [QUEST: ¿Cómo ha ido tu viaje en tren?]
    # STATE: neutral
    Niña: Mmmm… Hacía mucho calor…
    -> hub_padre_hija_dia3
* [QUEST: ¿Estás contenta de estar de nuevo con tu padre?]
    # STATE: happy
    Niña: Sí, señor. Tenía muchas ganas de verle.
    -> hub_padre_hija_dia3
+ [DOC: ¿Me entrega su documento de identidad?]
    # STATE: neutral
    Padre: Aquí tiene.
    -> hub_padre_hija_dia3
+ [DOC: ¿Me da el documento de identidad de su hija?]
    # STATE: neutral
    Padre: ¿De mi hija…? No tiene de este país. Mi difunta mujer dio a luz en el país vecino, así que nunca ha tenido uno de aquí. Tendrá que valer con el mío.
    -> hub_padre_hija_dia3
+ [DOC: ¿Tiene un permiso de trabajo?]
    # STATE: neutral
    Padre: Tome.
    -> hub_padre_hija_dia3
+ [DOC: ¿Y esas ronchas?]
    # STATE: neutral
    Padre: ¿Las… ronchas? Las tengo desde hace un par de días, me picaron unos mosquitos. A mi hija también, nuestro antiguo hogar estaba plagado de bichos.
    -> hub_padre_hija_dia3
* [DEC: Dejar pasar a ambos]
    # STATE: happy
    ~ father_dia3_paso = true
    Muchas gracias, soldado.
    -> fin_dia3
* [DEC: No dejar pasar]
    # STATE: angry
    # PARANOIA: 1
    Padre: ¡Por Dios, no me diga esto! ¿¡Sabe cuánto hemos tenido que luchar juntos para llegar hasta aquí!? ¡No le niegue su futuro a mi hija! ¡Necesita estar aquí! Los guardias aparecen rápidamente ante la actitud descontrolada del hombre. Entre varios separan a su hija de él, por mucho que ambos intenten encontrarse con el otro. La niña desaparece pronto de la vista de Henry, pero sus ojos quedan fijos en los del padre que, tras ser apaleado durante un buen rato, es abandonado a su suerte en la calle.
    -> fin_dia3
* [DEC: Llamar a los guardias]
    # STATE: angry
    # PARANOIA: 2
    Padre: ¡Por Dios, no me diga esto! ¿¡Sabe cuánto hemos tenido que luchar juntos para llegar hasta aquí!? ¡No le niegue su futuro a mi hija! ¡Necesita estar aquí! Los guardias aparecen rápidamente ante la actitud descontrolada del hombre. Entre varios separan a su hija de él, por mucho que ambos intenten encontrarse con el otro. La niña desaparece pronto de la vista de Henry, pero sus ojos quedan fijos en los del padre que, tras ser apaleado durante un buen rato, es abandonado a su suerte en la calle.
    -> fin_dia3
- -> fin_dia3

=== fin_dia3 ===
# NPC: none
# SAVE_VAR: father_dia3_paso
# SAVE_VAR: dorothy_dia3_paso
# DAY_END:
-> END
