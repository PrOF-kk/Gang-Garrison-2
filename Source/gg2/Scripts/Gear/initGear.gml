// Initialize the gear / overlay registry
// which is a (sparse) map from the tuple (gear, sprite, subimage)
// to the tuple (gearSprite, gearSubimage, dx, dy, angle)

initAllHeadPoses();

var classes, teams, i, j, k, l;
classes = split("Demoman,Engineer,Heavy,Medic,Pyro,Scout,Sniper,Soldier,Spy", ",");
teams = split("Red,Blue", ",");


for(i=0; i<ds_list_size(classes); i+=1)
{
    var class, xoff, yoff, animations;
    class = ds_list_find_value(classes, i);
    animations = split("Run,Stand,LeanL,LeanR,Jump,Taunt", ",");
    switch(class)
    {
    case "Engineer":
        xoff = -2;
        yoff = -2;
        break;
    case "Sniper":
        ds_list_add(animations, "Crouch");
        xoff = -2;
        yoff = -4;
        break;
    case "Heavy":
        ds_list_add(animations, "Omnomnomnom");
        ds_list_add(animations, "Walk");
        xoff = 0;
        yoff = 0;
        break;
    default:
        xoff = 0;
        yoff = 0;
        break;
    }
    
    for(j=0; j<ds_list_size(teams); j+=1)
    {
        var team, partyHatSprite;
        team = ds_list_find_value(teams, j);
        if(team == "Red")
            partyHatSprite = PartyHatRedS;
        else
            partyHatSprite = PartyHatBlueS;
        
        for(k=0; k<ds_list_size(animations); k+=1)
        {
            var animation, spriteId, headPoses;
            animation = ds_list_find_value(animations, k);
            spriteId = getCharacterSpriteId(class, team, animation);
            
//            global.headPoseInfo: sprite -> subimage -> (dx, dy, angle, xscale)
            
            headPoses = ds_map_find_value(global.headPoseInfo, spriteId);
            for(l=0; l<sprite_get_number(spriteId); l+=1)
            {
                if(ds_map_exists(headPoses, l))
                {
                    var headPose, dx, dy, angle, xscale;
                    headPose = ds_map_find_value(headPoses, l);
                    dx = ds_list_find_value(headPose, 0);
                    dy = ds_list_find_value(headPose, 1);
                    angle = ds_list_find_value(headPose, 2);
                    xscale = ds_list_find_value(headPose, 3);
                    setGearOverlayInfo(spriteId, l, "PartyHat", partyHatSprite, 0, dx + xoff, dy + yoff, angle, xscale);
                }   
            }
        }
    }
    
    ds_list_destroy(animations);
}

var spriteId, headPoses;
spriteId = MedicRedTauntS;
headPoses = ds_map_find_value(global.headPoseInfo, spriteId);
xoff = 0;
yoff = 0;
for(l=0; l<sprite_get_number(spriteId); l+=1)
{
    if(ds_map_exists(headPoses, l))
    {
        var headPose, dx, dy, angle, xscale;
        headPose = ds_map_find_value(headPoses, l);
        dx = ds_list_find_value(headPose, 0);
        dy = ds_list_find_value(headPose, 1);
        angle = ds_list_find_value(headPose, 2);
        xscale = ds_list_find_value(headPose, 3);
        setGearOverlayInfo(spriteId, l, "PartyHat", MedicXmasHatTauntS, l, dx + xoff*xscale, dy + yoff, angle, xscale);
    }
}

ds_list_destroy(classes);
ds_list_destroy(teams);
