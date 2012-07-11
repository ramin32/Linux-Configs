-- xmonad.hs
-- Author: sujoy `binarycodes` <lovesujoy@gmail.com>
--
-- Last Modified: 19th October, 2008
--

-------------------------------------------------------------------------------
-- Imports --
-- stuff
import XMonad
import qualified XMonad.StackSet as W
import qualified Data.Map as M
import Data.Ratio ((%))
import System.Exit
import System.IO (Handle, hPutStrLn)

-- utils
import XMonad.Util.Run (spawnPipe)

-- hooks
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.ManageHelpers
import XMonad.ManageHook

-- layouts
import XMonad.Layout.NoBorders
import XMonad.Layout.ResizableTile
import XMonad.Layout.Tabbed
import XMonad.Layout.Grid
import XMonad.Layout.Accordion
import XMonad.Layout.PerWorkspace (onWorkspace)
import XMonad.Layout.IM
import XMonad.Layout.ThreeColumns


-- Java
--import XMonad.Hooks.SetWMName



-------------------------------------------------------------------------------
-- Main --
main = do
       h <- spawnPipe "xmobar"
       xmonad $ withUrgencyHook NoUrgencyHook
              $ defaultConfig
              { workspaces = workspaces'
              , modMask = modMask'
              , borderWidth = borderWidth'
              , normalBorderColor = normalBorderColor'
              , focusedBorderColor = focusedBorderColor'
              , terminal = terminal'
              , keys = keys'
              , logHook = logHook' h
              , layoutHook = smartBorders(layoutHook')
              , manageHook = manageHook'
              -- , startupHook = setWMName "LG3D"  -- Needed to make Java GUI apps work
              }

-------------------------------------------------------------------------------
-- Hooks --
manageHook' :: ManageHook
manageHook' = myManageHook <+> manageHook defaultConfig <+> manageDocks <+> (doF W.swapDown)

myManageHook = composeAll $ concat
             [ [ stringProperty "WM_WINDOW_ROLE" =? roleC --> doIgnore | roleC <- hide ]
             , [ className =? webC --> doF (W.shift $ getWorkspaceId "web")  | webC <- web ]
             , [ className =? mailC --> doF (W.shift $ getWorkspaceId "mail") | mailC <- mail ]
             , [ className =? docC --> doF (W.shift $ getWorkspaceId "doc")  | docC <- doc ]
             , [ className =? codeC --> doF (W.shift $ getWorkspaceId "code") | codeC <- code ]
             , [ className =? chatC --> doF (W.shift $ getWorkspaceId "chat") | chatC <- chat ]
             , [ className =? multC --> doF (W.shift $ getWorkspaceId "mult") | multC <- mult ]
             , [ className =? downC --> doF (W.shift $ getWorkspaceId "down") | downC <- down ]
             , [isFullscreen --> doFullFloat]
             ]
             where web  = [ ]
                   doc  = [ ]
                   code = [ ]
                   chat = [ ]
                   mult = [ ]
                   mail = [ ]
                   down = [ ]
                   hide = [ ]


logHook' :: Handle ->  X ()
logHook' h = dynamicLogWithPP $ customPP { ppOutput = hPutStrLn h }

layoutHook' = customLayout

-------------------------------------------------------------------------------
-- Looks --
-- bar
customPP :: PP
customPP = defaultPP { ppCurrent = xmobarColor "#3579A8" ""
                     , ppTitle =  shorten 80
                     , ppSep =  "<fc=#3579A8> | </fc>"
                     , ppUrgent = wrap "<fc=#FF0000>*</fc>" "<fc=#FF0000>*</fc>"  
                     , ppHidden = xmobarColor "#B07CBE" "" 
                     , ppHiddenNoWindows = xmobarColor "#C4C4C4" ""
		     , ppLayout = const ""
		     , ppOrder = \(ws:_:t:_) ->  [t, ws]
                     }

-- borders
borderWidth' :: Dimension
borderWidth' = 2 

normalBorderColor', focusedBorderColor' :: String
normalBorderColor'  = "#222222"
focusedBorderColor' = "#cd8b00"

-- workspaces
workspaceNames :: [String]
workspaceNames = [ "main", "web", "chat", "doc", "code", "mail", "mult", "down" ]

workspaces' :: [WorkspaceId]
workspaces' = zipWith (++) (map show [1..]) wsnames
	where wsnames = map((:) ':') workspaceNames

getWorkspaceId :: String -> WorkspaceId
getWorkspaceId name = case lookup name (zip workspaceNames workspaces') of
	Just wsId -> wsId
	Nothing -> head workspaces'

-- layouts
customLayout = onWorkspace (getWorkspaceId "main") mainL
             $ onWorkspace (getWorkspaceId "web") webL
             $ onWorkspace (getWorkspaceId "doc") docL
             $ onWorkspace (getWorkspaceId "chat") chatL
             $ onWorkspace (getWorkspaceId "code") codeL
	     $ onWorkspace (getWorkspaceId "mult") multL
             $ restL
        where tiled = ResizableTall 1 (2/100) (1/2) []
              threeCol = ThreeCol 1 (3/100) (1/2)

              ration = 1%5

              mainL = avoidStruts $ smartBorders (tiled ||| Mirror tiled ||| Full ||| tiled)
              webL  = avoidStruts $ smartBorders (Mirror tiled ||| Full ||| tiled)
              docL  = avoidStruts $ smartBorders (Mirror tiled ||| Full ||| tiled)
              codeL = avoidStruts $ smartBorders (Mirror tiled ||| Full ||| tiled)
              chatL = avoidStruts $ smartBorders (Mirror tiled ||| threeCol |||  tiled)
	      multL = avoidStruts $ smartBorders (Mirror tiled ||| threeCol ||| tiled)
              restL = avoidStruts $ smartBorders (Mirror tiled ||| tiled ||| Full)

-------------------------------------------------------------------------------
-- Terminal --
terminal' :: String
terminal' = "urxvt"

-- Dmenu stuffs --
myBarFont :: String
myBarFont = "-*-bitstream vera sans mono-medium-r-*-*-10-*-*-*-*-*-*-*"
--myBarFont = "xft:Bitstream Vera Sans Mono-7"

myFocsFG, myFocsBG :: String
myFocsFG = "#abcdef" -- focused foreground colour
myFocsBG = "#333333" -- focused background colour

myNormFG, myNormBG :: String
myNormFG = "#ffffff" -- normal foreground colour
myNormBG = "#000000" -- normal background colour

myDmenuCmd :: String
myDmenuCmd = "dmenu_path | dmenu -i -p 'Run:'" ++ myDmenuOpts
      where myDmenuOpts = concatMap ((:) ' '. (:) '-')
                  [ wrap "nf '" "'" myNormFG
                  , wrap "nb '" "'" myNormBG
                  , wrap "sf '" "'" myFocsFG
                  , wrap "sb '" "'" myFocsBG
                  , wrap "fn '" "'" myBarFont ]

-------------------------------------------------------------------------------
-- Keys/Button bindings --
-- modmask
modMask' :: KeyMask
modMask' = mod1Mask

-- keys
keys' :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
keys' conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
    -- launching and killing programs
    [ --((modMask,               xK_Return), spawn $ XMonad.terminal conf)
     ((modMask,               xK_p     ), spawn $ "exe=`" ++ myDmenuCmd ++ "` && eval \"exec $exe\"")
    , ((modMask,               xK_F2    ), spawn "gmrun")
    , ((modMask,               xK_z    ), spawn "xterm")
    , ((modMask,               xK_x    ), spawn "chromium-browser")
    , ((modMask,               xK_p    ), spawn "pcmanfm")
    , ((modMask .|. shiftMask, xK_z ), spawn "slock")
    , ((modMask .|. shiftMask, xK_p ), spawn "sudo poweroff")
    , ((modMask, xK_c     ), kill)
    --, ((modMask .|. shiftMask, xK_m     ), spawn "thunderbird")
    --, ((modMask,	       xK_f	), spawn "opera")
    --, ((modMask .|. shiftMask, xK_p	), spawn "pidgin")
    --, ((modMask,	       xK_o	), spawn "opera")
    --, ((modMask,               xK_w     ), spawn "/usr/lib/wicd/gui.py")
    --, ((modMask,               xK_e     ), spawn "urxvtc -e emacs -nw")
 -- multimedia keys
   --
   -- XF86AudioLowerVolume
   , ((0            , 0x1008ff11), spawn "amixer set PCM 2-")
   -- XF86AudioRaiseVolume
   , ((0            , 0x1008ff13), spawn "amixer set PCM 2+")
   -- XF86AudioMute
   , ((0            , 0x1008ff12), spawn "amixer set Master toggle")
    -- layouts
    , ((modMask,               xK_space ), sendMessage NextLayout)
    , ((modMask .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)
    , ((modMask,               xK_b     ), sendMessage ToggleStruts)

    -- floating layer stuff
    , ((modMask,               xK_t     ), withFocused $ windows . W.sink)

    -- refresh
    , ((modMask,               xK_n     ), refresh)

    -- focus
    , ((modMask,               xK_Tab   ), windows W.focusDown)
    , ((modMask,               xK_j     ), windows W.focusDown)
    , ((modMask,               xK_k     ), windows W.focusUp)
    , ((modMask,               xK_m     ), windows W.focusMaster)

    -- swapping
    , ((modMask , xK_Return), windows W.swapMaster)
    , ((modMask .|. shiftMask, xK_j     ), windows W.swapDown  )
    , ((modMask .|. shiftMask, xK_k     ), windows W.swapUp    )

    -- increase or decrease number of windows in the master area
    , ((modMask              , xK_comma ), sendMessage (IncMasterN 1))
    , ((modMask              , xK_period), sendMessage (IncMasterN (-1)))

    -- resizing
    , ((modMask,               xK_h     ), sendMessage Shrink)
    , ((modMask,               xK_l     ), sendMessage Expand)
    , ((modMask .|. shiftMask, xK_h     ), sendMessage MirrorShrink)
    , ((modMask .|. shiftMask, xK_l     ), sendMessage MirrorExpand)

    -- quit, or restart
    , ((modMask .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))
    , ((modMask              , xK_q     ), restart "xmonad" True)

    ]
    ++
    -- mod-[1..9] %! Switch to workspace N
    -- mod-shift-[1..9] %! Move client to workspace N
    [((m .|. modMask, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]

-------------------------------------------------------------------------------

