
// Converts argument 'array' into a real array (args)
// EXAMPLE USAGE: LOOP_args = argument[i]; return args;
#macro LOOP_args for(var i=0,args;i<argument_count;i++)args

// For reading/writing ds_grids in base64 (Thanks, Juju)
enum DATATYPE {
	REAL,
	STRING
}

// NOTE: TODO: Possible NPCs / multiplayer?
#macro SDF_CHAR	"char_save_"
#macro SDF_WORLD "world_save_"