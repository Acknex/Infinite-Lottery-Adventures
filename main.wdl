include "S_GUI.wdl";
include "ui.wdl";
include "player.wdl";
include "effects.wdl";
include "dll.wdl";

plugindir ".";

bmap mm = "cursor.bmp";

function main()
{
	video_window(null, null, 0, "Infinite Lottery Adventures :: Stressrelief Tool :: Bielefeld 2010");
	
	video_set(800, 600, 32, 0);
	
	fps_max = 60;
	
	//mouse_map = mm;
	mouse_mode = 4;
	
	level_load("level.wmb");
	master_vol = 1000;
	midi_vol = 1000;
	sound_vol = 1000;
	init_mod();
	
	skychange();
	vGUI_Init();
	
	pan_setpos(itemPanel, 1, 1, vector(screen_size.x - 200, 10, 0));
	
	startPanel.pos_x = 50;
	startPanel.pos_y = 200;
	
	//pan_setpos(GUI_MenuBack, 3, 1, vector(-GUI_MenuBack.pos_x + (tGUIMenuContinue.pos_x - 3), (tGUIMenuContinue.pos_y - 3), 0));
//	draw_textmode("Arial", 0, 17, 0);
//	
//	while(1)
//	{
//		draw_text(tex_name, 0, 5, vector(0,0,0));
//		wait(1);
//	}

	while(!ingame)
	{
		//vec_set(mouse_pos,mouse_cursor);
		wait(1);
	} 
	
	play_mod();
	
	points = 0;

	vGUI_PushCaption("Help JCL!", 500);
	wait(-1);
	vGUI_PushCaption("The Torque Pirates have kidnapped Doug!", 500);
	wait(-1);
	vGUI_PushCaption("Save him!", 500);
}

function newgame()
{
	finished = 0;
	level_load("level.wmb");
	
	points = 0;
	
	while(!ingame)
	{
		//vec_set(mouse_pos,mouse_cursor);
		wait(1);
	} 

	vGUI_PushCaption("Help JCL!", 500);
	wait(-1);
	vGUI_PushCaption("The Torque Pirates have kidnapped Doug!", 500);
	wait(-1);
	vGUI_PushCaption("Save him!", 500);
	
}

panel stats
{
	pos_x = 20;
	pos_y = 100;
	digits 0,0,3.3,*,1,gdist;
	digits 0,10,3.3,*,1,player.jumpActive;
	digits 0,20,3.3,*,1,player.jumpCounter;
	
	digits 0,40,3.3,*,1,points;
	
	digits 0,60,3.3,*,1,infcounter;
	
	//flags = SHOW;
	layer = 999;
}

function as()
{
	stop_mod();
	wait(1);
	close_mod();
}

//on_exit = as;