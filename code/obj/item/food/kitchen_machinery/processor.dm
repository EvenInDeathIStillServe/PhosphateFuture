/obj/machinery/food_processor
	name = "food processor"
	desc = "This handy appliance is controlled by an internal AI which calculates the most efficient way to prepare the foodstuffs it is given. In other words, it makes fries!"
	icon = 'icons/obj/kitchen.dmi'
	icon_state = "processor"
	density = 1
	var/max_items = 10
	var/busy = 0

/obj/machinery/food_processor/attackby(obj/item/weapon/W, mob/user)
	if(busy)
		user << "<span class='red'>[src] is busy."
		return
	if(istype(W,/obj/item/reagent_container/food/snack))
		if(contents.len >= max_items)
			user << "<span class='red'>[src] is full."
			return
		var/obj/item/reagent_container/food/snack/S = W
		if(S.processed_type)
			user.drop(src)
			user << "<span class='notice'>You add [S] to [src]."
		else
			user << "<span class='red'>I don't think I can process [S]."

/obj/machinery/food_processor/attack_hand(user)
	if(busy)
		user << "<span class='red'>[src] is busy."
		return
	if(!contents.len)
		user << "<span class='red'>[src] is empty."
		return
	user << "You turned [src] on."
	busy = 1
	playsound(loc,'sounds/processor.ogg', 70, 0, 1, 1)
	spawn(50)
		for(var/obj/item/reagent_container/food/snack/S in contents)
			new S.processed_type(src.loc)
			del S
		busy = 0