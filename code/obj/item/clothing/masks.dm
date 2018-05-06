/obj/item/clothing/mask
	icon = 'icons/clothing/masks.dmi'
	slot_flags = SLOT_MASK

/obj/item/clothing/mask/shemagh
	name = "shemagh"
	desc = "Protects your face from wind, dust and sand. It can also be adjusted. All in all, a practical item of clothing!"
	icon_state = "shemagh1"
	item_state = "shemagh1"
	flags_inv = HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	var/state = 1 //1 = Hides everything, 2 = Hides head, 3 = Hides face, 4 = Doesn't hide anything, covers neck

/obj/item/clothing/mask/shemagh/New()
	spawn(1)
		if(istype(loc,/mob))
			state = rand(1,4)
			change_position()

/obj/item/clothing/mask/shemagh/verb/adjust()
	set name = "Adjust shemagh"
	set category = "Object"
	set src in usr

	change_position()

/obj/item/clothing/mask/shemagh/proc/change_position()
	switch(state)
		if(1)
			state = 2
			flags_inv = HIDEHAIR
			usr << "You adjust [src] to reveal your face."
		if(2)
			state = 3
			flags_inv = HIDEFACE|HIDEFACIALHAIR
			usr << "You adjust [src] to cover your mouth."
		if(3)
			state = 4
			flags_inv = null
			usr << "You adjust [src] to cover your neck."
		if(4)
			state = 1
			flags_inv = HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
			usr << "You adjust [src] to cover your head."
	icon_state = "shemagh[state]"
	item_state = "shemagh[state]"
	usr.update_icon()

/obj/item/clothing/mask/respirator
	name = "respirator"
	desc = "An apparatus which is often used in mines to filter out dangerous substance from the air."
	icon_state = "respirator"
	item_state = "respirator"

/obj/item/clothing/mask/gas
	name = "gas mask"
	desc = "Top-notch protection from gases. It even covers your face!"
	icon_state = "gas_mask"
	item_state = "gas_mask"
	flags_inv = HIDEFACE|HIDEFACIALHAIR