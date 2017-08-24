/// @description Update for Collision and position
ball = argument0;
//radius of ball 
rad = 12;
//Paddle direction modifier
dirMod = 2;
//paddle Speed Increase
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

//Position update
ball.x += ball.vel[0] * 1/game_get_speed(gamespeed_fps);
ball.y += ball.vel[1] * 1/game_get_speed(gamespeed_fps);

//Collision with bricks
for (var i = 0; i < array_length_1d(global.blockList); i ++)
{
	var brick = global.blockList[i];
	
}

//Collision with paddle
var pad = instance_find(oPaddle,0);
var isBelow = ball.y + rad > pad.y - pad.sprite_height/2;
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