/obj/machinery/photocopier
	name = "photocopier"
	desc = "Copy those documents with ease."
	icon_state = "photocopier"
	density = 1
	var/obj/item/weapon/paper/copytarget

/obj/machinery/photocopier/attackby(obj/item/weapon/W, mob/user)
	if(istype(W,/obj/item/weapon/paper))
		if(copytarget)
			user << "<span class='red'>There's already something in [src].</span>"
			return
		copytarget = W
		user.drop(src)

/obj/machinery/photocopier/attack_hand(user)
	if(copytarget)
		copytarget.loc = src.loc
		copytarget = null