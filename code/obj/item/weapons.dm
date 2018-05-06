/obj/item/weapon
	icon = 'icons/obj/items/weapons.dmi'

/obj/item/weapon/glass_shard
	name = "glass shard"
	desc = "Careful, it's sharp!"
	icon_state = "shard1"

/obj/item/weapon/glass_shard/New()
	..()
	icon_state = "shard[rand(1,3)]"