VAR dorothy_dia2_paso = false
VAR filip_dia2_paso = false
VAR bernard_dia2_paso = false
VAR cazador_dia2_paso = false

-> pregonero_dia2

=== pregonero_dia2 ===
# NPC: none
¡Oíd, oíd! Las autoridades recuerdan que sólo quienes contribuyen al bienestar común merecen disfrutar de la protección de la ciudad. En tiempos inciertos, cada ciudadano debe demostrar su utilidad y compromiso con el orden establecido.
-> dorothy_manana_dia2

=== dorothy_manana_dia2 ===
# NPC: dorothy
# STATE: neutral
Buenos días, Henry… He estado escuchando a los vecinos del pueblo hablar, todo el mundo está muy nervioso. Mi vecina de toda la vida lleva días en cama, y ningún curandero sabe lo que le pasa… ¿Será porque el cazador de ratas lleva un tiempo sin pasar por nuestro barrio?
-> hub_dorothy_dia2

= hub_dorothy_dia2
* [QUEST: ¿Cómo te encuentras?]
    # STATE: happy
    Gracias a Dios, bien, hijo. Siempre he sido una mujer de buena salud, así que estas cosas no me preocupan mucho.
    # STATE: sad
    Aún así… No puedo evitar sentir pena por mi vecina.
    -> hub_dorothy_dia2
* [QUEST: ¿Qué le pasa a tu vecina?]
    # STATE: sad
    No lo sé muy bien, Henry. Solo sé lo que me han contado las demás mujeres del barrio, así que tengo poco que decir. Creo que tenía mucho picor por el cuerpo.
    -> hub_dorothy_dia2
+ [DOC: ¿Me puede enseñar su permiso de trabajo?]
    # STATE: happy
    Claro, hijo, aquí tienes.
    -> hub_dorothy_dia2
* [DEC: Dejar pasar]
    # STATE: happy
    ~ dorothy_dia2_paso = true
    Gracias, hijo.
    -> filip_manana_dia2
* [DEC: No dejar pasar]
    # STATE: sad
    # PARANOIA: 1
    ¿Por qué? Todo está en regla.
    -> filip_manana_dia2
* [DEC: Llamar a los guardias]
    # STATE: sad
    # PARANOIA: 2
    Tras llamar a los guardias, Henry ve cómo estos se acercan a la costurera tranquilamente. Henry escucha cómo intenta razonar con ellos para que le dejen pasar, pero, tras unos minutos, ve a la costurera alejarse del punto de acceso al barrio.
    -> filip_manana_dia2
- -> filip_manana_dia2

=== filip_manana_dia2 ===
# NPC: philip
# STATE: happy
Ho-hola, señor.
# STATE: neutral
Necesito pasar al otro lado, para limpiar las alcantarillas. ¿Me deja pasar, por favor?
-> hub_filip_dia2

= hub_filip_dia2
* [QUEST: ¿Qué clase de aspecto traes?]
    # STATE: happy
    Pues señor, el que puedo.
    # STATE: sad
    ¡Tampoco es que venga a rebuscar en las alcantarillas porque me guste…!
    # STATE: neutral
    Con suerte encuentro algo de valor que vender para poder comer hoy.
    -> hub_filip_dia2
+ [DOC: ¿Y tu permiso de trabajo?]
    # STATE: sad
    ¿Mi… Permiso? No tengo, señor.
    -> hub_filip_dia2
* [DEC: Dejar pasar]
    # STATE: happy
    ~ filip_dia2_paso = true
    ¿¡De verdad!? ¡Muchísimas gracias!
    -> bernard_tarde_dia2
* [DEC: No dejar pasar]
    # STATE: sad
    … (No dice nada y se va)
    -> bernard_tarde_dia2
* [DEC: Llamar a los guardias]
    # STATE: sad
    # PARANOIA: 2
    Los guardias agarran al joven y lo inmovilizan contra el suelo. Él intenta revolverse y escapar, pero finalmente uno de ellos le golpea en la cabeza y el alcantarillero cede. Pocos segundos después no queda nadie frente a los ojos de Henry.
    -> bernard_tarde_dia2
- -> bernard_tarde_dia2

=== bernard_tarde_dia2 ===
# NPC: bernard
# STATE: neutral
Buenas tardes. Este par de días me va a tener usted hasta en la sopa…
# STATE: concerned
Aunque seguro que esa sería mucho más deliciosa que la que tuve que sufrir anoche.
# STATE: angry
¿En qué clase de mundo vivimos como para que una cocinera no sepa hacer bien su trabajo?
-> hub_bernard_dia2

= hub_bernard_dia2
* [QUEST: ¿Qué llevaba la sopa para que estuviera tan mala?]
    # STATE: concerned
    Si le soy sincero, incluso haciendo uso de mi exquisito paladar, lo único que pude distinguir fue algo parecido a la carne de una rata.
    -> hub_bernard_dia2
+ [DOC: ¿Me deja ver su permiso de trabajo?]
    # STATE: angry
    ¿Mi permiso de trabajo? ¿Por qué debería? Pude pasar ayer sin él.
    -> hub_bernard_dia2
* [DEC: Dejar pasar]
    # STATE: neutral
    ~ bernard_dia2_paso = true
    Hasta luego.
    -> cazador_noche_dia2
* [DEC: No dejar pasar]
    # STATE: angry
    # PARANOIA: 1
    ¿Le pagan por su incompetencia?
    -> cazador_noche_dia2
* [DEC: Llamar a los guardias]
    # STATE: neutral
    # PARANOIA: 2
    Los guardias se acercan al hombre, pero ves que tras unos minutos, no han hecho más que conversar. Finalmente Henry ve que han dejado pasar al hombre sin ningún impedimento.
    -> cazador_noche_dia2
- -> cazador_noche_dia2

=== cazador_noche_dia2 ===
# NPC: arthur
# STATE: happy
¡Buenas noches, caballero! Quisiera entrar en el barrio, las ratas nos están esperando. Ya sabe usted, últimamente parecen montar sus propias fiestas, como la alta sociedad, pero esto no puede seguir así…
# STATE: neutral
Alguien tiene que hacer algo, y ahí es donde entramos nosotros.
-> hub_cazador_dia2

= hub_cazador_dia2
* [QUEST: ¿Cómo se llama su compañero?]
    # STATE: happy
    Este se llama Toby, lleva conmigo cinco años ya… No es el más listo, el pobre, pero se defiende bien en su tarea. Si no, habría tenido que buscarme otro.
    -> hub_cazador_dia2
* [QUEST: Parece experimentado, ¿desde hace cuánto trabaja en esto?]
    # STATE: happy
    ¡Desde bien pequeño! Las ratas y yo ya nos conocemos…
    # STATE: neutral
    Mucha gente las detesta, sobre todo los que no están acostumbrados a ellas, pero yo les veo algo en los ojos… Es algo que hay personas que no tienen en la mirada.
    -> hub_cazador_dia2
+ [DOC: ¿Me enseña su permiso de trabajo?]
    # STATE: happy
    ¿Acaso las ratas tienen permiso de entrada?
    # STATE: mad
    ¡Esto es serio, soldado! ¡Estamos hablando de la salud de estas personas!
    -> hub_cazador_dia2
* [DEC: Dejar pasar]
    # STATE: happy
    ~ cazador_dia2_paso = true
    ¡Gracias, buen hombre!
    -> fin_dia2
* [DEC: No dejar pasar]
    # STATE: mad
    # PARANOIA: 1
    Venga, hombre, ¿va a dejar que a los ricachones les coman las ratas?
    -> fin_dia2
* [DEC: Llamar a los guardias]
    # STATE: mad
    # PARANOIA: 2
    ¡Eh, eh! ¿¡Qué hacéis!? Henry ve a los guardias acercarse al hombre, que ha adoptado una postura muy defensiva. Los guardias se aproximan cautelosos, pero el cazador de ratas se lanza al ataque junto a su perro. Cuando los refuerzos llegan, el cazador está exhausto y se rinde al suelo. Henry, desde el interior, ve al perro ser apaleado hasta que también cae y deja de luchar.
    -> fin_dia2
- -> fin_dia2

=== fin_dia2 ===
# NPC: none
# DAY_END:
-> END
