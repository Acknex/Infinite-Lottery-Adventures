bmap curItem = "item.tga";
bmap sImg = "start.tga";

string ps = "Points: ";

panel itemPanel =
{
	bmap = curItem;
	
	pos_x = 20;
	pos_y = 20;
	
	digits(200, 10, "Points: %.0f", "Arial#32b", 1, points);
	
	flags = SHOW + OVERLAY;
}

panel startPanel =
{
	bmap = sImg;
	
	flags = SHOW + OVERLAY;
}
