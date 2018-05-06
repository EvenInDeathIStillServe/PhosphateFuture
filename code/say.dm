/mob/verb/say(msg as text)
	var/speechverb = null
	switch(say_test(msg))
		if(1)
			speechverb = "asks"
		if(2)
			speechverb = pick("yells","exclaims","shouts")
		else
			speechverb = "says"
	for(var/M in hearers(src))
		M << "<b>[usr]</b> [speechverb] \"[msg]\""

/mob/proc/say_test(var/text)
	var/ending = copytext(text, length(text))
	if (ending == "?")
		return 1
	else if (ending == "!")
		return 2
	return 0