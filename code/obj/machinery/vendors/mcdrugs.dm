/obj/machinery/vendingmachine/mcdrugs
	name = "McDrugs vending machine"
	desc = "Donated by the McDrugs Corporation, this vending machine contains frozen foods and medicine that are heated at 1000 degrees when ordered."
	icon_state = "mc_drugs"

/obj/machinery/vendingmachine/mcdrugs/attack_hand(user as mob)
	var/dat = {"<b>Food and Drugs! All you need in life.</b><br><br>
<A href='?src=\ref[src];product=0'>Burger</A> 10$<BR>
<A href='?src=\ref[src];product=1'>Completely Legal Pharmaceuticals</A> 5$<BR>
"}

	user << browse("<HEAD><TITLE>[src]</TITLE></HEAD><TT>[dat]</TT>", "window=mcdrugs")
	return

/obj/machinery/vendingmachine/mcdrugs/Topic(href, href_list)
	if(href_list["product"])
		if(!in_range(loc, usr))
			usr << browse(null, "window=mcdrugs")
			return
		var/product_type = text2num(href_list["product"])
		switch(product_type)
			if(0)
				new /obj/item/reagent_container/food/snack/burger(src.loc)
				money -= 5
			if(1)
				new /obj/item/reagent_container/food/snack/baddrugs(src.loc)
				money -= 5
	return