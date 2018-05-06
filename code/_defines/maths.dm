#define CLAMP(CLVALUE,CLMIN,CLMAX) ( max( (CLMIN), min((CLVALUE), (CLMAX)) ) )

#define Clamp(value, low, high) 	(value <= low ? low : (value >= high ? high : value))