/obj/effects/blood
	name = "blood"
	desc = "Yuck!"
	icon = 'icons/effects/blood.dmi'
	icon_state = "floor1"
	layer = BELOW_OBJ_LAYER

/obj/effects/blood/New()
	icon_state = "floor[rand(1,12)]"