Config { 
    -- appearance
        font =         "xft:Roboto Mono Nerd Font:size=10:bold:antialias=true:hinting=true"
        , bgColor =      "#000000"
        , fgColor =      "#646464"
        , position =     Top
        , border =       BottomB
        , borderColor =  "#646464"

        -- layout
        , sepChar =  "%"   -- delineator between plugin names and straight text
        , alignSep = "}{"  -- separator between left-right alignment
        , template = "%battery% | %multicpu% | %coretemp% | %memory% | %dynnetwork% }{ %RJTT% | %date%"

        -- general behavior
        , lowerOnStart =     True    -- send to bottom of window stack on start
        , hideOnStart =      False   -- start with window unmapped (hidden)
        , allDesktops =      True    -- show on all desktops
        , overrideRedirect = True    -- set the Override Redirect flag (Xlib)
        , pickBroadest =     False   -- choose widest display (multi-monitor)
        , persistent =       True    -- enable/disable hiding (True = disabled)

        -- plugins
        --   Numbers can be automatically colored according to their value. xmobar
        --   decides color based on a three-tier/two-cutoff system, controlled by
        --   command options:
        --     --Low sets the low cutoff
        --     --High sets the high cutoff
        --
        --     --low sets the color below --Low cutoff
        --     --normal sets the color between --Low and --High cutoffs
        --     --High sets the color above --High cutoff
        --
        --   The --template option controls how the plugin is displayed. Text
        --   color can be set by enclosing in <fc></fc> tags. For more details
        --   see http://projects.haskell.org/xmobar/#system-monitor-plugins.
        , commands = 

        -- weather monitor
        , Run WeatherX "YPAD"
             [ ("clear", "🌣")
             , ("sunny", "🌣")
             , ("mostly clear", "🌤")
             , ("mostly sunny", "🌤")
             , ("partly sunny", "⛅")
             , ("fair", "🌑")
             , ("cloudy","☁")
             , ("overcast","☁")
             , ("partly cloudy", "⛅")
             , ("mostly cloudy", "🌧")
             , ("considerable cloudiness", "⛈")]
             ["-t", "<fn=2><skyConditionS></fn> <tempC>° <rh>%  <windKmh> (<hour>)"
             , "-L","10", "-H", "25", "--normal", "black"
             , "--high", "lightgoldenrod4", "--low", "darkseagreen4"]
             18000

            -- network activity monitor (dynamic interface resolution)
            , Run DynNetwork     [ "--template" , "<dev>: <tx>kB/s|<rx>kB/s"
            , "--Low"      , "1000"       -- units: B/s
            , "--High"     , "5000"       -- units: B/s
            , "--low"      , "darkgreen"
            , "--normal"   , "darkorange"
            , "--high"     , "darkred"
            ] 10

            -- cpu activity monitor
            , Run MultiCpu       [ "--template" , "Cpu: <total0>%|<total1>%"
            , "--Low"      , "50"         -- units: %
            , "--High"     , "85"         -- units: %
            , "--low"      , "darkgreen"
            , "--normal"   , "darkorange"
            , "--high"     , "darkred"
            ] 10

            -- cpu core temperature monitor
            , Run CoreTemp       [ "--template" , "Temp: <core0>°C|<core1>°C"
            , "--Low"      , "70"        -- units: °C
            , "--High"     , "80"        -- units: °C
            , "--low"      , "darkgreen"
            , "--normal"   , "darkorange"
            , "--high"     , "darkred"
            ] 50

            -- memory usage monitor
            , Run Memory         [ "--template" ,"Mem: <usedratio>%"
            , "--Low"      , "20"        -- units: %
            , "--High"     , "90"        -- units: %
            , "--low"      , "darkgreen"
            , "--normal"   , "darkorange"
            , "--high"     , "darkred"
            ] 10

            -- battery monitor
            , Run Battery        [ "--template" , "Batt: <acstatus>"
            , "--Low"      , "10"        -- units: %
            , "--High"     , "80"        -- units: %
            , "--low"      , "darkred"
            , "--normal"   , "darkorange"
            , "--high"     , "darkgreen"

            , "--" -- battery specific options
            -- discharging status
            , "-o"	, "<left>% (<timeleft>)"
            -- AC "on" status
            , "-O"	, "<fc=#dAA520>Charging</fc>"
            -- charged status
            , "-i"	, "<fc=#006000>Charged</fc>"
            ] 50

            -- time and date indicator 
            --   (%F = y-m-d date, %a = day of week, %T = h:m:s time)
            , Run Date           "<fc=#ABABAB>%F (%a) %T</fc>" "date" 10
            ]
}
