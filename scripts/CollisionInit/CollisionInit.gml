/// @description Collision Engine Initialization
/// @param {boolean} clear Clear all fields?

//Clear Instance Lists
if (argument0)
{
	global.blockList = [];
}

for (i = 0; i < instance_number(oBrick); i += 1)
{
	global.blockList[i] = instance_find(oBrick,i);
}