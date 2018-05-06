#define UI_LAYER 20


#define INFINITY 1e31

// Flags for pass_flags.
#define PASSTABLE  0x1
#define PASSGLASS  0x2
#define PASSGRILLE 0x4

// Special return values from bullet_act(). Positive return values are already used to indicate the blocked level of the projectile.
#define PROJECTILE_CONTINUE   -1 //if the projectile should continue flying after calling bullet_act()
#define PROJECTILE_FORCE_MISS -2 //if the projectile should treat the attack as a miss (suppresses attack and admin logs) - only applies to mobs.