/obj/item/reagent_container/food/snack
	name = "food"
	desc = "Nutritious!"
	icon = 'icons/food.dmi'
	icon_state = "burger"
	var/mood_effect = 0
	var/cooked_type
	var/processed_type

/obj/item/reagent_container/food/snack/attack(mob/living/human/M, mob/living/human/user)
	if(M == user)
		M.visible_message("[user] eats [src].")
	else
		M.visible_message("[user] feeds [src] to [M].")
	playsound(M, "sounds/eatfood.ogg", 50, 1)
	M.mood_level = M.mood_level + mood_effect
	del src

/obj/item/reagent_container/food/snack/meat
	name = "meat slab"
	desc = "It's raw meat. Would be better if it was cooked."
	icon_state = "meat"
	mood_effect = -5
	cooked_type = /obj/item/reagent_container/food/snack/steak

/obj/item/reagent_container/food/snack/steak
	name = "steak"
	desc = "A hot piece of steak. Delicious!"
	icon_state = "steak"
	mood_effect = 15


/obj/item/reagent_container/food/snack/burger
	name = "burger"
	desc = "Like the soda, it's a staple and a fattymcfat. It's a fine art made by professional cooks. (whose location's are unknown for now.)"
	icon_state = "burger"
	mood_effect = 10

/obj/item/reagent_container/food/snack/fries
	name = "french fries"
	desc = "Goes great with a burger!"
	icon_state = "fries"
	mood_effect = 5

/obj/item/reagent_container/food/snack/cheesewheel
	name = "cheese wheel"
	desc = "A big wheel of delcious Cheddar!"
	icon_state = "cheesewheel"
	mood_effect = 10

/obj/item/reagent_container/food/snack/cheesewheel/attackby(obj/item/weapon/W, mob/user)
	if(istype(W, /obj/item/kitchen/knife))
		if(!istype(src.loc,/turf))
			user << "<span class='red'>Put [src] down before slicing it.</span>"
			return
		user << "You slice [src]."
		for(var/i=5, i>0, i--)
			new /obj/item/reagent_container/food/snack/cheesewedge(src.loc)
		del src

/obj/item/reagent_container/food/snack/cheesewedge
	name = "cheese wedge"
	desc = "A wedge of delicious Cheddar. The cheese wheel it was cut from can't have gone far."
	icon_state = "cheesewedge"
	mood_effect = 2

/obj/item/reagent_container/food/snack/cheesewedge/New()
	pixel_x = rand(0,8)-4
	pixel_y = rand(0,4)-4

/obj/item/reagent_container/food/snack/baddrugs
	name = "non-descript drugs"
	desc = "Maybe you shouldn't stuff these down your throat.."
	icon_state = "drugs"
	mood_effect = -10