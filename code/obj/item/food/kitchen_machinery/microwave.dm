/obj/machinery/microwave
	name = "microwave"
	desc = "Technological advances have almost eradicated the 'hot on the outside, cold on the inside' effect. Almost."
	icon = 'icons/obj/kitchen.dmi'
	icon_state = "mw"
	density = 1
	var/max_items = 10
	var/busy = 0

/obj/machinery/microwave/attackby(obj/item/weapon/W, mob/user)
	if(busy)
		user << "<span class='red'>[src] is busy."
		return
	if(istype(W,/obj/item/reagent_container/food/snack))
		if(contents.len >= max_items)
			user << "<span class='red'>[src] is full."
			return
		var/obj/item/reagent_container/food/snack/S = W
		if(S.cooked_type)
			user.drop(src)
			user << "<span class='notice'>You add [S] to [src]."
		else
			user << "<span class='red'>I don't think I can cook [S]."

/obj/machinery/microwave/attack_hand(user)
	if(busy)
		user << "<span class='red'>[src] is busy."
		return
	if(!contents.len)
		user << "<span class='red'>[src] is empty."
		return
	user << "You turned [src] on."
	busy = 1
	playsound(loc,'sounds/microwave_buttons.ogg', 70, 0, 1, 1)
	spawn(20)
		icon_state = "mw1"
		playsound(loc,'sounds/microwave_ambient2.ogg', 20, 0, 1, 1)
		spawn(100)
			playsound(loc,'sounds/microwave_ding.ogg', 40, 0, 1, 1)
			for(var/obj/item/reagent_container/food/snack/S in contents)
				new S.cooked_type(src.loc)
				del S
			busy = 0
			icon_state = "mw"