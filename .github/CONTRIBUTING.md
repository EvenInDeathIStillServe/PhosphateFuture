# Contributing

## Introduction
This is a short document intended to get you started with contributing to PhosphateFuture, whether in simply reporting issues or developing on the game directly.

## Reporting Issues
When reporting an issue, do a quick search using Github's built in search function to see if it's been reported yet. If it has been reported, feel free to add additional details to the current report or simply confirm that you are experiencing it.

In the event that it has not been reported, use the following as a quick guideline for how to report the bug.

**Description**: Describe the issue to the best of your ability.

**Steps to Reproduce**: What steps you could take in order to reproduce the issue.

**Expected Result**: What you expect to happen in this situation.

**Actual Result**: What actually did happen in this situation.

**Notes**: Anything additional that you would like to say regarding the issue.

By adhering to these reporting guidelines, you will make it significantly more likely that your issue may be diagnosed and fixed.

## Developer Specifications
This is a sort of style guide for developers to use when working on the codebase. As expected, adherence will result in a more consistent codebase that anyone is more likely to be able to read and follow in the future.

### Absolute Pathing

DM will allow you nest almost any type keyword into a block, such as:

```DM
datum
	datum1
		var
			varname1 = 1
			varname2
			static
				varname3
				varname4
		proc
			proc1()
				code
			proc2()
				code

		datum2
			varname1 = 0
			proc
				proc3()
					code
			proc2()
				..()
				code
```
he use of this is not allowed in this project as it makes finding definitions via full text searching next to impossible. The only exception is the variables of an object may be nested to the object, but must not nest further.

The previous code made compliant:

```DM
/datum/datum1
	var/varname1
	var/varname2
	var/static/varname3
	var/static/varname4

/datum/datum1/proc/proc1()
	code
/datum/datum1/proc/proc2()
	code
/datum/datum1/datum2
	varname1 = 0
/datum/datum1/datum2/proc/proc3()
	code
/datum/datum1/datum2/proc2()
	..()
	code
```

### Type paths must begin with a /
eg: `/datum/thing`, not `datum/thing`

### Datum type paths must begin with "datum"
In DM, this is optional, but omitting it makes finding definitions harder.

### Do not use text/string based type paths
It is rarely allowed to put type paths in a text format, as there are no compile errors if the type path no longer exists. Here is an example:

```DM
//Good
var/path_type = /obj/item/baseball_bat

//Bad
var/path_type = "/obj/item/baseball_bat"
```

### Use var/name format when declaring variables
While DM allows other ways of declaring variables, this one should be used for consistency.

```DM
// Good
/mob
	var/age

// Bad
/mob
	var
		age

### No magic numbers or strings
This means stuff like having a "mode" variable for an object set to "1" or "2" with no clear indicator of what that means. Make these #defines with a name that more clearly states what it's for. For instance:
````DM
/datum/proc/do_the_thing(thing_to_do)
	switch(thing_to_do)
		if(1)
			(...)
		if(2)
			(...)
````
There's no indication of what "1" and "2" mean! Instead, you'd do something like this:
````DM
#define DO_THE_THING_REALLY_HARD 1
#define DO_THE_THING_EFFICIENTLY 2
/datum/proc/do_the_thing(thing_to_do)
	switch(thing_to_do)
		if(DO_THE_THING_REALLY_HARD)
			(...)
		if(DO_THE_THING_EFFICIENTLY)
			(...)
````
This is clearer and enhances readability of your code! Get used to doing it!
### Use early return
Do not enclose a proc in an if-block when returning on a condition is more feasible
This is bad:
````DM
/datum/datum1/proc/proc1()
	if (thing1)
		if (!thing2)
			if (thing3 == 30)
				do stuff
````
This is good:
````DM
/datum/datum1/proc/proc1()
	if (!thing1)
		return
	if (thing2)
		return
	if (thing3 != 30)
		return
	do stuff
````
This prevents nesting levels from getting deeper then they need to be.
### Operators
#### Spacing
(this is not strictly enforced, but more a guideline for readability's sake)

* Operators that should be separated by spaces
	* Boolean and logic operators like &&, || <, >, ==, etc (but not !)
	* Bitwise AND &
	* Argument separator operators like , (and ; when used in a forloop)
	* Assignment operators like = or += or the like
* Operators that should not be separated by spaces
	* Bitwise OR |
	* Access operators like . and :
	* Parentheses ()
	* logical not !

Math operators like +, -, /, *, etc are up in the air, just choose which version looks more readable.

#### Use
* Bitwise AND - '&'
	* Should be written as ```bitfield & bitflag``` NEVER ```bitflag & bitfield```, both are valid, but the latter is confusing and nonstandard.
* Associated lists declarations must have their key value quoted if it's a string
	* WRONG: list(a = "b")
	* RIGHT: list("a" = "b")

## Globals versus static

DM has a var keyword, called global. This var keyword is for vars inside of types. For instance:

```DM
mob
	var
		global
			thing = TRUE
```
This does NOT mean that you can access it everywhere like a global var. Instead, it means that that var will only exist once for all instances of its type, in this case that var will only exist once for all mobs - it's shared across everything in its type. (Much more like the keyword `static` in other languages like PHP/C++/C#/Java)

Isn't that confusing? 

There is also an undocumented keyword called `static` that has the same behaviour as global but more correctly describes BYOND's behaviour. Therefore, we always use static instead of global where we need it, as it reduces suprise when reading BYOND code.

## Sources/Thanks

The majority of this document is the excellent work of /tg/station, another project in BYOND accessible on Github [here](https://github.com/tgstation/tgstation/blob/master/.github/CONTRIBUTING.md). It has been repurposed and edited in a few locations to more accurately work with PhosphateFuture expectations.