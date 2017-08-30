/// @description Create a new set of blocks
yBase = 190;
xBase = 5;
for (var n = 0; n < 12; n++)
{
	for (var m = 0; m < 7; m++)
	{
		if (irandom(5) > 1)
		{
			var brick = instance_create_layer(xBase + (m * 50), yBase + (n * 25), "Instances",oBrick);
			brick.Health = irandom_range(10,250);
			brick.image_blend = make_color_rgb(255 - brick.Health, brick.Health, 40);
		}
	}
}

CollisionInit(true);