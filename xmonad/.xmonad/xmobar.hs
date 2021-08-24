Config {
    -- appearance
        font =         "xft:RobotoMono Nerd Font:size=10:bold:antialias=true:hinting=true"
        , bgColor =      "#21243b"
        , fgColor =      "#c1c1c1"
        , position =     Top
        , border =       BottomB

        -- layout
        , sepChar =  "%"   -- delineator between plugin names and straight text
        , alignSep = "}{"  -- separator between left-right alignment
        , template = "%UnsafeStdinReader% }{ <action=`alacritty -e htop`>%cpu%</action> <fc=#666666>|</fc> %multicoretemp% <fc=#666666>|</fc> %memory% <fc=#666666>|</fc> %battery% <fc=#666666>|</fc> %dynnetwork% <fc=#666666>|</fc> %YPAD% <fc=#666666>|</fc> %date% <fc=#666666>|</fc>%trayerpad%"

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
        ["-t", "<skyConditionS>  <tempC>° <rh>%"
        , "-L","10", "-H", "25", "--normal", "black"
        , "--high", "lightgoldenrod4", "--low", "darkseagreen4"]
        18000

        -- network activity monitor (dynamic interface resolution)
        , Run DynNetwork [ "-t" ,"\xf0ab <rx>kb \xf0aa <tx>kb" ] 10

            -- cpu activity monitor
        , Run Cpu       [ "-t" , "cpu: <total>%"
            , "--Low"      , "50"         -- units: %
            , "--High"     , "85"         -- units: %
            , "--low"      , "green"
            , "--normal"   , "orange"
            , "--high"     , "red"
        ] 10

            -- cpu core temperature monitor
        , Run MultiCoreTemp       [ "-t" , "temp: <avg>°C"
            , "--Low"      , "70"        -- units: °C
            , "--High"     , "80"        -- units: °C
            , "--low"      , "green"
            , "--normal"   , "orange"
            , "--high"     , "red"
        ] 20

            -- memory usage monitor
        , Run Memory         [ "-t" ,"mem: <usedratio>%"
            , "--Low"      , "50"        -- units: %
            , "--High"     , "90"        -- units: %
            , "--low"      , "green"
            , "--normal"   , "orange"
            , "--high"     , "red"
        ] 20

        , Run Battery ["-t", "<acstatus> <left>% <timeleft>"
        , "--Low"      , "15"
        , "--High"     , "70"
        , "--low"      , "red"
        , "--normal"   , "orange"
        , "--high"     , "green"
        , "--"
        , "-O", "\xf583"
        , "-o", "\xf578"
        , "-A", "5"
        , "-a", "notify-send 'Battery low, shutting down in 1 minute.' && shutdown"
        ] 10

            -- time and date indicator 
            --   (%F = y-m-d date, %a = day of week, %T = h:m:s time)
        , Run Date           "\xf017 %a %F (%T)" "date" 10
        , Run Com "trayer-padding-icon" [] "trayerpad" 20
        , Run UnsafeStdinReader
        ]
}
