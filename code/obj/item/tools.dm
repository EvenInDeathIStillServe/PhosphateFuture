/obj/item/weapon/pickaxe
	name = "pickaxe"
	desc = "Made to break rocks, you suppose."
	icon_state = "pickaxe"
	item_state = "pickaxe"

/obj/item/weapon/axe
	name = "axe"
	desc = "Made to chop trees, you suppose."
	icon_state = "axe"

/obj/item/weapon/shovel
	name = "shovel"
	desc = "Made to move dirt, you suppose."
	icon_state = "shovel"
	var/dirt_type

/obj/item/weapon/shovel/attack_self(mob/user)
	if(dirt_type)
		icon_state = "shovel"
		user << "You throw away the [dirt_type]."
		dirt_type = null //Text var. Currently can be "dirt" or "sand". I don't like "sand".

/obj/item/weapon/wrench
	name = "wrench"
	desc = "Made to wrench things, you suppose."
	icon_state = "wrench"

/obj/item/weapon/screwdriver
	name = "screwdriver"
	desc = "Screw everything!"
	icon_state = "screwdriver"