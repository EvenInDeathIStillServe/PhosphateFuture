/obj/item/reagent_container/food/snack/produce
	name = "produce"
	icon = 'icons/farming/produce.dmi'
	var/seed_type = null

/obj/item/reagent_container/food/snack/produce/New()
	pixel_x = rand(0,8)-4
	pixel_y = rand(0,4)-4

/obj/item/reagent_container/food/snack/produce/attack_self(mob/user)
	user << "You get a seed from [src]."
	new seed_type(user.loc)
	del src

/obj/item/reagent_container/food/snack/produce/carrot
	name = "carrot"
	desc = "Carrots! They're good for your eyes!"
	icon_state = "carrot"
	mood_effect = 5
	seed_type = /obj/item/seed/carrot

/obj/item/reagent_container/food/snack/produce/tomato
	name = "tomato"
	desc = "It's a tomato! We still don't know if it's a fruit or a vegetable, but this won't stop us from making salsa!"
	icon_state = "tomato"
	mood_effect = 5
	seed_type = /obj/item/seed/tomato

/obj/item/reagent_container/food/snack/produce/potato
	name = "potato"
	desc = "I can already taste the fries."
	icon_state = "potato"
	mood_effect = 5
	seed_type = /obj/item/seed/potato
	processed_type = /obj/item/reagent_container/food/snack/fries