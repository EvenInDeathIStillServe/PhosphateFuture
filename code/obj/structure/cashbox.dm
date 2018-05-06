/obj/structure/cashbox
	name = "deposit Box"
	desc = "Sell refined goods for money."
	icon_state = "cashbox"
	density = 1

/obj/structure/cashbox/attackby(var/obj/item/W, mob/user)
	if(W.value)
		user << "You sell [W] for [W.value] credits."
		money += W.value
		del W