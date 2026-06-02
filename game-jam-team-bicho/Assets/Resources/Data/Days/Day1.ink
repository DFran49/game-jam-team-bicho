VAR dorothy_dia1_paso = false
VAR annabel_dia1_paso = false
VAR bernard_dia1_paso = false

-> pregonero_inicio

=== pregonero_inicio ===
# NPC: none
¡Oíd, oíd! La prosperidad de nuestra ciudad es la envidia de la región. Gracias al esfuerzo de los ciudadanos honrados y trabajadores, nuestras calles siguen siendo ejemplo de orden y civilización. Recordad, la seguridad de todos depende de la vigilancia de cada uno. ¡Un barrio limpio es un barrio seguro!
-> dorothy_manana

=== dorothy_manana ===
# NPC: dorothy
# STATE: happy
Buenos días, Henry. Ya vamos a lo de siempre. Espero que la artritis deje a mis dedos trabajar un poco más, no quiero dejar el vestido de Lady Beatrice a medias, lo necesita para su cóctel de la semana que viene… ¡Y yo necesito el dinero para llevarme algo de pan a la boca…!
-> hub_dorothy

= hub_dorothy
* [QUEST: ¿Un cóctel?]
    # STATE: neutral
    Lo celebran en la mansión de los Pembroke, según he escuchado. Creo que están intentando casar a su hija ya y buscan un candidato… ¿Por qué no te presentas, Henry?
    -> hub_dorothy
* [QUEST: Podría prestarte dinero si lo necesitas.]
    # STATE: neutral
    No, no te preocupes, querido. Ya lo sabes, a final de mes siempre tenemos que andar con más cuidado.
    -> hub_dorothy
+ [DOC: ¿Documentación?]
    # STATE: neutral
    Claro, hijo, aquí tienes.
    -> hub_dorothy
* [DEC: Dejar pasar]
    # STATE: neutral
    ~ dorothy_dia1_paso = true
    Gracias, hijo. Ten un buen día.
    -> annabel_tarde
* [DEC: No dejar pasar]
    # STATE: sad
    # PARANOIA: 1
    ¿Henry? No bromees de esa manera, cielo santo. Me has asustado.
    -> annabel_tarde
- -> annabel_tarde

=== annabel_tarde ===
# NPC: annabel_sin
# STATE: happy
Hola, Henry. ¿Cómo va tu mañana? Yo la tengo ocupada, esta mañana en la consulta se presentaron un par de personas con algunos síntomas muy extraños que no había visto nunca.
-> hub_annabel

= hub_annabel
* [QUEST: ¿Qué tipo de síntomas?]
    # STATE: neutral
    Decían que partes de su cuerpo estaban cambiando de lugar… Si te soy sincera, parece más bien un trastorno psicológico, pero me resultó curioso que vinieran dos personas. Puede que sólo estuvieran bromeando.
    -> hub_annabel
* [QUEST: ¿Cómo se encuentran?]
    # STATE: neutral
    ¿Por ahora? Estables, aunque decían que les dolía mucho el vientre. Veremos cómo progresan.
    -> hub_annabel
+ [DOC: ¿Documentación?]
    # STATE: neutral
    Aquí tienes.
    -> hub_annabel
* [DEC: Dejar pasar]
    # STATE: happy
    ~ annabel_dia1_paso = true
    Hasta luego, Henry.
    -> bernard_noche
* [DEC: No dejar pasar]
    # STATE: mad
    # PARANOIA: 1
    Henry, ya nos conocemos, esta vez no me lo creo.
    -> bernard_noche
- -> bernard_noche

=== bernard_noche ===
# NPC: bernard
# STATE: neutral
Soldado, haga el favor de abrir las puertas.
# STATE: concerned
He tenido un día atareadísimo en la fábrica y no estoy como para perder el tiempo. Tengo una cena a la que asistir.
-> hub_bernard

= hub_bernard
* [QUEST: ¿Qué trabajo desempeña?]
    # STATE: happy
    Soy el jefe, por supuesto, de una fábrica de seda. ¿Qué otra cosa, si no? No, no se engañe, mi trabajo es mucho más importante.
    # STATE: angry
    Hoy he tenido que gestionar la ausencia de dos de mis empleados, que han decidido no presentarse. ¿Le parece eso normal?
    -> hub_bernard
* [QUEST: ¿Es una cena importante?]
    # STATE: happy
    Por supuesto, todas las cenas que incluyan la presencia de un empresario como yo son naturalmente trascendentales.
    -> hub_bernard
+ [DOC: ¿Documentación?]
    # STATE: neutral
    Aquí tiene.
    -> hub_bernard
* [DEC: Dejar pasar]
    # STATE: happy
    ~ bernard_dia1_paso = true
    Buenas noches.
    -> fin_dia1
* [DEC: No dejar pasar]
    # STATE: concerned
    # PARANOIA: 1
    Por esta vez lo dejaré pasar, pero la próxima vez reportaré este comportamiento a su superior.
    -> fin_dia1
- -> fin_dia1

=== fin_dia1 ===
# NPC: none
# DAY_END:
-> END
