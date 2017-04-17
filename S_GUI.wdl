// PORTICO
// GUI INTERFACE
// Copyright Tuscture Science 2009

define true, 1;
define false, 0;
var points = 0;

function vGUI_PushCaption(sText, iTime);

bmap bmapGUICapBg = "gui_captionback.tga";

panel GUI_CaptionBg =
{
    bmap = bmapGUICapBg;
}

var GUICaption0[2];
var GUICaption1[2];
var GUICaption2[2];
var GUICaption3[2];

var GUICapColor[3];
var GUIMultiplier = 10;
var GUIIndent = 200;

function ivGUI_CalcGradient(tLeft)
{
    var _Out;
    if(tLeft < 255)
    {
        vec_lerp(_Out[0], vector(255, 255, 255), vector(128, 128, 255), clamp((tLeft / 255), 0.0, 1.0));
    }
    else
    {
        _Out[0] = 128;
        _Out[1] = 128;
        _Out[2] = 255;
    }
    
    draw_textmode(NULL, 0, 0, clamp(tLeft * 2.55, 0, 100));
    vec_set(GUICapColor[0], _Out[0]);
}

function vGUI_RenderCaptions()
{
    GUI_CaptionBg.pos_x = (screen_size.x - bmap_width(bmapGUICapBg)) / 2;
    GUI_CaptionBg.pos_y = (screen_size.y - 157);
    
    GUICaption0[0] = str_create("#200");
    GUICaption0[1] = 0;
    
    GUICaption1[0] = str_create("#200");
    GUICaption1[1] = 0;
    
    GUICaption2[0] = str_create("#200");
    GUICaption2[1] = 0;
    
    GUICaption3[0] = str_create("#200");
    GUICaption3[1] = 0;
    
    draw_textmode("Tahoma", 0, 24, 100);
    
    while(1)
    {
        if(GUICaption0[1] > 0)
        {
            GUI_CaptionBg.visible = true;
            ivGUI_CalcGradient(GUICaption0[1]);
            draw_text(GUICaption0[0], GUIIndent, (screen_size.y-63), GUICapColor[0]);
            GUICaption0[1] -= (1 * GUIMultiplier) * time_step;
        }
        
        if(GUICaption1[1] > 0)
        {
            GUI_CaptionBg.visible = true;
            ivGUI_CalcGradient(GUICaption1[1]);
            draw_text(GUICaption1[0], GUIIndent, (screen_size.y-89), GUICapColor[0]);
            GUICaption1[1] -= (1 * GUIMultiplier) * time_step;
        }
        
        if(GUICaption2[1] > 0)
        {
            GUI_CaptionBg.visible = true;
            ivGUI_CalcGradient(GUICaption2[1]);
            draw_text(GUICaption2[0], GUIIndent, (screen_size.y-115), GUICapColor[0]);
            GUICaption2[1] -= (1 * GUIMultiplier) * time_step;
        }
        
        if(GUICaption3[1] > 0)
        {
            GUI_CaptionBg.visible = true;
            ivGUI_CalcGradient(GUICaption3[1]);
            draw_text(GUICaption3[0], GUIIndent, (screen_size.y-141), GUICapColor[0]);
            GUICaption3[1] -= (1 * GUIMultiplier) * time_step;
        }
        
//        if(GUICaption3[1] <= 0 && str_len(GUICaption3[0]) < 200)
//        { vGUI_PushCaption("#200", 0); }
        
        if(GUICaption0[1] <= 0 && GUICaption1[1] <= 0 && GUICaption2[1] <= 0 && GUICaption3[1] <= 0)
        { GUI_CaptionBg.visible = false; }
        
        GUI_CaptionBg.pos_x = (screen_size.x - bmap_width(bmapGUICapBg)) / 2;
        GUI_CaptionBg.pos_y = (screen_size.y - 157);
        GUIIndent = GUI_CaptionBg.pos_x + 20;
        wait(1);
    }
}

function vGUI_PushCaption(sText, iTime)
{
    vec_set(GUICaption3[0], GUICaption2[0]);
    vec_set(GUICaption2[0], GUICaption1[0]);
    vec_set(GUICaption1[0], GUICaption0[0]);
    GUICaption0[0] = str_create(sText);
    GUICaption0[1] = iTime;
}

function vGUI_Init()
{
    vGUI_RenderCaptions();
}