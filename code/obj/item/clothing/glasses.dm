/obj/item/clothing/glasses
	icon = 'icons/clothing/glasses.dmi'
	slot_flags = SLOT_GLASSES

/obj/item/clothing/glasses/safety_goggles
	name = "safety goggles"
	desc = "Wearing this is for your own good."
	icon_state = "safety_goggles"
	item_state = "safety_goggles"

/obj/item/clothing/glasses/sunglasses
	name = "sunglasses"
	desc = "These will make you look cool. Even at night. Especially at night."
	icon_state = "sun"
	item_state = "sun"

/obj/item/clothing/glasses/eyepatch
	name = "eyepatch"
	desc = "Just what I needed for my pirate costume!"
	icon_state = "eyepatch_r"
	item_state = "eyepatch_r"
	var/state = 1

/obj/item/clothing/glasses/eyepatch/verb/adjust()
	set name = "Adjust eyepatch"
	set category = "Object"
	set src in usr

	switch(state)
		if(1)
			state = 2
			usr << "You adjust [src] to cover the left eye."
			icon_state = "eyepatch_l"
			item_state = "eyepatch_l"
		if(2)
			state = 1
			usr << "You adjust [src] to cover the right eye."
			icon_state = "eyepatch_r"
			item_state = "eyepatch_r"
	usr.update_icon()