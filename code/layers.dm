//Ooooh, layers! Let's use them!

//#define TURF_LAYER 2 //For easy recordkeeping; this is a byond define
#define BELOW_OBJ_LAYER 2.9
//#define OBJ_LAYER 3 //For easy recordkeeping; this is a byond define
#define ABOVE_OBJ_LAYER 3.1
#define BELOW_MOB_LAYER 3.9
//#define MOB_LAYER 4 //For easy recordkeeping; this is a byond define
#define ABOVE_MOB_LAYER 4.1

#define EFFECTS_BELOW_LIGHTING_PLANE   -4 // For special effects.

	#define BELOW_PROJECTILE_LAYER  2
	#define FIRE_LAYER              3
	#define PROJECTILE_LAYER        4
	#define ABOVE_PROJECTILE_LAYER  5
	#define SINGULARITY_LAYER       6
	#define POINTER_LAYER           7

#define LIGHTING_PLANE 			       -2 // For Lighting. - The highest plane (ignoring all other even higher planes)

	#define LIGHTBULB_LAYER        0
	#define LIGHTING_LAYER         1
	#define ABOVE_LIGHTING_LAYER   2
	#define SUPER_PORTAL_LAYER     3
	#define NARSIE_GLOW            4

#define EFFECTS_ABOVE_LIGHTING_PLANE   -1 // For glowy eyes, laser beams, etc. that shouldn't be affected by darkness
	#define EYE_GLOW_LAYER         1
	#define BEAM_PROJECTILE_LAYER  2
	#define SUPERMATTER_WALL_LAYER 3

#define HUD_PLANE                       4 // For the Head-Up Display

	#define UNDER_HUD_LAYER      0
	#define HUD_BASE_LAYER       1
	#define HUD_ITEM_LAYER       2
	#define HUD_ABOVE_ITEM_LAYER 3