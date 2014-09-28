-- haskell
-- import Data.List -- For `isSuffixOf` (1)

import XMonad
import qualified XMonad.StackSet as W
import qualified Data.Map as M
import System.Exit

-- utilities
import XMonad.Util.Run --to use safespawn
import XMonad.Util.WorkspaceCompare --to use getSortByIndex in ppSort
import XMonad.Util.Scratchpad --to use scratchpadFilterOutWorkspace&scratchpad
import XMonad.Util.EZConfig --easy M-key like bindings

-- actions and prompts
import XMonad.Actions.GridSelect
import XMonad.Actions.CycleWS --toggleWS (2)
import XMonad.Actions.GroupNavigation --toggle between windows (3)
import XMonad.Actions.FocusNth --focus nth window in current workspace (5)
import XMonad.Actions.PhysicalScreens --Change between screens (9)
import XMonad.Prompt
import XMonad.Prompt.Shell
import XMonad.Prompt.AppendFile
import qualified XMonad.Prompt         as P
import qualified XMonad.Actions.Submap as SM
import qualified XMonad.Actions.Search as S

-- hooks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.InsertPosition -- position and focus for new windows (6)

-- layouts
import XMonad.Layout.NoBorders
import XMonad.Layout.ResizableTile
import XMonad.Layout.PerWorkspace (onWorkspace)
import XMonad.Layout.Named
import XMonad.Layout.Reflect
import XMonad.Layout.Tabbed -- Tabbed layout (8)
import XMonad.Layout.LayoutHints
-- import XMonad.Layout.TabBarDecoration -- Tabbed layout (8)

-- local libs
import DynamicTopic -- (7)

-------------------------------------------------------------------------------
---- Main ---
-------------------------------------------------------------------------------
main :: IO ()
main = xmonad =<< statusBar cmd pp kb conf
    where
        uhook = withUrgencyHookC NoUrgencyHook urgentConfig
        --Command to launch the bar. Launch it on screen 0 and 1 (-x = --screen)
        -- cmd = "bash -c \"tee >(xmobar -x0 $HOME/.config/xmobar/xmobarrc) | xmobar -x1 $HOME/.config/xmobar/xmobarrc\""
        cmd = "xmobar -x0 $HOME/.config/xmobar/xmobarrc"
        --Custom pp, determines what is being written to the bar
        pp = myPP
        --Keybinding to toggle the gap for the bar
        kb = toggleStrutsKey
        --Main configuration
        conf = uhook myConfig

-------------------------------------------------------------------------------
--- xmobar various settings ---
-------------------------------------------------------------------------------
--Urgent notification
urgentConfig = UrgencyConfig { suppressWhen = Focused, remindWhen = Dont }
--Toggle key
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

-------------------------------------------------------------------------------
--- Configs ---
-------------------------------------------------------------------------------
myConfig = defaultConfig { focusFollowsMouse = False
                           , terminal      = myTerminal
                           , workspaces    = myWorkspaces
                           , modMask       = myModMask
                           , borderWidth   = myBorderWidth
                           , normalBorderColor = colorNormalBorder
                           , focusedBorderColor = colorFocusedBorder
                           , keys = myKeys
                           , layoutHook = myLayout
                           , manageHook = myManageHook
                           , logHook = historyHook -- (1)
                         }

--Declarations
colorBlack      = "#000000"
colorBlackAlt   = "#040404"
colorGray       = "#444444"
colorGrayAlt    = "#282828"
colorDarkGray   = "#161616"
colorWhite      = "#cfbfad"
colorWhiteAlt   = "#8c8b8e"
colorDarkWhite  = "#606060"
colorCream      = "#a9a6af"
colorDarkCream  = "#5f656b"
colorMagenta    = "#a488d9"
colorMagentaAlt = "#7965ac"
colorDarkMagenta= "#8e82a2"
colorBlue       = "#98a7b6"
colorBlueAlt    = "#5d7caf"
colorDarkBlue   = "#464a4a"
colorGranate    = "#410039"
colorPink       = "#ff6ffa"
colorNormalBorder   = colorDarkGray
colorFocusedBorder  = colorDarkBlue
myTerminal      = "termite"
myTerminal2     = "urxvt"
myBorderWidth   = 1
myModMask = mod4Mask

--hooks
myManageHook :: ManageHook
myManageHook = (composeAll . concat $
            [[ className =? "Firefox"    --> insertPosition End Older <+> doShift "web" -- (6)
            , className =? "Firefox" <&&> resource =? "Download" --> doFloat
            , className =? "Chromium"   --> insertPosition End Older <+> doShift "web" -- (6)
            , className =? "Pavucontrol" --> insertPosition End Older <+> doShift "im" -- (6)
            , className =? "Okular"   --> doShift "doc"
            , className =? "MuPDF"   --> doShift "doc"
            -- , fmap ("libreoffice" `isPrefixOf`) className --> doShift "doc" -- (1)
            -- , title =? "LibreOffice" --> doShift "doc"
            , className =? "X2goclient"    --> doShift "7"
            , className =? "X2GoAgent"    --> doShift "7"
            , className =? "mpv"    --> doShift "8"
            , className =? "Vlc"    --> doShift "8"
            , className =? "Hamster-time-tracker" --> doShift "NSP"
            , className =? "Osmo" --> doShift "NSP"
            , className =? "trayer" --> doIgnore
            , className =? "URxvt" --> insertPosition Below Newer -- (6)
            , className =? "Termite" --> insertPosition Below Newer -- (6)
            , className =? "Gtkdialog" --> doFloat
            , className =? "Gimp" --> doFloat
            ]]) <+> manageScratchPad

manageScratchPad :: ManageHook
manageScratchPad = scratchpadManageHook (W.RationalRect (1/4) (1/4) (1/2) (1/2))


-------------------------------------------------------------------------------
--- Themes ---
-------------------------------------------------------------------------------
--Theme for: xmobar
myPP = xmobarPP { ppCurrent = xmobarColor colorBlueAlt ""
                  , ppTitle =  shorten 50
                  , ppSep =  " <fc=#a488d9>:</fc> "
                  , ppUrgent = xmobarColor "" colorPink
                  , ppSort = fmap (.scratchpadFilterOutWorkspace) getSortByIndex
                }
--Theme for: prompt
myXPConfig = defaultXPConfig {  font = "terminus"
                                , fgColor           = colorDarkMagenta
                                , bgColor           = colorDarkGray
                                , bgHLight          = colorMagenta
                                , fgHLight          = colorDarkGray
                                , borderColor       = colorBlackAlt
                                , promptBorderWidth = 1
                                , height = 18
                                , position = Bottom
                                , historySize = 100
                                , historyFilter = deleteConsecutive
                             }
--Theme for: Tabbed layout (8)
myTabConfig = defaultTheme {  activeColor     = "#2d2d2d"
                            , activeBorderColor   = "#2d2d2d"
                            , activeTextColor     = "#ffffff"
                            , inactiveColor   = "#444444"
                            , inactiveBorderColor = "#444444"
                            , inactiveTextColor   = "#9c9c9c"
                            , decoHeight      = 24
                            , decoWidth       = 350
                            , fontName        = "terminus"
                           }

-------------------------------------------------------------------------------
--- Layouts ---
-------------------------------------------------------------------------------

--topics or workspaces
myWorkspaces :: [WorkspaceId]
myWorkspaces = [ "web", "doc", "dev", "term", "5", "6", "7", "8", "im", "NSP"]

--layouts
myLayout = customLayout
customLayout =  onWorkspace "web" fsLayout $
                onWorkspace "dev" devLayout $
                standardLayouts
    where
    standardLayouts = myTab ||| rmtiled ||| full ||| tiled

    rt = ResizableTall 1 (2/100) (1/2) []
    mtiled = named "M[]=" $ smartBorders $ Mirror rt

    myTab = named "Tab" $ tabbed shrinkText myTabConfig -- (8)
    rmtiled = named "RM[]=" $ smartBorders $ reflectVert mtiled
    full = named "[]" $ noBorders Full
    tiled = named "[]=" $ smartBorders rt

    fsLayout = myTab ||| full
    devLayout = layoutHints (full ||| tiled)


-------------------------------------------------------------------------------
--- Keys ---
-------------------------------------------------------------------------------
--Search the web: mod + (s OR S-s) + search engine
searchEngineMap method = M.fromList $
    [ ((0, xK_d), method S.dictionary)
    , ((0, xK_t), method S.thesaurus)
    , ((0, xK_w), method $ S.searchEngine "wordReference" "http://www.wordreference.com/es/translation.asp?tranword=")
    , ((0, xK_b), method $ S.searchEngine "BBS" "http://bbs.archlinux.org/search.php?action=search&sort_dir=DESC&keywords=")
    , ((0, xK_a), method $ S.searchEngine "archwiki" "http://wiki.archlinux.org/index.php/Special:Search?search=")
    , ((0, xK_q), method $ S.searchEngine "duckduckgo" "https://duckduckgo.com/?q=")
    ]

myKeys conf = mkKeymap conf $ [
    --Making use of multimedia keys
      ("<XF86AudioMute>", safeSpawn "amixer" ["-q","set","Master","toggle"])
    , ("<XF86AudioLowerVolume>", safeSpawn "amixer" ["-q","set","Master","15%-"])
    , ("<XF86AudioRaiseVolume>", safeSpawn "amixer" ["-q","set","Master","15%+"])
    , ("<XF86AudioPlay>", safeSpawn "ncmpcpp" ["toggle"])
    , ("<XF86AudioStop>", safeSpawn "ncmpcpp" ["stop"])
    , ("<XF86AudioNext>", safeSpawn "ncmpcpp" ["next"])
    , ("<XF86AudioPrev>", safeSpawn "ncmpcpp" ["prev"])

    --Actions
    , ("M-=", safeSpawn "xbacklight" ["-inc", "5"]) --Increase screen brightness
    , ("M--", safeSpawn "xbacklight" ["-dec", "5"]) --Decrease screen brightness
    , ("M-a f", safeSpawn "pcmanfm" []) --Launch file manager
    , ("M-a u", focusUrgent) --Go to urgent window
    , ("M-a g", goToSelected defaultGSConfig { gs_cellwidth = 250 })
    , ("M-a t", changeDir myXPConfig) --Change the dir of the topic (7)
    , ("M-a z", appendFilePrompt myXPConfig "dev/UNI/NOTES")
    , ("M-a l", safeSpawn "xlock" ["-mode","space"]) --Lock
    , ("M-a s", safeSpawn "bash" ["-c", "systemctl suspend"]) --Suspend
    , ("M-S-a s", safeSpawn "bash" ["-c", "systemctl suspend || xlock"]) --Suspend & Lock
    , ("M-a x", safeSpawn "bash" ["dev/clipsync/dmenu.sh"])
    , ("M-S-a x", safeSpawn "python" ["dev/clipsync/sync.py"])

    --Applications
    , ("M-f", safeSpawn "firefox" [])
    , ("M-S-f 0", safeSpawn "firefox" ["-P"])
    , ("M-S-f 1", safeSpawn "firefox" ["-P", "Primary"])
    , ("M-S-f 2", safeSpawn "firefox" ["--no-remote", "-P", "Class"])
    , ("M-S-f 3", safeSpawn "firefox" ["--no-remote", "-P", "Social"])
    , ("M-S-f 7", safeSpawn "firefox" ["--no-remote", "-P", "Peks"])
    , ("M-S-f 9", safeSpawn "firefox" ["--no-remote", "-P", "Locked"])
    , ("M-u c", safeSpawn "chromium" ["--incognito"])
    , ("M-u s", safeSpawn "spicec" ["--hotkeys", "toggle-fullscreen=shift+f12,release-cursor=win","-h", "127.0.0.1", "-p", "5930"])
    , ("M-u v", safeSpawn "v4l2-ctl" ["-c", "exposure_auto=1", "-c", "exposure_absolute=22"])

    --Launching
    , ("M-<Return>", spawnShell) --Launch shell in topic (7)
    , ("M-S-<Backspace>", spawn myTerminal2) --Launch shell
    , ("M-<Backspace>", scratchpadSpawnAction defaultConfig  {terminal = myTerminal2}) --Launch scratchpad
    , ("M-p", shellPrompt myXPConfig)
    --Navigate through windows or workspaces
    , ("M-q", toggleWS' ["NSP"]) --Toggle between workspaces (2)
    , ("M-<Tab>", nextMatchWithThis History className) --Toggle between windows of same class (3)
    , ("M-`", nextMatch History (className =? "Termite")) -- Toggle between terminals (3)
    --search the web
    , ("M-s", SM.submap $ searchEngineMap $ S.promptSearch myXPConfig)
    , ("M-S-s", SM.submap $ searchEngineMap $ S.selectSearch)

    --killing
    , ("M-S-q", kill)
    --layouts
    , ("M-<Space>", sendMessage NextLayout)
    , ("M-S-<Space>", sendMessage FirstLayout)
    --floating layer stuff
    , ("M-t", withFocused $ windows . W.sink)
    --focus
    , ("M-j", windows W.focusDown)
    , ("M-k", windows W.focusUp)
    --swapping
    , ("M-S-<Return>", windows W.shiftMaster)
    , ("M-S-j", windows W.swapDown  )
    , ("M-S-k", windows W.swapUp    )
    --resizing
    , ("M-h", sendMessage Shrink)
    , ("M-l", sendMessage Expand)
    , ("M-S-h", sendMessage MirrorShrink) --Dec win size in master area
    , ("M-S-l", sendMessage MirrorExpand) --Inc win size in master are --Inc win size in master areaa
    , ("M-S-,", sendMessage (IncMasterN 1)) --Inc win # in master area
    , ("M-S-.", sendMessage (IncMasterN (-1))) --Dec win # in master area
    --change between screens
    , ("M-<Left>", onPrevNeighbour W.view) -- Mod + <left key> (9)
    , ("M-<Right>", onNextNeighbour W.view) -- Mod + <right key> (9)
    --quit, or restart
    , ("M-S-e", io (exitWith ExitSuccess)) --Exit X
    , ("M-S-r", restart "xmonad" True) --Restart WM
    , ("M-S-o", safeSpawn "systemctl" ["poweroff"]) --Turn off computer
    ]
    -- mod-[1..9],          Switch to workspace N
    -- mod-shift-[1..9],    Move client to workspace N
    ++ [(m ++ k, windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) $ map show [1..9]
        , (f, m) <- [(W.greedyView, "M-"), (W.shift, "M-S-")]
    ]
