/// @description Create a new set of blocks
/// @param Type 0 = normal, 1 = markov
yBase = 180;
xBase = 5;
switch (argument0)
{
	case 0:
		for (var n = 0; n < 12; n++)
		{
			for (var m = 0; m < 7; m++)
			{
				if (irandom(2) > 1)
				{
					var brick = instance_create_layer(xBase + (m * 50), yBase + (n * 25), "Instances",oBrick);
					brick.Health = irandom_range(1,13) * 20 - 5;
					brick.image_blend = make_color_rgb(255 - brick.Health, brick.Health, 40);
				}
			}
		}
		break;
	case 1:
		//matrix init
		#region
		A[0,0] = 0;
		for (var n = 0; n < 12; n++)
		{
			for (var m = 0; m < 7; m++)
			{
				if (irandom_range(1,13) == 13)
				{
					A[n,m] = 13;
				}
				else
				{
					A[n,m] = 0;
				}
			}
		}
		#endregion
		//Forward
		#region
		for (var n = 0; n < 12; n++)
		{
			for (var m = 0; m < 7; m++)
			{
				chance = random(1);
				temp = 0;
				if (A[n,m] == 0)
				{
					if(m != 0)
					{
						for (var i = 0; i<14; i++)
						{
							temp += global.Markov[A[n,m-1],i];
							if (chance < temp)
							{
								A[n,m] = i;
								temp = -666;
							}
						}
					}
					else if (n != 0)
					{	
						for (var i = 0; i<14; i++)
						{
							temp += global.Markov[A[n-1,m],i];
							if (chance < temp)
							{
								A[n,m] = i;
								temp = -666;
							}
						}
					}
					temp = 0;
					if (A[n,m] == 0)
					{
						if (n!=0)
						{
							for (var i = 0; i<14; i++)
							{
								temp += global.Markov[A[n-1,m],i];
								if (chance < temp)
								{
									A[n,m] = i;
									temp = -666;
								}
							}
						}
					}
				}
			}
		}
		#endregion
		//Backward
		#region
		for (var n = 11; n>=0; n--)
		{
			for (var m = 6; m >= 0; m--)
			{
				chance = random(1);
				temp = 0;
				if (A[n,m] == 0)
				{
					if(m != 6)
					{
						for (var i = 0; i<14; i++)
						{
							temp += global.Markov[A[n,m+1],i];
							if (chance < temp)
							{
								A[n,m] = i;
								temp = -666;
							}
						}
					}
					else if (n != 11)
					{	
						for (var i = 0; i<14; i++)
						{
							temp += global.Markov[A[n+1,m],i];
							if (chance < temp)
							{
								A[n,m] = i;
								temp = -666;
							}
						}
					}
					temp = 0;
					if (A[n,m] == 0)
					{
						if (n!=11)
						{
							for (var i = 0; i<14; i++)
							{
								temp += global.Markov[A[n+1,m],i];
								if (chance < temp)
								{
									A[n,m] = i;
									temp = -666;
								}
							}
						}
					}
				}
			}
		}
		#endregion
		
		for (var n = 0; n < 12; n++)
		{
			for (var m = 0; m < 7; m++)
			{
				if (A[n,m] != 0)
				{
					var brick = instance_create_layer(xBase + (m * 50), yBase + (n * 25), "Instances",oBrick);
					brick.Health = A[n,m] * 20 - 5;
					brick.image_blend = make_color_rgb(255 - brick.Health, brick.Health, 40);
				}
			}
		}
		
		break;
}

CollisionInit(true);