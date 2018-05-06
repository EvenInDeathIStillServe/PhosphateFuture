/obj/item/weapon/flamethrower
	name = "flamethrower"
	desc = "Also known as a \"Temperature Improvement Device\"."
	icon_state = "flamethrower"
	item_state = "flamethrower"
	var/last_fired

/obj/item/weapon/flamethrower/afterattack(atom/A, mob/living/user)
	if(last_fired + 20 > world.time)
		return
	last_fired = world.time
	playsound(src, "sounds/weapons/fire0[rand(1,3)].ogg", 100)
	var/turf/first = get_step_towards(user,A)
	new /obj/effects/fire(first)
	if(A.loc == first)
		return
	var/turf/second = get_step_towards(first,A)
	new /obj/effects/fire(second)
	if(A.loc == second)
		return
	var/turf/third = get_step_towards(second,A)
	new /obj/effects/fire(third)