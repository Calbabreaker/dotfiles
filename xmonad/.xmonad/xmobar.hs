Config {
    -- appearance
    font = "xft:RobotoMono Nerd Font:size=10:bold:antialias=true:hinting=true"
    , bgColor = "#21243b"
    , fgColor = "#c1c1c1"
    , position = Top
    , border = BottomB
    , borderColor = "#555555"

    -- layout
    , sepChar =  "%"   -- delineator between plugin names and straight text
    , alignSep = "}{"  -- separator between left-right alignment

    -- contains battery status
    , template = "%UnsafeStdinReader% }{ <action=`alacritty -e htop`><box type=Bottom width=1 mb=2 color=#c1c1c1>%cpu%</box> <box type=Bottom width=1 mb=2 color=#c1c1c1>%multicoretemp%</box> <box type=Bottom width=1 mb=2 color=#c1c1c1>%memory%</box> <box type=Bottom width=1 mb=2 color=#c1c1c1>%battery%</box></action> <box type=Bottom width=1 mb=2 color=#c1c1c1>%YPAD%</box> <box type=Bottom width=1 mb=2 color=#c1c1c1>%date%</box> <fc=#666666>|</fc>%trayerpad%"
    -- replace battery with network
    -- , template = "%UnsafeStdinReader% }{ <action=`alacritty -e htop`><box type=Bottom width=1 mb=2 color=#c1c1c1>%cpu%</box> <box type=Bottom width=1 mb=2 color=#c1c1c1>%multicoretemp%</box> <box type=Bottom width=1 mb=2 color=#c1c1c1>%memory%</box> <box type=Bottom width=1 mb=2 color=#c1c1c1>%battery%</box></action> <box type=Bottom width=1 mb=2 color=#c1c1c1>%YPAD%</box> <box type=Bottom width=1 mb=2 color=#c1c1c1>%date%</box> <fc=#666666>|</fc>%trayerpad%"

    -- general behavior
    , lowerOnStart =     True    -- send to bottom of window stack on start
    , hideOnStart =      False   -- start with window unmapped (hidden)
    , allDesktops =      True    -- show on all desktops
    , overrideRedirect = True    -- set the Override Redirect flag (Xlib)
    , pickBroadest =     False   -- choose widest display (multi-monitor)
    , persistent =       True    -- enable/disable hiding (True = disabled)

    , commands = 
    -- weather monitor
    [ Run WeatherX "YPAD"
         [ ("clear", "\xe30d")
         , ("sunny", "\xe30d")
         , ("mostly clear", "\xfa94")
         , ("mostly sunny", "\xfa94")
         , ("partly sunny", "\xe302")
         , ("fair", "\xfa93")
         , ("partly cloudy", "\xe302")
         , ("cloudy","\xe312")
         , ("overcast","\xe312")
         , ("mostly cloudy", "\xfa95")
         , ("considerable cloudiness", "\xfb7c")]
    ["-t", "<skyConditionS> <tempC>° <rh>%"]
    18000

    -- network activity monitor (dynamic interface resolution)
    , Run DynNetwork [ "-t" ,"\xf0ab <rx>kb \xf0aa <tx>kb" ] 10

        -- cpu activity monitor
    , Run Cpu       [ "-t" , "\xf878 <total>%"
        , "--Low"      , "50"         -- units: %
        , "--High"     , "80"         -- units: %
        , "--low"      , "green"
        , "--normal"   , "orange"
        , "--high"     , "red"
    ] 20

        -- cpu core temperature monitor
    , Run MultiCoreTemp       [ "-t" , "\xf2c7 <avg>°C"
        , "--Low"      , "60"        -- units: °C
        , "--High"     , "80"        -- units: °C
        , "--low"      , "green"
        , "--normal"   , "orange"
        , "--high"     , "red"
    ] 20

        -- memory usage monitor
    , Run Memory         [ "-t" ,"\xf233 <usedratio>% <used>M"
        , "--Low"      , "50"        -- units: %
        , "--High"     , "100"        -- units: %
        , "--low"      , "green"
        , "--normal"   , "orange"
        , "--high"     , "#c1c1c1"
    ] 20

    , Run Battery ["-t", "<acstatus> <left>% <timeleft>"
        , "--Low"      , "15"
        , "--High"     , "70"
        , "--low"      , "red"
        , "--normal"   , "orange"
        , "--high"     , "green"
        , "--"
        , "-O", "<fc=#c1c1c1>\xf583</fc>"
        , "-o", "<fc=#c1c1c1>\xf578</fc>"
        , "-A", "5"
        , "-a", "dunstify -u critical 'Battery low, shutting down in 1 minute.' && shutdown"
    ] 20

        -- time and date indicator 
        --   (%F = y-m-d date, %a = day of week, %T = h:m:s time)
    , Run Date "\xf017 %H:%M %a %m %h" "date" 100
    , Run Com "trayer-padding-icon" [] "trayerpad" 20
    , Run UnsafeStdinReader
    ]
}
