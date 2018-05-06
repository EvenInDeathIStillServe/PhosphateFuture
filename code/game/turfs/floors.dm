/turf/floor/ground
	name = "ground"

/turf/floor/ground/grass
	name = "grass"
	icon_state = "grass1"
	stepsound = list('sounds/step/grass-01.ogg','sounds/step/grass-02.ogg','sounds/step/grass-03.ogg','sounds/step/grass-04.ogg')

/turf/floor/ground/grass/New()
	icon_state = "grass[rand(1,4)]"

/turf/floor/ground/attackby(obj/item/weapon/W, mob/user)
	if(istype(W, /obj/item/stack/planks))
		var/obj/item/stack/planks/P = W
		if(P.use(2))
			src.ChangeTurf(/turf/floor/wood)
	if(istype(W, /obj/item/stack/concrete))
		var/obj/item/stack/concrete/C = W
		if(C.use(2))
			src.ChangeTurf(/turf/floor/concrete)

/turf/floor/ground/grass/attackby(obj/item/weapon/W, mob/user)
	..()
	if(istype(W, /obj/item/acorn))
		user << "You plant [W] in the soil."
		new /obj/structure/sapling(src)
		del W
	if(istype(W, /obj/item/weapon/shovel))
		if(W:dirt_type == "dirt")
			new /obj/structure/soil(src)
			playsound(src,'sounds/shovel_down.ogg', 80, 0, 1)
			W:dirt_type = null
			W.icon_state = "shovel"
		else if(!W:dirt_type)
			user << "You pick up some dirt with [W]"
			playsound(src,'sounds/shovel_up.ogg', 80, 0, 1)
			W:dirt_type = "dirt"
			W.icon_state = "shovel_dirt"

/turf/floor/wood
	name = "wooden floor"
	icon_state = "wood"
	stepsound = list('sounds/step/wood-01.ogg','sounds/step/wood-02.ogg','sounds/step/wood-03.ogg','sounds/step/wood-04.ogg')

/turf/floor/wood/attackby(obj/item/weapon/W, mob/user)
	if(istype(W, /obj/item/stack/planks))
		var/obj/item/stack/planks/P = W
		if(P.use(3))
			user << "You build a wooden wall."
			src.ChangeTurf(/turf/wall/wood)

/turf/floor/concrete
	name = "concrete floor"
	icon_state = "concrete"
	stepsound = list('sounds/step/concrete-01.ogg','sounds/step/concrete-02.ogg','sounds/step/concrete-03.ogg','sounds/step/concrete-04.ogg')

/turf/floor/concrete/attackby(obj/item/weapon/W, mob/user)
	if(istype(W, /obj/item/stack/concrete))
		var/obj/item/stack/concrete/C = W
		if(C.use(3))
			user << "You build a concrete wall."
			src.ChangeTurf(/turf/wall/concrete)

/turf/floor/ground/sand
	name = "sand"
	icon_state = "sand"
	stepsound = list('sounds/step/sand-01.ogg','sounds/step/sand-02.ogg','sounds/step/sand-03.ogg','sounds/step/sand-04.ogg')

/turf/floor/ground/sand/attackby(obj/item/weapon/W, mob/user)
	if(istype(W, /obj/item/weapon/shovel))
		if(!W:dirt_type)
			user << "You pick up some sand with [W]"
			playsound(src,'sounds/shovel_up.ogg', 80, 0, 1)
			W:dirt_type = "sand"
			W.icon_state = "shovel_sand"

/turf/floor/rock
	name = "rock floor"
	icon = 'icons/floors/rock.dmi'
	icon_state = "rock"
	stepsound = list('sounds/step/stone-01.ogg','sounds/step/stone-02.ogg','sounds/step/stone-03.ogg','sounds/step/stone-04.ogg')
	pixel_y = -4
	pixel_x = -4

/turf/floor/rock/New()
	..()
	update_icon()

/turf/floor/rock/update_icon()
	var/overlap = 0
	for(var/direction in cardinal)
		if(istype(get_step(src,direction),/turf/floor/ground))
			overlap |= direction
	icon_state = "[overlap]"