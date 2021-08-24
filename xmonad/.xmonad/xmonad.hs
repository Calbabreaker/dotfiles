-- imports
import XMonad
import XMonad.Operations (float)
import Data.Monoid
import Graphics.X11.ExtraTypes.XF86
import System.Exit

-- Actions
import XMonad.Actions.CopyWindow (kill1)
import XMonad.Actions.WithAll (sinkAll, killAll, withAll)
import XMonad.Actions.Promote
import XMonad.Actions.RotSlaves (rotSlavesDown, rotAllDown)
import XMonad.Actions.MouseResize

-- Hooks
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageHelpers (isFullscreen, doFullFloat, doCenterFloat)

-- Utils
import XMonad.Util.SpawnOnce
import XMonad.Util.Run
import XMonad.Util.EZConfig (additionalKeysP)

-- Layouts
import XMonad.Layout.MultiToggle.Instances (StdTransformers(NBFULL, MIRROR, NOBORDERS))
import qualified XMonad.Layout.MultiToggle as MT (Toggle(..))

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

-- Terminal used for keybind to open
myTerminal :: String
myTerminal = "alacritty"

-- Web browser used for keybind to open
myBrowser :: String
myBrowser = "chromium"

-- File manager used for keybind to open
myFileManager :: String
myFileManager = "pcmanfm"

-- Command to run for keybind and daemon
myScreensaver :: String
myScreensaver = "xscreensaver-command -lock"

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
myWorkspaces    = ["1","2","3","4","5","6","7","8","9"]

-- Border colors for unfocused and focused windows, respectively.
myNormalBorderColor  = "#555555"
myFocusedBorderColor = "#eeeeee"

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys :: [(String, X ())]
myKeys =
    [ ("M-S-r", spawn "xmonad --recompile; xmonad --restart") -- Restarts xmonad
    , ("M-S-q", io exitSuccess) -- Quits xmonad

    , ("M-<Return>", spawn myTerminal) -- Open new terminal
    , ("M-S-<Return>", spawn "dmenu_run -i -p 'Run: '") -- Show dmenu prompt
    , ("M-b", spawn myBrowser) -- Open browser
    , ("M-e", spawn myFileManager) -- Open file manager
    , ("M-S-l", spawn myScreensaver) -- Lock screen with myScreensaver

    , ("M-c", kill1) -- Kill focused window
    , ("M-S-c", killAll) -- Kill all windows in workspace

    , ("M-Tab", windows W.focusDown) -- Move focus to the next window
    , ("M-S-Tab", windows W.focusUp) -- Move focus to the previous window
    , ("M-j", windows W.focusDown) -- Move focus to the next window
    , ("M-k", windows W.focusUp) -- Move focus to the prev window
    , ("M-m", windows W.focusMaster) -- Move focus to the master window
    , ("M-S-j", windows W.swapDown) -- Swap the focused window with the next window
    , ("M-S-k", windows W.swapUp) -- Swap the focused window with the previous window
    , ("M-S-m", windows W.swapMaster) -- Swap the focused window and the master window
    , ("M-S-<Up>", sendMessage (IncMasterN 1)) -- Increment the number of windows in the master area
    , ("M-S-<Down>", sendMessage (IncMasterN (-1))) -- Deincrement the number of windows in the master area
    , ("M-<Backspace>", promote) -- Moves focused window to master, others maintain order
    , ("M-S-<Tab>", rotSlavesDown) -- Rotate all windows except master and keep focus in place
    , ("M-C-<Tab>", rotAllDown) -- Rotate all the windows in the current stac

    , ("M-r", refresh) -- Resize windows to the correct size
    , ("M-h", sendMessage Shrink) -- Shrink the master area
    , ("M-l", sendMessage Expand) -- Expand the master area

    , ("M-<Space>", sendMessage NextLayout) -- Switch to next available layout
    , ("M-S-<Space>", sendMessage (MT.Toggle NBFULL) >> sendMessage ToggleStruts) -- Toggles noborder/full
    , ("M-t", withFocused $ windows . W.sink) -- Push floating window back to tilling
    , ("M-S-t", sinkAll) -- Push all floating windows to tilling
    , ("M-f", withFocused floatCenter)
    , ("M-S-f", withAll float)

    -- MultiMedia Keys
    , ("<XF86AudioRaiseVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ +1.5%")
    , ("<XF86AudioLowerVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@  -1.5%")
    , ("<XF86AudioMute>", spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle")    
    , ("<XF86AudioPlay>", spawn "playerctl play-pause")    
    , ("<XF86AudioPrev>", spawn "playerctl previous")    
    , ("<XF86AudioNext>", spawn "playerctl next")    
    , ("<XF86MonBrightnessUp>", spawn "light -A 5")    
    , ("<XF86MonBrightnessDown>", spawn "light -U 5")
    ]

    where
        floatCenter w = windows (\s -> W.float w (W.RationalRect (1/3) (1/4) (1/2) (4/5)) s)


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
myLayout = avoidStruts $ mouseResize (tiled ||| Mirror tiled ||| Full) 
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

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

------------------------------------------------------------------------
-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
myEventHook = docksEventHook 

------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
myLogHook = return ()

-- Perform an arbitrary action each time xmonad starts or is restarted
myStartupHook = do
    spawnOnce "nitrogen --restore &"
    spawnOnce "picom -f &"
    spawnOnce "xscreensaver --no-splash &"
    spawnOnce ("xss-lock --" ++ myScreensaver)

-- Run xmonad and other stuff
main = do
    xmproc <- spawnPipe "xmobar -x 0 $HOME/.xmonad/xmobar.hs"
    xmonad $ ewmh xmonadConfig

-- Config for xmonad run
xmonadConfig = def {
        -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

        mouseBindings      = myMouseBindings,

        -- hooks, layouts
        layoutHook         = myLayout,
        manageHook         = myManageHook <+> manageDocks,
        handleEventHook    = myEventHook,
        logHook            = myLogHook,
        startupHook        = myStartupHook
    } `additionalKeysP` myKeys 
