/obj/item/clothing/head
	icon = 'icons/clothing/hats.dmi'
	slot_flags = SLOT_HEAD

/obj/item/clothing/head/hardhat
	name = "hard hat"
	desc = "Will protect your cranium in industrial environments. Watch your head!"
	icon_state = "hardhat"
	item_state = "hardhat"

/obj/item/clothing/head/hardhat/white
	name = "foreman's hard hat"
	desc = "Legend says that whoever wears this becomes a master of construction."
	icon_state = "white_hardhat"
	item_state = "white_hardhat"

/obj/item/clothing/head/ushanka
	name = "ushanka"
	desc = "Perfect for winter in Siberia, da?"
	icon_state = "ushankadown"
	item_state = "ushankadown"
	flags_inv = HIDEEARS|HIDEHAIR
	var/earflaps = 1

/obj/item/clothing/head/ushanka/attack_self(mob/user)
	if(earflaps)
		src.icon_state = "ushankaup"
		src.item_state = "ushankaup"
		earflaps = 0
		user << "<span class='notice'>You raise the ear flaps on the ushanka.</span>"
	else
		src.icon_state = "ushankadown"
		src.item_state = "ushankadown"
		earflaps = 1
		user << "<span class='notice'>You lower the ear flaps on the ushanka.</span>"

/obj/item/clothing/head/chefhat
	name = "chef's hat"
	desc = "The commander in chef's head wear."
	item_state = "chef"
	icon_state = "chef"

/obj/item/clothing/head/helmet/pasgt
	name = "PASGT Helmet"
	desc = "Standard issue modern kevlar helmet. Good for keeping your head attached."
	icon_state = "pasgt"
	item_state = "pasgt"