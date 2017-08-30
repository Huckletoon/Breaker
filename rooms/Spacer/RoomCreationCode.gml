#region
for (var n = 0; n<14; n++)
{
	for (var m = 0; m<14; m++)
	{
		global.Markov[n,m] = 0;
	}
}
global.Markov[0,0] = 1;
global.Markov[1,0] = 1;
global.Markov[2,1] = 1;
global.Markov[3,1] = 1;
global.Markov[4,1] = 1;
global.Markov[5,1] = 1;
global.Markov[6,1] = .4;
global.Markov[6,2] = .3;
global.Markov[6,3] = .2;
global.Markov[6,4] = .1;
global.Markov[7,2] = .4;
global.Markov[7,3] = .3;
global.Markov[7,4] = .2;
global.Markov[7,5] = .1;
global.Markov[8,3] = .4;
global.Markov[8,4] = .3;
global.Markov[8,5] = .2;
global.Markov[8,6] = .1;
global.Markov[9,4] = .4;
global.Markov[9,5] = .3;
global.Markov[9,6] = .2;
global.Markov[9,7] = .1;
global.Markov[10,5] = .4;
global.Markov[10,6] = .3;
global.Markov[10,7] = .2;
global.Markov[10,8] = .1;
global.Markov[11,6] = .4;
global.Markov[11,7] = .3;
global.Markov[11,8] = .2;
global.Markov[11,9] = .1;
global.Markov[12,7] = .4;
global.Markov[12,8] = .3;
global.Markov[12,9] = .2;
global.Markov[12,10] = .1;
global.Markov[13,8] = .4;
global.Markov[13,9] = .3;
global.Markov[13,10] = .2;
global.Markov[13,11] = .1;
#endregion
CreateBlocks(1);
global.Score = 1000;