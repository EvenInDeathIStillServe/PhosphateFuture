#define to_chat(target, message)                            target << message
#define to_world(message)                                   world << message
#define to_world_log(message)                               world.log << message
#define ishuman(A) istype(A, /mob/living/human)
#define isliving(A) istype(A, /mob/living)
#define islist(A) istype(A, /list)

#define qdel_null(x) if(x) { qdel(x) ; x = null }