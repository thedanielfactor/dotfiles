# Create space and set wallpaper
# yabai -m space --create
# yabai -m space --focus $i
# set_wallpaper "$HOME/.local/share/wallpapers/catppuccin/$(/bin/ls ~/.local/share/wallpapers/catppuccin | shuf -n 1)"
#
# Get all of the displays
DISPLAY_COUNT=$(yabai -m query --displays)
#
# yabai -m query --displays
# [{
# 	"id":1,
# 	"uuid":"37D8832A-2D66-02CA-B9F7-8F30A301B230",
# 	"index":1,
# 	"label":"",
# 	"frame":{
# 		"x":0.0000,
# 		"y":0.0000,
# 		"w":1728.0000,
# 		"h":1117.0000
# 	},
# 	"spaces":[1],
# 	"has-focus":false
# },{
# 	"id":4,
# 	"uuid":"5122DA14-4891-4E2F-B0C1-68F67AE85F9E",
# 	"index":3,
# 	"label":"",
# 	"frame":{
# 		"x":-1920.0000,
# 		"y":-120.0000,
# 		"w":1920.0000,
# 		"h":1080.0000
# 	},
# 	"spaces":[3],
# 	"has-focus":true
# },{
# 	"id":5,
# 	"uuid":"43478A01-EC62-47D7-8DBA-D3C77907DEC3",
# 	"index":2,
# 	"label":"",
# 	"frame":{
# 		"x":1728.0000,
# 		"y":-148.0000,
# 		"w":1920.0000,
# 		"h":1080.0000
# 	},
# 	"spaces":[2],
# 	"has-focus":false
# }]
# 
# Get the display with the smallest x (Leftmost screen - L) - name it code
LEFTMOST=$(yabai -m query --displays | jq 'min_by(.frame.x) | .index')
MIDDLE=$(yabai -m query --displays | jq '.[] | select(.frame.x == 0.0000) | .index')
RIGHTMOST=$(yabai -m query --displays | jq 'max_by(.frame.x) | .index')

yabai -m display $LEFTMOST --label development 
# Get the display with an x of 0 (Middle screen - M) - name it browsing
yabai -m display $MIDDLE --label information 
# Get the display with the largest x (Rightmost screen - R) - name it messaging
yabai -m display $RIGHTMOST --label communication

# For display development I need the following spaces:
# Space 1 - label IDE, launch Kitty with Neovim
# Space 2 - label AWS-Inf, launch Firefox with the infrastructure console
#
# For display information need the following spaces:
# Space 1 - label Browsing, Launch Arc browser
# Space 2 - label Calendar, Launch Fantastical
#
# For Display communication I need the following spaces:
# Space 1 - label Slack, Launch Slack
# Space 2 - label Discord, Launch Discord
# Space 3 - label Spotify, Launch Spotify
# Space 4 - label Messaging, Launch Messages
