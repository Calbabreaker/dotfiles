-- imports
import System.Exit
import XMonad
import XMonad.Operations (float)

-- Actions
import XMonad.Actions.CopyWindow (kill1)
import XMonad.Actions.CycleWS
import XMonad.Actions.MouseResize
import XMonad.Actions.Promote
import XMonad.Actions.WithAll (sinkAll, killAll, withAll)

-- Hooks
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageHelpers (isFullscreen, doFullFloat, doCenterFloat)
import XMonad.Hooks.DynamicLog (dynamicLogWithPP, wrap, xmobarPP, xmobarColor, shorten, PP(..))
import XMonad.Hooks.ManageDocks (avoidStruts, docksEventHook, manageDocks, ToggleStruts(..))

-- Layout
import XMonad.Layout.Fullscreen (fullscreenFull, fullscreenSupport)
import XMonad.Layout.Grid (Grid(..))
import XMonad.Layout.NoBorders (noBorders, smartBorders)
import XMonad.Layout.Spiral
import XMonad.Layout.ToggleLayouts

-- Utils
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.Run
import XMonad.Util.SpawnOnce

-- Data
import Data.Maybe (fromJust)
import Data.Monoid

import qualified Data.Map        as M
import qualified XMonad.StackSet as W

-- Terminal used for keybind to open
myTerminal :: String
myTerminal = "alacritty"

-- Web browser used for keybind to open
myBrowser :: String
myBrowser = "chromium"

-- File manager used for keybind to open
myFileManager :: String
myFileManager = "pcmanfm"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = False

-- Width of the window border in pixels.
myBorderWidth = 1

-- Key used as the mod key for keybinds (mod4mask = Super)
myModMask :: KeyMask
myModMask = mod4Mask

-- Workspaces/Desktops tags
myWorkspaces = ["1","2","3","4","5","6","7","8","9"]

-- Border colors for unfocused and focused windows, respectively.
myNormalBorderColor  = "#555555"
myFocusedBorderColor = "#eeeeee"

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys :: [(String, X ())]
myKeys =
    [ ("M-S-r", spawn "xmonad --recompile && xmonad --restart") -- Restarts xmonad
    , ("M-S-q", io exitSuccess) -- Quits xmonad

    , ("M-<Return>", spawn myTerminal) -- Open new terminal
    , ("M-S-<Return>", spawn "dmenu_run -i -p 'Run: '") -- Show dmenu prompt
    , ("M-b", spawn myBrowser) -- Open web browser
    , ("M-e", spawn myFileManager) -- Open file manager
    , ("M-S-l", spawn "light-locker-command -l") -- Lock screen with myScreensaver

    , ("M-c", kill1) -- Kill focused window
    , ("M-S-c", killAll) -- Kill all windows in workspace

    , ("M-<Tab>", windows W.focusDown) -- Move focus to the next window
    , ("M-S-<Tab>", windows W.focusUp) -- Move focus to the previous window
    , ("M-j", windows W.focusDown) -- Move focus to the next window
    , ("M-k", windows W.focusUp) -- Move focus to the prev window
    , ("M-S-j", windows W.swapDown) -- Swap the focused window with the next window
    , ("M-S-k", windows W.swapUp) -- Swap the focused window with the previous window
    , ("M-m", windows W.focusMaster) -- Move focus to the master window
    , ("M-S-m", windows W.swapMaster) -- Swap the focused window and the master window
    , ("M-S-<Up>", sendMessage (IncMasterN 1)) -- Increment the number of windows in the master area
    , ("M-S-<Down>", sendMessage (IncMasterN (-1))) -- Deincrement the number of windows in the master area
    , ("M-<Backspace>", promote) -- Moves focused window to master, others maintain order

    , ("M-r", refresh) -- Resize windows to the correct size
    , ("M-h", sendMessage Shrink) -- Shrink the master area
    , ("M-l", sendMessage Expand) -- Expand the master area

    , ("M-.", nextWS) -- Switch to next workspace
    , ("M-,", prevWS) -- Switch to previous workspace
    , ("M-S-.", shiftToNext >> nextWS) -- Move window to next workspace
    , ("M-S-,", shiftToPrev >> prevWS) -- Move window to previous workspace
    , ("M-C-.", nextScreen) -- Switch to next screen/monitor
    , ("M-C-,",  prevScreen) -- Switch to next screen/monitor
    , ("M-C-S-.", shiftNextScreen) -- Switch to next screen/monitor
    , ("M-C-S-,",  shiftPrevScreen) -- Switch to next screen/monitor
    , ("M-z", toggleWS) -- Switch to window that was focused last

    , ("M-<Space>", sendMessage NextLayout) -- Switch to next available layout
    , ("M-S-<Space>", sendMessage (Toggle "Full") >> sendMessage ToggleStruts) -- Toggles noborder/full
    , ("M-t", withFocused $ windows . W.sink) -- Push floating window back to tilling
    , ("M-S-t", sinkAll) -- Push all floating windows to tilling
    , ("M-f", withFocused floatCenter)
    , ("M-S-f", withAll float)

    , ("M-S-C-r", spawn "reboot") -- reboots computer
    , ("M-S-C-q", spawn "shutdown now") -- shutdowns computer
    , ("M-S-C-s", spawn "systemctl suspend") -- reboots computer

    -- MultiMedia Keys
    -- Volume keys from volumeicon
    , ("<XF86AudioPlay>", spawn "playerctl play-pause")    
    , ("<XF86AudioPrev>", spawn "playerctl previous")    
    , ("<XF86AudioNext>", spawn "playerctl next")    
    , ("<XF86MonBrightnessUp>", spawn ("xbacklight -inc 5% && " ++ showBrightness))
    , ("<XF86MonBrightnessDown>", spawn ("xbacklight -dec 5% && " ++ showBrightness))
    ]

    where
        floatCenter w = windows (\s -> W.float w (W.RationalRect (1/3) (1/4) (1/2) (4/5)) s)
        showBrightness = "light=$(xbacklight -get | cut -d '.' -f 1) && dunstify -t 2000  -u low -r 13481 -h int:value:$light \"Brightness: $light\""

------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
myLayout = smartBorders $ avoidStruts $ toggleLayouts (noBorders Full) $
    Tall (1) (3/100) (1/2) ||| spiral (6/7) ||| Grid ||| Full

------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
--
myManageHook = composeAll
    [ className =? "confirm"         --> doFloat
    , className =? "file_progress"   --> doFloat
    , className =? "dialog"          --> doFloat
    , className =? "download"        --> doFloat
    , className =? "error"           --> doFloat
    , className =? "notification"    --> doFloat
    , isFullscreen -->  doFullFloat
    ]

-- Perform an arbitrary action each time xmonad starts or is restarted
myStartupHook = do
    spawnOnce "nitrogen --restore &" -- Wallpapers
    spawnOnce "picom -f --backend glx --vsync &" -- compisitor
    spawnOnce "nm-applet &" -- network manager system tray
    spawnOnce "volumeicon &" -- volume icon system tray
    spawnOnce "dunst &" -- notification server
    spawnOnce "trayer --edge top --align right --widthtype request --padding 6 --SetDockType true --SetPartialStrut true --expand true --transparent true --alpha 0 --tint 0x1d2034 --height 20 &" -- system tray
    spawnOnce "light-locker &" -- screen locker

-- Run xmonad and other stuff
main = do
    xmproc <- spawnPipe "xmobar -x 0 $HOME/.xmonad/xmobar.hs"
    xmonad $ fullscreenSupport def 
        { terminal           = myTerminal
        , focusFollowsMouse  = myFocusFollowsMouse
        , clickJustFocuses   = myClickJustFocuses
        , borderWidth        = myBorderWidth
        , modMask            = myModMask
        , workspaces         = myWorkspaces
        , normalBorderColor  = myNormalBorderColor
        , focusedBorderColor = myFocusedBorderColor

        , mouseBindings      = myMouseBindings

        -- hooks, layouts
        , layoutHook         = myLayout
        , manageHook         = myManageHook <+> manageDocks
        , handleEventHook    = docksEventHook
        , startupHook        = myStartupHook

        , logHook = dynamicLogWithPP $ xmobarPP
        -- xmobar settings
            { ppOutput = \x -> hPutStrLn xmproc x                          
            , ppCurrent = xmobarColor "#c792ea" "" . wrap "<box type=VBoth width=2 mb=2 mt=1 color=#c792ea>" "</box>"         -- Current workspace
            , ppVisible = xmobarColor "#c792ea" "" . clickable              -- Visible but not current workspace
            , ppHidden = xmobarColor "#82aaff" "" . wrap "<box type=Top width=2 mt=1 color=#82aaff>" "</box>" . clickable -- Hidden workspaces
            , ppHiddenNoWindows = xmobarColor "#82aaff" ""  . clickable     -- Hidden workspaces (no windows)
            , ppTitle = xmobarColor "#c1c1c1" "" . shorten 60               -- Title of active window
            , ppSep =  "<fc=#666666> <fn=1>|</fn> </fc>"                    -- Separator character
            , ppUrgent = xmobarColor "#c45500" "" . wrap "!" "!"            -- Urgent workspace
            , ppExtras  = [windowCount]                                     -- # of windows current workspace
            , ppOrder  = \(ws:l:t:ex) -> [ws,l]++ex++[t]                    -- order of things in xmobar
            }
    } `additionalKeysP` myKeys 
        where 
            windowCount = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset
            clickable ws = "<action=xdotool key super+"++show i++">"++ws++"</action>" where 
                i = fromJust $ M.lookup ws workspaceIndices
                workspaceIndices = M.fromList $ zipWith (,) myWorkspaces [1..]
