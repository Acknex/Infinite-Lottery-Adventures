define triggered, skill9;
define jumpActive, skill2;
define jumpCounter, skill3;
define invincible, skill4;
define released, skill5;
define alive, skill1;

ENTITY* itemEnt;

SOUND sDie = "die.wav";
SOUND sJump = "jump.wav";
SOUND sCoin = "coin.wav";
SOUND sSquish = "squish.wav";
SOUND sInf = "inf.wav";
SOUND sWin = "yippie.wav";

var jForce = 60;
var mSpeed = 25;
var grav[3];
var gdist = 0;

var finished = 0;

var ingame = 0;

var enemyMoveRadius = 30;
var enemySpeed = 3;
var infcounter = 0;

action infosprite()
{
	my.passable = on;
	my.overlay = on;
	my.transparent = on;
	my.alpha = 100;
	my.scale_x = .5;
	my.scale_y = .5;
	
	while(me)
	{
		my.z += 3 * time_step;
		my.alpha -= 5 * time_step;
		my.scale_x += 0.1 * time_step;
		my.scale_y += 0.1 * time_step;
		
		if(my.alpha <= 0)
		{
			ent_remove(me);
			return;
		}
		
		wait(1);
	}
}

function jcldie()
{
	player.alive = 0;
	
	ent_create("release.bmp", player.x, infosprite);
	
	player.transparent = on;
	player.alpha = 100;
	
	
	ent_playsound(player, sDie, 1500);
	
	while(my.alpha > -1)
	{
		player.alpha -= 5 * time_step;
		player.scale_x -= 0.1 * time_step;
		player.scale_y -= 0.1 * time_step;
		
		if(player.alpha <= 0)
		{
			ent_remove(player);
			break;
		}
		
		wait(1);
	}
	

	ingame = 0;
	startPanel.visible = 1;
	newgame();
}

function coinevent()
{
	if(you == null) { return; }
	if(you == player)
	{ 
		ent_playsound(player, sCoin, 1500);
		points += 1;
		
		wait(1);
		
		if(me)
		{
			ent_remove(me);
		}
	}
}

function dougevent()
{
	if(you == null) { return; }
	if(you == player)
	{ 
		if(!my.triggered)
		{
			player.alive = 0;
			ingame = 0;
			finished = 1;
			
			ent_playsound(player, sWin, 1500);
			vGUI_PushCaption("Yippie!!!", 500);
			points += 42;
			
			wait(1);
			
			my.skill20 = 0;
			my.skill22 = my.z;

			vGUI_PushCaption("You saved me!", 500);
			wait(-1);
			vGUI_PushCaption("I love you JCL!", 1500);
			vGUI_PushCaption("[[ CLICK THE JCL TO START A NEW GAME! ]]", 5000);
			
			while(me)
			{
				my.skill20 += 25 * time_step;
				my.z = my.skill22 + abs(sin(my.skill20)) * -20 + 20;
				my.roll = abs(sin(my.skill20)) * (abs(cos(my.skill20)) * 20);
				
				wait(1);
			}
		}
	}
}

action infshine()
{
	proc_late();
	
	my.bright = on;
	my.passable = on;
	
	infcounter = 0;
	
	itemEnt = ent_createlayer("inf.mdl", 0, 2);
	itemEnt.x = 350;
	itemEnt.y = 170;
	itemEnt.z = 98;
	
	
	vGUI_PushCaption("JCL: I feel infinitely invincibly almighty!", 500);
	
	while(infcounter <= 250 && player)
	{
		infcounter += 1 * time_step;
		
		itemEnt.pan += 10 * time_step;
		
		player.invincible = 1;
		
		vec_set(my.x, vector(player.x, player.y + 10, player.z) );
		
		wait(1);	
	}
	
	if(player)
	{
		player.invincible = 0;
	}
	
	ent_remove(itemEnt);
	ent_remove(me);
}

function bugevent()
{
	if(player)
	{
		if(you == player && (you.z > my.z || player.invincible) )
		{
			ent_playsound(player, sSquish, 1500);
			ent_create("todo2.bmp", my.x, infosprite);
			points += 2;
			
			ent_remove(me);
		}
		else
		{
			if(you == player && !player.invincible)
			{
				jcldie();
			}
		}
	}
}

function featureevent()
{
	proc_late();
	
	if(player)
	{
		if(you == player && (you.z > my.z || player.invincible) )
		{
			ent_playsound(player, sSquish, 1500);
			ent_create("feature.bmp", my.x, infosprite);
			points += 3;
			
			my.passable = 1;
			my.transparent = 1;
			my.alpha = 50;
			
			while(you && me)
			{
				my.skill10 += 10 * time_step;
				my.x = player.x + 40 * sinv(my.skill10);
				my.y = player.y + 40 * sinv(my.skill10);
				my.y = player.z + 40 * sinv(my.skill10);
				
				my.scale_x -= .001;
				my.scale_y -= .001;
				my.scale_z -= .001;
				
				if(my.scale_x <= 0)
				{
					continue;
				}
				
				wait(1);
			}
			
			ent_remove(me);
		}
		else
		{
			if(you == player && !player.invincible)
			{
				jcldie();
			}
		}
	}
}

function infevent()
{
	if(you == player)
	{ 
		ent_create("inf.bmp", my.x, infosprite);
		ent_create("glow.tga", player.x, infshine);
		ent_playsound(player, sInf, 1500);
		points += 10;
		ent_remove(me);
	}
}


action doug()
{	
	my.enable_impact = 1;
	my.event = dougevent;
}

action coins()
{
	my.pan = 90;
	my.scale_x = 1.3;
	my.scale_y = 1.3;
	my.scale_z = 1.3;
	
	my.enable_impact = 1;
	my.event = coinevent;
	
	my.skill10 = (random(10) + random(-10));
	
// Sieht scheisse aus
//	while(me)
//	{
//		my.roll += my.skill10 * time_step;
//		wait(1);
//	}
}

action inf()
{
	my.unlit = on;
	
	c_setminmax(me);
	
	my.enable_impact = 1;
	my.event = infevent;
	
	while(me)
	{
		my.pan += 10 * time_step;
		wait(1);
	}	
}

function cubeevent()
{
	if(you == player && your.z <= (my.z - my.min_z) && !my.triggered)
	{
		my.triggered = 1;
		my.transparent = on;
		my.alpha = 50;
		
		my.pan = 0;
		
		while(1)
		{
			if(my.skill1 == 1)
			{
				ent_create("inf.mdl", vector(my.x, my.y, my.z + my.max_z), inf);
				break;
			}
			
			
			ent_create("a7.mdl", vector(my.x, my.y, my.z + my.max_z), coins);
			break;
		}
	}
}

action feature()
{
	my.enable_impact = 1;
	my.event = featureevent;
	
	my.skill2 = 1;
	
	while(me && !my.triggered)
	{
		my.skill1 += 1 * time_step;
		
		if(my.skill1 < enemyMoveRadius)
		{
			if(my.skill2)
			{
				c_move(me, vector(enemySpeed * time_step, 0, 0), nullvector, GLIDE);
			}
			else
			{
				c_move(me, vector(-enemySpeed * time_step, 0, 0), nullvector, GLIDE);
			}
		}
		else
		{
			my.skill1 = 0;
			my.skill2 = !(my.skill2);
		}
		
		wait(1);
	}
}

action bugs()
{
	my.enable_impact = 1;
	my.event = bugevent;
	
	my.skill2 = 1;
	
	while(me)
	{
		my.skill1 += 1 * time_step;
		
		if(my.skill1 < enemyMoveRadius)
		{
			if(my.skill2)
			{
				c_move(me, vector(enemySpeed * time_step, 0, 0), nullvector, GLIDE);
			}
			else
			{
				c_move(me, vector(-enemySpeed * time_step, 0, 0), nullvector, GLIDE);
			}
		}
		else
		{
			my.skill1 = 0;
			my.skill2 = !(my.skill2);
		}
		
		wait(1);
	}
}

action cube()
{
	my.unlit = on;
	my.albedo = 0;
	my.ambient = 50;
	
	c_setminmax(me);
	
	my.enable_impact = 1;
	my.event = cubeevent;
	
	while(me)
	{
		my.pan += 10 * time_step;
		wait(1);
	}	
}

function jclevent()
{
	if(event_type == EVENT_CLICK && !ingame)
	{
		if(!finished)
		{
			ingame = 1;
			player.roll = 0;
			startPanel.visible = 0;
		}
		else
		{
			ingame = 0;
			startPanel.visible = 1;
			newgame();
		}
	}
	
	if(event_type == EVENT_TOUCH && !ingame)
	{
		player.released = 0;
		while(!player.released)
		{
			player.roll += 20 * time_step;
			wait(1);
		}
	}
	
	if(event_type == EVENT_RELEASE)	
	{
		player.released = 1;
		player.roll = 0;
	}
}

action jcl()
{
	vec_set( grav.x, vector(0, 0, -1) );
	
	wait(1);	
	player = me;
	
	docamera();
	
	my.enable_click = 1;
	my.enable_touch = 1;
	my.enable_release = 1;
	my.event = jclevent;
	
	while(!ingame)
	{
		wait(1);
	}
	
	me.alive = 1;
	
	while(me.alive)
	{	
		if(player.jumpActive == 0 && key_space && gdist < 20 && gdist > 0)
		{
			player.jumpCounter = 0;
			player.jumpActive = 1;
			ent_playsound(player, sJump, 500);
		}
		
		if(player.jumpActive == 1)
		{
			player.jumpCounter += 1 * time_step;
			if(player.jumpCounter > 3)
			{
				player.jumpActive = 0;
			} 
		}
		
		gdist = c_trace(player.x, vector(player.x, player.y, player.z - 10000), IGNORE_ME|IGNORE_PASSABLE|IGNORE_PASSENTS|SCAN_TEXTURE);
		
		if(tex_flag1 == on && gdist < 16)
		{
			jcldie();
		}
		
		
		vec_set( grav.x, vector(0, 0, -20 * time_step) );
		
		c_move(player, vector( 0, ((key_cul * mSpeed) * time_step) - ((key_cur * mSpeed) * time_step),
		(jForce * player.jumpActive) * time_step ), grav.x, GLIDE|IGNORE_PASSENTS|IGNORE_PASSABLE );
		player.y = 0;
	
		wait(1);
	}
}

function docamera()
{
	proc_late();
	
	while(1)
	{
		vec_set(camera.x, vector(player.x, player.y-350, player.z));
		camera.pan = 90;
		
		wait(1);
	}
}