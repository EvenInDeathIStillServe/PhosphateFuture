/obj/structure/plant
	name = "plant"
	desc = "Now I have become a farmer, creator of agriculture. Somebody help me."
	icon = 'icons/farming/plants.dmi'
	var/perennial = 1
	var/product = /obj/item/reagent_container/food/snack/produce
	var/plant_type = "plant"
	var/stage = 0


/obj/structure/plant/New()
	spawn(500)
		stage = 1
		icon_state = "[plant_type]_1"
		spawn(400)
			stage = 2
			icon_state = "[plant_type]_2"

/obj/structure/plant/attack_hand(mob/user)
	if(stage < 2)
		user << "[src] is not ready for harvest yet."
		return
	user << "You harvest [src]."
	for(var/i=rand(1,4), i>0, i--)
		new product(src.loc)
	if(!perennial)
		del src
	else
		stage = 1
		icon_state = "[plant_type]_1"
		spawn(400)
			stage = 2
			icon_state = "[plant_type]_2"