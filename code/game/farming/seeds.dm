/obj/item/seed
	name = "seed"
	desc = "We all have to start somewhere."
	icon = 'icons/farming/seeds.dmi'
	var/plant_name = null
	var/plant_type = null
	var/perennial = 1
	var/product = /obj/item/reagent_container/food/snack/produce

/obj/item/seed/proc/plant_seed(var/turf/plantloc)
	var/obj/structure/plant/P = new(plantloc)
	P.name = plant_name
	P.plant_type = plant_type
	P.perennial = perennial
	P.product = product
	P.icon_state = plant_type

/obj/item/seed/carrot
	name = "carrot seed"
	icon_state = "seed_carrot"
	plant_name = "carrot plant"
	plant_type = "carrot"
	perennial = 0
	product = /obj/item/reagent_container/food/snack/produce/carrot

/obj/item/seed/tomato
	name = "tomato seed"
	icon_state = "seed_tomato"
	plant_name = "tomato plant"
	plant_type = "tomato"
	product = /obj/item/reagent_container/food/snack/produce/tomato

/obj/item/seed/potato
	name = "potato seed"
	icon_state = "seed_potato"
	plant_name = "potato plant"
	plant_type = "potato"
	perennial = 0
	product = /obj/item/reagent_container/food/snack/produce/potato