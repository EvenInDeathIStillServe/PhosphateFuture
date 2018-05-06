/datum/reagents
	var/list/datum/reagent/reagent_list = new/list()
	var/obj/item/weapon/reagent_container/holder
	var/total_volume = 0


/datum/reagents/New()
	if(!chemical_reagents_list)
		var/paths = subtypesof(/datum/reagent)
		chemical_reagents_list = list()
		for(var/path in paths)
			var/datum/reagent/D = new path()
			chemical_reagents_list[D.id] = D

/datum/reagents/proc/add_reagent_list(list/list_reagents)
	for(var/r_id in list_reagents)
		var/amt = list_reagents[r_id]
		add_reagent(r_id, amt)

/datum/reagents/proc/add_reagent(var/trans_reagent, var/amount)
	for(var/datum/reagent/R in reagent_list)
		if(R.id == trans_reagent)
			if((total_volume + amount) > holder.volume)
				amount = holder.volume - total_volume
			R.volume += amount
			total_volume += amount
			return
	var/datum/reagent/D = chemical_reagents_list[trans_reagent]
	if(D)
		var/datum/reagent/R = new D.type()
		reagent_list += R
		R.volume = amount
		total_volume += amount


/datum/reagents/proc/remove_reagent(trans_reagent, amount)
	for(var/datum/reagent/R in reagent_list)
		if(R.id == trans_reagent)
			R.volume -= amount
			total_volume -= amount
			if(R.volume <= 0)
				reagent_list.Remove(R)
			break

/datum/reagents/proc/trans_to(datum/reagents/target, var/amount_to_transfer, var/get_rid_of = 0)
	if(!amount_to_transfer)
		return
	var/trans = round(min((target.holder.volume - target.total_volume),amount_to_transfer,total_volume), 0.1)
	for(var/datum/reagent/R in reagent_list)
		var/specific_trans = round((R.volume / total_volume)*trans, 0.1)
		if(!get_rid_of)
			target.add_reagent(R.id,specific_trans)
		remove_reagent(R.id,specific_trans)
	return trans

/datum/reagent
	var/name = "Reagent"
	var/id = "reagent"
	var/volume = 0
	var/liquid_color = "ffffff"

/obj/item/weapon/reagent_container
	var/datum/reagents/reagents = new
	var/transfer_amount = 10
	var/volume = 30
	var/list/list_reagents = null
	icon = 'icons/obj/items/chemical.dmi'

/obj/item/weapon/reagent_container/New()
	if(list_reagents)
		reagents.add_reagent_list(list_reagents)
	reagents.holder = src

/obj/item/weapon/reagent_container/examine(user)
	..()
	if(reagents.total_volume)
		user << "It has [reagents.total_volume] units of reagents in it."
	for(var/datum/reagent/R in reagents.reagent_list)
		user << "<span style='color: #[R.liquid_color]'>[R]: [R.volume] units.</span>"
	user << "It can hold [volume] units."

/obj/item/weapon/reagent_container/glass
	name = "glass"
	transfer_amount = 10
	volume = 50

/obj/item/weapon/reagent_container/glass/attackby(obj/item/weapon/W, mob/user)
	if(!istype(W,/obj/item/weapon/reagent_container))
		return
	var/obj/item/weapon/reagent_container/R = W
	if(R.reagents.total_volume > 0)
		if(src.reagents.total_volume < src.volume)
			var/trans = R.reagents.trans_to(src.reagents,R.transfer_amount)
			if(trans)
				user << "<span class='notice'>You transfer [trans] unit\s of the solution to [src].</span>"
		else
			user << "<span class='notice'>[src] is full.</span>"
	else
		user << "[W] is empty."

/obj/item/weapon/reagent_container/glass/attack(atom/target, mob/user)
	if(reagents.total_volume <= 0)
		user << "[src] is empty."
		return
	if(istype(target, /mob/living/human))
		var/mob/living/human/T = target
		if(T == user)
			src.reagents.trans_to(T.stomach.reagents, min(5, reagents.total_volume))
			playsound(T, "sounds/drink.ogg", 50, 1)
			T.visible_message("<span class='notice'>[user] drinks from [src].</span>")