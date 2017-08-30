/// @description Update for Collision and position
ball = argument0;
//radius of ball 
rad = 12;
rid = rad - 3;
//Paddle direction modifier
dirMod = 2;
//Collision Speed Increase
spd = 2;

//boundary checking - NOT bottom boundary
if ((ball.x > room_width - rad and ball.vel[0] > 0) or (ball.x < rad and ball.vel[0] < 0))
{
	ball.vel[0] *= (-1);
}
if (ball.y < 174 + rad and ball.vel[1] < 0)
{
	ball.vel[1] *= (-1);
}
if (ball.y > 630)
{
	instance_destroy(ball);
	global.Score -= 1000;
	exit;
}


//Position update
ball.x += ball.vel[0] * 1/game_get_speed(gamespeed_fps);
ball.y += ball.vel[1] * 1/game_get_speed(gamespeed_fps);

broken = false;
//***Collision with bricks***
#region
for (var i = 0; i < array_length_1d(global.blockList); i ++)
{
	var brick = global.blockList[i];
	if (brick != noone)
	{
		if (ball.y > (brick.y + brick.sprite_height/2))
		{
			vertWithin = ball.y - rad < brick.y + brick.sprite_height
		}
		else
		{
			vertWithin = ball.y + rad > brick.y
		}
		var horiWithin = (ball.x - rad < brick.x + brick.sprite_width) and (ball.x + rad > brick.x);
		if (vertWithin and horiWithin)
		{
			broken = true;
			var colMag = sqrt(sqr(ball.x - (brick.x + brick.sprite_width/2)) + sqr(ball.y - (brick.y + brick.sprite_height/2)));
			var colNorm = [(ball.x - (brick.x + brick.sprite_width/2))/colMag, (ball.y-(brick.y + brick.sprite_height/2))/colMag];
			var velMag = sqrt(sqr(ball.vel[0]) + sqr(ball.vel[1]));
			var velNorm = [ball.vel[0]/velMag, ball.vel[1]/velMag];
			//increase velocity
			velMag += spd;
			//check sides
			if (colNorm[1] >= -0.4472 and colNorm[1] <= 0.4472)
			{
				xDir = -1;
				//interpenetration
				if (colNorm[0] >= 0)
				{
					ball.x = brick.x + brick.sprite_width + rad;	
				}
				else
				{
					ball.x = brick.x - rad;
				}
			}
			else
			{
				xDir = 1;
			}
			if(colNorm[0] >= -0.9044 and colNorm[0] <= 0.9044)
			{
				yDir = -1;
				//Interpenetration
				if (colNorm[1] >= 0)
				{
					ball.y = brick.y + brick.sprite_height + rad;	
				}
				else
				{
					ball.y = brick.y - (rad + 1);
				}
			}
			else
			{
				yDir = 1;
			}
			//wrap it all up
			ball.vel = [velMag * velNorm[0] * xDir, velMag * velNorm[1] * yDir];
			brick.Health -= 20;
			brick.image_blend = make_color_rgb(255 - brick.Health, brick.Health, 40);
			if (brick.Health <= 5)
			{
				instance_destroy(brick);
				global.blockList[i] = noone;
			}
			global.Score += 100;
		}
	}
}
#endregion
//***Shift all valid blocks to the left of the array***
#region
if (broken)
{
	dirty = true;
	while(broken and dirty)
	{
		broken = false;
		dirty = false;
		for (var n = 0; n < array_length_1d(global.blockList); n++)
		{
			if (global.blockList[n] == noone)
			{
				broken = true;
				for (var m = n; m < array_length_1d(global.blockList); m++)
				{
					if(global.blockList[m] != noone)
					{
						dirty = true;
					}
				}
			}
			if (broken and n != array_length_1d(global.blockList)-1)
			{
				global.blockList[n] = global.blockList[n+1]
			}
			else if (broken and n == array_length_1d(global.blockList)-1)
			{
				global.blockList[n] = noone;
			}
		}
	}
	if (global.blockList[0] == noone)
	{
		CreateBlocks(0);
	}
}
#endregion
//***Collision with paddle***
#region
var pad = instance_find(oPaddle,0);
if (ball.y > (pad.y + rad))
{
	isBelow = ball.y - rad < pad.y;
}
else
{
	isBelow = ball.y + rad > pad.y - pad.sprite_height;
}
var isWithin = (ball.x - rad < pad.x + pad.sprite_width/2) and (ball.x + rad > pad.x - pad.sprite_width/2);
if (isBelow and isWithin)
{	
	//find a bunch of vector stuff
	var colMag = sqrt(sqr(ball.x - pad.x) + sqr(ball.y - pad.y));
	var colNorm = [(ball.x - pad.x)/colMag, (ball.y - pad.y)/colMag];
	var velMag = sqrt(sqr(ball.vel[0]) + sqr(ball.vel[1]));
	var velNorm = [ball.vel[0]/velMag, ball.vel[1]/velMag];
	//increase velocity
	velMag += spd;
	//wrap it all up
	var tempVect = [velNorm[0] + dirMod * colNorm[0], velNorm[1] + dirMod * colNorm[1]];
	var tempMag = sqrt(sqr(tempVect[0]) + sqr(tempVect[1]));
	var tempNorm = [tempVect[0]/tempMag, tempVect[1]/tempMag];
	
	//Classic Mode?
	//ball.vel = [velMag * colNorm[0], velMag * colNorm[1]];
	global.velocity = velMag;
	//My Mode
	ball.vel = [velMag * tempNorm[0], velMag * tempNorm[1]];
}
#endregion