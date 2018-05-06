/obj/item/stack
	icon_state = "planks"
	icon = 'icons/obj/items/stacks.dmi'
	gender = PLURAL
	var/max_stack = 50
	var/amount = 1
	var/single_value = 1

/obj/item/stack/New(var/loc, var/amount = null)
	..()
	if (amount)
		src.amount = amount
	value = single_value * amount

/obj/item/stack/examine(user)
	..()
	user << "There are [amount] units in this stack."

/obj/item/stack/attackby(var/obj/item/weapon/W, mob/user)
	if(W.type == src.type)
		src.transfer(W)

/obj/item/stack/proc/transfer(var/obj/item/stack/target, var/recursive = 1)
	if(target.type != src.type)
		return
	var/amount_to_add = max(min(src.amount, (target.max_stack - target.amount)), 0)
	target.amount = target.amount + amount_to_add
	src.amount = src.amount - amount_to_add
	target.value = target.single_value * target.amount
	src.value = src.single_value * src.amount
	if(src.amount <= 0)
		if(!recursive)
			del src
		for(var/obj/item/stack/other in src.loc)
			if(target.amount >= target.max_stack)
				break
			if(other.type == target.type && other != target)
				other.transfer(target,0)
		del src


/obj/item/stack/proc/use(var/used_amount)
	if(used_amount > amount)
		usr << "There isn't enough in this stack. You need [used_amount - amount] more units."
		return 0
	amount = amount - used_amount
	value = single_value * amount
	if(amount <= 0)
		var/obj/item/stack/deleted_stack = src
		src = null
		del deleted_stack
	return 1

/obj/item/stack/planks
	name = "planks"
	desc = "It's a bunch of planks. Good for woodworking."
	icon_state = "planks"
	single_value = 5

/obj/item/stack/concrete
	name = "concrete slabs"
	desc = "Concrete is a versatile building material. These slabs can be used to make floors, walls, and...other things?"
	icon_state = "concrete"
	single_value = 5