/obj/machinery/vendingmachine
	name = "vending machine"
	icon_state = "vending_machine"
	density = 1

/obj/machinery/vendingmachine/attack_hand(user as mob)
	if(..())
		return

	var/dat = {"<b>Tools! Tools! Tools!</b><br><br>
<A href='?src=\ref[src];product=0'>Pickaxe</A> 15$<BR>
<A href='?src=\ref[src];product=1'>Axe</A> 10$<BR>
<A href='?src=\ref[src];product=2'>Shovel</A> 10$<BR>
<A href='?src=\ref[src];product=3'>Wrench</A> 15$<BR>
"}

	user << browse("<HEAD><TITLE>[src]</TITLE></HEAD><TT>[dat]</TT>", "window=vending_machine")
	return

/obj/machinery/vendingmachine/Topic(href, href_list)
	if(..())
		return
	if(href_list["product"])
		if(!in_range(loc, usr))
			usr << browse(null, "window=vending_machine")
			return
		var/product_type = text2num(href_list["product"])
		switch(product_type)
			if(0)
				new /obj/item/weapon/pickaxe(src.loc)
				money -= 15
			if(1)
				new /obj/item/weapon/axe(src.loc)
				money -= 10
			if(2)
				new /obj/item/weapon/shovel(src.loc)
				money -= 10
			if(3)
				new /obj/item/weapon/wrench(src.loc)
				money -= 15

	return