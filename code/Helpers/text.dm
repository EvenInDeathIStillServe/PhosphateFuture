var/list/zero_character_only = list("0")
var/list/hex_characters = list("0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f")
var/list/alphabet = list("A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z")
var/list/binary = list("0","1")

/proc/repeat_string(times, string="")
	. = ""
	for(var/i=1, i<=times, i++)
		. += string