// void drawCharacterWithGear(real sprite, real subimg, real overlays, real x, real y, real xscale, real yscale, real rot, real color, real alpha)

var _sprite,
    _subimg,
    overlays,
    _x,
    _y,
    _xscale,
    _yscale,
    _rot,
    _color,
    _alpha;
_sprite = argument0;
_subimg = argument1;
overlays = argument2;
_x = argument3;
_y = argument4;
_xscale = argument5;
_yscale = argument6;
_rot = argument7;
_color = argument8;
_alpha = argument9;

_subimg = floor(_subimg) mod sprite_get_number(_sprite);
if(_subimg < 0)
    _subimg += sprite_get_number(_sprite);

draw_sprite_ext(_sprite, _subimg, _x, _y, _xscale, _yscale, _rot, _color, _alpha);

var i, gearId, gearInfo, gearSpriteInfo, gearSpriteSubimageInfo;

for(i=0; i<ds_list_size(overlays); i+=1)
{
    gearId = ds_list_find_value(overlays, i);
    
    if(!ds_map_exists(global.gearOverlayInfo, gearId))
        continue;
    gearInfo = ds_map_find_value(global.gearOverlayInfo, gearId);
    
    if(!ds_map_exists(gearInfo, _sprite))
        continue;
    gearSpriteInfo = ds_map_find_value(gearInfo, _sprite);
    
    if(!ds_map_exists(gearSpriteInfo, _subimg))
        continue;
    gearSpriteSubimageInfo = ds_map_find_value(gearSpriteInfo, _subimg);
    
    /*
    if(_subimg >= ds_list_size(gearSpriteInfo))
        continue;
    gearSpriteSubimageInfo = ds_list_find_value(gearSpriteInfo, _subimg);
    if(gearSpriteSubimageInfo < 0)
        continue;
    */
    
    var overlaySprite, overlaySubimage, dx, dy, overlayAngle, overlayxscale;
    
    overlaySprite = ds_list_find_value(gearSpriteSubimageInfo, 0);
    overlaySubimage = ds_list_find_value(gearSpriteSubimageInfo, 1);
    dx = ds_list_find_value(gearSpriteSubimageInfo, 2) * _xscale;
    dy = ds_list_find_value(gearSpriteSubimageInfo, 3) * _yscale;
    overlayAngle = ds_list_find_value(gearSpriteSubimageInfo, 4);
    overlayxscale = ds_list_find_value(gearSpriteSubimageInfo, 5);
    
    draw_sprite_ext(overlaySprite, overlaySubimage, _x + cos(_rot)*dx + sin(_rot)*dy, _y + sin(_rot)*dx + cos(_rot)*dy, _xscale*overlayxscale, _yscale, _rot + overlayAngle, _color, _alpha);
}


