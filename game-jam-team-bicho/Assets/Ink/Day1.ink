VAR dorothy_dia1_paso = false
VAR annabel_dia1_paso = false
VAR empresario_dia1_paso = false

-> pregonero_inicio

=== pregonero_inicio ===
# NPC: none
¡Oíd, oíd! La prosperidad de nuestra ciudad es la envidia de la región. Gracias al esfuerzo de los ciudadanos honrados y trabajadores, nuestras calles siguen siendo ejemplo de orden y civilización. ¡Un barrio limpio es un barrio seguro!
-> dorothy_manana

=== dorothy_manana ===
# NPC: dorothy
Buenos días, Henry. Ya vamos a lo de siempre. Espero que la artritis deje a mis dedos trabajar un poco más, no quiero dejar el vestido de Lady Beatrice a medias…

-> hub_dorothy

= hub_dorothy
* [QUEST: ¿Un cóctel?]
    Lo celebran en la mansión de los Pembroke. Creo que están intentando casar a su hija ya y buscan un candidato… ¿Por qué no te presentas, Henry?
    -> hub_dorothy
* [QUEST: Podría prestarte dinero si lo necesitas.]
    No, no te preocupes, querido. Ya lo sabes, a final de mes siempre tenemos que andar con más cuidado.
    -> hub_dorothy
+ [DOC: ¿Documentación?]
    Claro, hijo, aquí tienes.
    -> hub_dorothy
* [DEC: Dejar pasar]
    ~ dorothy_dia1_paso = true
    Gracias, hijo. Ten un buen día.
    -> annabel_tarde
* [DEC: No dejar pasar]
    # PARANOIA: 1
    ¿Henry? No bromees de esa manera, cielo santo. Me has asustado.
    -> annabel_tarde

=== annabel_tarde ===
# NPC: annabel
Hola, Henry. ¿Cómo va tu mañana? Esta mañana en la consulta se presentaron un par de personas con algunos síntomas muy extraños.

-> hub_annabel

= hub_annabel
* [QUEST: ¿Qué tipo de síntomas?]
    Decían que partes de su cuerpo estaban cambiando de lugar… Parece más bien un trastorno psicológico, pero me resultó curioso que vinieran dos personas.
    -> hub_annabel
* [QUEST: ¿Cómo se encuentran?]
    Por ahora estables, aunque decían que les dolía mucho el vientre. Veremos cómo progresan.
    -> hub_annabel
+ [DOC: ¿Documentación?]
    Aquí tienes.
    -> hub_annabel
* [DEC: Dejar pasar]
    ~ annabel_dia1_paso = true
    Hasta luego, Henry.
    -> empresario_noche
* [DEC: No dejar pasar]
    # PARANOIA: 1
    Henry, ya nos conocemos, esta vez no me lo creo.
    -> empresario_noche

=== empresario_noche ===
# NPC: empresario
Soldado, haga el favor de abrir las puertas. He tenido un día atareado en la fábrica y no estoy como para perder el tiempo. Tengo una cena a la que asistir.

-> hub_empresario

= hub_empresario
* [QUEST: ¿Qué trabajo desempeña?]
    Soy el jefe de una fábrica de seda. Hoy he tenido que gestionar la ausencia de dos de mis empleados, que han decidido no presentarse.
    -> hub_empresario
* [QUEST: ¿Es una cena importante?]
    Por supuesto, todas las cenas que incluyan la presencia de un empresario como yo son naturalmente trascendentales.
    -> hub_empresario
+ [DOC: ¿Documentación?]
    Aquí tiene.
    -> hub_empresario
* [DEC: Dejar pasar]
    ~ empresario_dia1_paso = true
    Buenas noches.
    -> fin_dia1
* [DEC: No dejar pasar]
    # PARANOIA: 1
    Por esta vez lo dejaré pasar, pero la próxima vez reportaré este comportamiento a su superior.
    -> fin_dia1

=== fin_dia1 ===
# NPC: none
# DAY_END:
-> END