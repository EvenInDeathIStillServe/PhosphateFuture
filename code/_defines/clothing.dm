//Bit flags for the flags_inv variable, which determine when a piece of clothing hides another. IE a helmet hiding glasses.
#define HIDEGLOVES		1
#define HIDESUITSTORAGE	2
#define HIDEJUMPSUIT	4	//these first four are only used in exterior suits
#define HIDESHOES		8
#define HIDEMASK		16	//these last six are only used in masks and headgear.
#define HIDEEARS		32	// (ears means headsets and such)
#define HIDEEYES		64	// Whether eyes and glasses are hidden
#define HIDEFACE		128	// Whether we appear as unknown.
#define HIDEHAIR		256
#define HIDEFACIALHAIR	512