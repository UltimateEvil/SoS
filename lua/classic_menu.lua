----------- MAIN MENU ----------
-- see: classic_mods.lua
OW_mods_initex();

-- version check
if (not compareVersions(getvalue(OWV_VERSION), MOD_DATA.Req_Ver)) then
    getCustomDialog({
        COUNT = 1,
        QUESTION = loc(TID_Main_Menu_Mod_Old_Ver) .. ' ' .. MOD_DATA.Req_Ver,
        LIST = {
            {
                NAME = loc(TID_Main_Menu_Quit),
                CALLBACK = 'exit();'
            }
        },
        INSTANT = 1
    });
end;

-- version
setFontName(version, ADMUI3LB);
-- mod version
setFontName(mod_version, Tahoma_10);

-- background
--setTexture(menu, 'menu-main.png');
logoVisible(false);

logo = getElementEX(
    menu,
    anchorT,
    XYWH(LayoutWidth / 2 - 290, 75, 580, 58),
    true,
    {
        texture = 'logos/logo.png'
    }
);

-- hide sgui menu
setVisible(menu.side, false);

-- old window
menu.window = getElementEX(
    menu,
    anchorNone,
    XYWH(LayoutWidth / 2 - 97, LayoutHeight / 2 - 155, 194, 310),
    true,
    {}
);

setTexture(menu.window, 'classic/edit/mainmenu.png');

menu.window2 = getElementEX(
    menu,
    anchorNone,
    XYWH(LayoutWidth / 2 - 97, LayoutHeight / 2 - 92, 194, 184),
    true,
    {}
);

setTexture(menu.window2, 'classic/edit/mainmenu2.png');
setVisible(menu.window2, false);

-- buttons
menu.window.user = button(
    menu.window, 
    12, 
    19, 
    170,
    30,
    loc(TID_Main_Menu_User) .. ': ' .. getvalue(OWV_STEAMUSERNAME), 
    'showProfile(1);',
    {}
);

menu.window.play = button(
    menu.window, 
    12, 
    61, 
    170,
    30,
    loc(TID_Main_Menu_Play), 
    'showMenuButton(2);',
    {}
);

menu.window.mods = button(
    menu.window, 
    12, 
    103,
    170,
    30, 
    loc(TID_MODS), 
    'showMods(1);',
    {}
);

menu.window.options = button(
    menu.window, 
    12, 
    145, 
    170,
    30, 
    loc(TID_Main_Menu_Options), 
    'showOptions(1);',
    {}
);

menu.window.achivs = button(
    menu.window, 
    12, 
    187, 
    170,
    30, 
    loc(TID_ACHIEVEMENTS), 
    'showAchivs(1);',
    {}
);

menu.window.credits = button(
    menu.window, 
    12, 
    229, 
    170,
    30, 
    loc(TID_Main_Menu_Extras_Credits), 
    'showCredits();',
    {}
);

menu.window.quit = button(
    menu.window, 
    12, 
    271,
    170,
    30,  
    loc(TID_Main_Menu_Quit), 
    'exit();',
    {}
);

menu.window2.campaign = button(
    menu.window2, 
    12, 
    19,
    170,
    30,  
    loc(TID_Main_Menu_Campaign), 
    'showCampaign(1)',
    {}
);

menu.window2.multiplayer = button(
    menu.window2, 
    12, 
    61, 
    170,
    30, 
    loc(TID_Main_Menu_Multiplayer), 
    '',
    {
        disabled = true
    }
);

menu.window2.skirmish = button(
    menu.window2, 
    12, 
    103,
    170,
    30,  
    loc(TID_Main_Menu_Skirmish), 
    'showSkirmishWindow(1);',
    {}
);

menu.window2.back = button(
    menu.window2, 
    12, 
    145,
    170,
    30,  
    loc(TID_Main_Menu_Campaign_Back), 
    'showMenuButton(1);',
    {}
);


-- steam
function steam_init()
	steam_username = getLabelEX(
        profilebar, 
        anchorLT, 
        XYWH(64 + 10, 0, profilebar.width - 64 - 5, 32), 
        nil, 
        getvalue(OWV_STEAMUSERNAME), 
        {
            nomouseevent = true
        }
    );

	setFontName(steam_username, ADMUI3LB);
    setFontName(profile_label, ADMUI3LB);

    setFontColour(steam_username, RGB(0,0,0));
    setFontColour(profile_label, RGB(0,0,0));

	setXYV(profile_label, 64 + 10, 15);

	SteamInitialized = true;
end;

-- hide old steam
setVisible(profilebar, false);

profilebar = getElementEX(
    menu,
    anchorTR,
    XYWH(LayoutWidth - 300, 0, 300, 70),
    true,
    {
        texture = 'classic/edit/steam.png'
    }
);

profile_avatar = getElementEX(
    profilebar,
    anchorL,
    XYWH(3, 3, 67, 65),
    true,
	{
        texture = 'profile_select.png', 
        --callback_mouseclick ='changeProfileAvatar()', 
        bevel = true
    }
);

profile_label = getLabelEX(
    profilebar,
    anchorLT,
    XYWH(64 + 5, 0, profilebar.width - 64 - 5, 32),
    nil,
    'default',
    {
        nomouseevent = true,
        font_colour = BLACK()
    }
);

profile_button = button(
    profilebar, 
    82, 
    42,
    198,
    32,  
    loc(TID_Main_Menu_Change_Player), 
    'showProfile(1);',
    {
        texture = 'classic/edit/menu_button_small_l.png',
        texture2 = 'classic/edit/menu_button_small_c.png',
        texture3 = 'classic/edit/menu_button_small_r.png'
    }
);

setVisible(profilebar, getSetting(OPTION_STEAMOVERLAY));

function showMenuButton(windowNumber)
    setVisible(menu.window, false);
    setVisible(menu.window2, false);
    setVisible(profilebar, false);

    if (windowNumber == 0) then
        setVisible(version, false);
        setVisible(mod_version, false);
    else
        setVisible(version, true);
        setVisible(mod_version, true);
    end;

    if (windowNumber > 0) then
        setVisible(profilebar, getSetting(OPTION_STEAMOVERLAY));
    end;

    if (windowNumber == 1) then
        setVisible(menu.window, true);
    end;

    if (windowNumber == 2) then
        setVisible(menu.window2, true);
    end;
end;