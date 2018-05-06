/obj/item/medical
	icon = 'icons/obj/items/medical.dmi'
	var/healing

/obj/item/medical/gauze_pack
	name = "gauze pack"
	icon_state = "gauze_pack"
	healing = 30
	var/full = 5

/obj/item/medical/gauze_pack/examine(user)
	..()
	switch(full)
		if(0)
			to_chat(user, "<span class='warning'>It's empty.</span>")
		if(1)
			to_chat(user, "<span class='notice'>It only has 1 roll left.</span>")
		else
			to_chat(user, "<span class='notice'>It has [full] rolls left.</span>")


/obj/item/medical/gauze_pack/attack(atom/target, mob/user)
	if(istype(target,/mob/living))
		var/mob/living/L = target
		if(L.stat == DEAD)
			to_chat(user, "<span class='danger'>[L] is DEAD!</span>")
			return
		if(!full)
			to_chat(user, "<span class='warning'>[src] is empty.</span>")
			return
		if(L.health >= 100)
			to_chat(user, "<span class='warning'>[L] doesn't need any healing.</span>")
			return
		L.heal(healing)
		user.visible_message(
			"<span class='notice'>[user] applies [src] to [L]</span>"
			)
		full--
		if(!full)
			icon_state = "[icon_state]0"