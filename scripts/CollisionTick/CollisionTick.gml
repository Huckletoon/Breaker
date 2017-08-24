/// @description Update for Collision and position
ball = argument0;
rad = 12;

if ((ball.x > room_width - rad and ball.vel[0] > 0) or (ball.x < rad and ball.vel[0] < 0))
{
	ball.vel[0] *= (-1);
}
if (ball.y < 174 + rad and ball.vel[1] < 0)
{
	ball.vel[1] *= (-1);
}
ball.x += ball.vel[0] * 1/game_get_speed(gamespeed_fps);
ball.y += ball.vel[1] * 1/game_get_speed(gamespeed_fps);
