/client
	var/played
	var/ambience_playing


client
	New() // new client made
		..() //call parents
		var/mob/old = src.mob
		var/mob/living/human/controlled = new /mob/living/human()
		controlled.client = src
		del old
		new /obj/screen/drop(src) //new hud
		new /obj/screen/take(src)
		new /obj/screen/swap(src)
		new /obj/screen/righthand(src)
		new /obj/screen/lefthand(src)
		new /obj/screen/selector(src)
		new /obj/screen/mood(src)
		new /obj/screen/inventory/back(src)
		new /obj/screen/inventory/head(src)
		new /obj/screen/inventory/glasses(src)
		new /obj/screen/inventory/mask(src)
		new /obj/screen/inventory/gloves(src)
		new /obj/screen/inventory/uniform(src)
		new /obj/screen/inventory/suit(src)
		new /obj/screen/inventory/shoes(src)

		switch(alert(src,"Do you want to customize your character's appearance?",,"Yes","No"))
			if("Yes")
				var/new_hair_style = input(src, "Choose your character's hairstyle:", "Character Preference") as null|anything in hair_styles
				if(new_hair_style)
					controlled.hair_style = new_hair_style

				var/new_hair_color = input(src, "Choose your character's hair colour:", "Character Preference") as color|null
				if(new_hair_color)
					controlled.hair_color = sanitize_hexcolor(new_hair_color)

				var/new_facial_hair_style = input(src, "Choose your character's facial hairstyle:", "Character Preference") as null|anything in facial_hair_styles
				if(new_facial_hair_style)
					controlled.facial_hair_style = new_facial_hair_style

				var/new_facial_hair_color = input(src, "Choose your character's facial hair colour:", "Character Preference") as color|null
				if(new_facial_hair_color)
					controlled.facial_hair_color = sanitize_hexcolor(new_facial_hair_color)

				var/new_eyes = input(src, "Choose your character's eye colour:", "Character Preference") as color|null
				if(new_eyes)
					controlled.eye_color = sanitize_hexcolor(new_eyes)
			if("No")
				controlled.hair_style = "Cut Hair"

		controlled.update_icon()

client
	Del()
		..()