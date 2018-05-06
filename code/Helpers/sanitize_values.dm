/proc/sanitize_hexcolor(color, desired_format=3, include_crunch=0, default)
	var/crunch = include_crunch ? "#" : ""
	if(!istext(color))
		color = ""

	var/start = 1 + (text2ascii(color,1)==35)
	var/len = length(color)
	var/step_size = 1 + ((len+1)-start != desired_format)

	. = ""
	for(var/i=start, i<=len, i+=step_size)
		var/ascii = text2ascii(color,i)
		switch(ascii)
			if(48 to 57)
				. += ascii2text(ascii)		//numbers 0 to 9
			if(97 to 102)
				. += ascii2text(ascii)		//letters a to f
			if(65 to 70)
				. += ascii2text(ascii+32)	//letters A to F - translates to lowercase
			else
				break

	if(length(.) != desired_format)
		if(default)
			return default
		return crunch + repeat_string(desired_format, "0")

	return crunch + .