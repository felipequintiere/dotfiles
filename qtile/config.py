# ------------------------------------------------------------
# LIBRARIES
# ------------------------------------------------------------

from libqtile import bar, layout, qtile, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

import os
import subprocess
from libqtile import hook


# ------------------------------------------------------------
# AUTOSTART
# ------------------------------------------------------------

@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~/.config/qtile/autostart.sh')
    subprocess.call(home)


# ------------------------------------------------------------
# GENERAL CONFIG
# ------------------------------------------------------------

mod = "mod4"
terminal = guess_terminal()
firefox = os.path.expanduser('/usr/bin/firefox'),


    # ********************************************************
    # DEFAULT KEYBINDS
    # --------------------------------------------------------

keys = [
    Key([mod], "h", lazy.layout.left()),
    Key([mod], "l", lazy.layout.right()),
    Key([mod], "j", lazy.layout.down()),
    Key([mod], "k", lazy.layout.up()),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),

    Key([mod, "shift"], "h", lazy.layout.shuffle_left()),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right()),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up()),

    Key([mod, "control"], "h", lazy.layout.grow_left()),
    Key([mod, "control"], "l", lazy.layout.grow_right()),
    Key([mod, "control"], "j", lazy.layout.grow_down()),
    Key([mod, "control"], "k", lazy.layout.grow_up()),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),

    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),

    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    #Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    Key(
        [mod],
        "f",
        lazy.window.toggle_fullscreen(),
        desc="Toggle fullscreen on the focused window",
    ),
    Key([mod], "t", lazy.window.toggle_floating(), desc="Toggle floating on the focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    #Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),


    # ********************************************************
    # CUSTOM KEYBINDS
    # --------------------------------------------------------

    Key([mod, "shift", "control"], "h", lazy.layout.swap_column_left()),
    Key([mod, "shift", "control"], "l", lazy.layout.swap_column_right()),
    Key(["mod1", "shift"], "h", lazy.layout.swap_column_left()),
    Key(["mod1", "shift"], "l", lazy.layout.swap_column_right()),

    Key(
        [mod, "shift"],
        "w",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),

    Key([mod], "e", lazy.layout.next()),
    Key([mod], "q", lazy.next_layout()),
    Key([mod], "c", lazy.window.kill()),
    Key([mod], "r", lazy.window.toggle_floating()),
    Key([mod, "shift"], "r", lazy.reload_config()),
    Key([mod, "shift"], "e", lazy.shutdown()),
    Key([mod], "d", lazy.spawncmd()),

    # color inversion
    Key([mod], "i",
        lazy.spawn("/home/arch/.settings/color_inversion"),
    ),

    # pactl volume control
    Key([mod, "shift"], "x",
        lazy.spawn("/home/arch/.settings/inc_vol"),
    ),
    Key([mod, "shift"], "z",
        lazy.spawn("/home/arch/.settings/dec_vol"),
    ),

    # alacritty theme
    Key([mod, "control"], "p",
        lazy.spawn("/home/arch/.config/alacritty/theme_up.sh"),
    ),
    Key([mod, "control"], "n",
        lazy.spawn("/home/arch/.config/alacritty/theme_down.sh"),
    ),

    # flameshot
    Key([mod, "shift"], "f",
        lazy.spawn("flameshot gui"),
    ),
    Key(["mod1", "shift"], "s",
        lazy.spawn("flameshot gui"),
    ),
]

# ------------------------------------------------------------
# XMONAD SETTINGS
# ------------------------------------------------------------

#xmonad_keys = [
#    Key([mod], "h", lazy.layout.left()),
#    Key([mod], "l", lazy.layout.right()),
#    Key([mod], "j", lazy.layout.down()),
#    Key([mod], "k", lazy.layout.up()),
#    Key([mod, "shift"], "h", lazy.layout.swap_left()),
#    Key([mod, "shift"], "l", lazy.layout.swap_right()),
#    Key([mod, "shift"], "j", lazy.layout.shuffle_down()),
#    Key([mod, "shift"], "k", lazy.layout.shuffle_up()),
#    Key([mod, "shift"], "i", lazy.layout.grow()),
#    Key([mod], "m", lazy.layout.shrink()),
#    Key([mod], "n", lazy.layout.reset()),
#    Key([mod, "shift"], "n", lazy.layout.normalize()),
#    Key([mod], "o", lazy.layout.maximize()),
#    Key([mod, "shift"], "s", lazy.layout.toggle_auto_maximize()),
#    Key([mod, "shift"], "space", lazy.layout.flip()),
#]
#
#xmonad_layout = {
#"align":0,
#"auto_maximize":False,
#"border_focus":'#ff0000',
#"border_normal":'#000000',
#"border_width":2,
#"change_ratio":0.05,
#"change_size":20,
#"margin":0,
#"max_ratio":0.75,
#"min_ratio":0.25,
#"min_secondary_size":85,
#"new_client_position":'after_current',
#"ratio":0.5,
#"single_border_width":None,
#"single_margin":None,
#}

# ------------------------------------------------------------
# GROUPS
# ------------------------------------------------------------

# Add key bindings to switch VTs in Wayland.
# We can't check qtile.core.name in default config as it is loaded before qtile is started
# We therefore defer the check until the key binding is run by using .when(func=...)
for vt in range(1, 8):
    keys.append(
        Key(
            ["control", "mod1"],
            f"f{vt}",
            lazy.core.change_vt(vt).when(func=lambda: qtile.core.name == "wayland"),
            desc=f"Switch to VT{vt}",
        )
    )

groups = [Group(i) for i in "123456789" "10"]

for i in groups:
    keys.extend(
        [
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc=f"Switch to group {i.name}",
            ),
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=False),
                desc=f"move focused window to group {i.name}",
            ),
        ]
    )

# ------------------------------------------------------------
# LAYOUTS
# ------------------------------------------------------------

columns_layout = {
    "border_width": 2,
    "margin": 5,
    "border_focus": "DE1D95",
    "border_normal": "A662DF",
}

floating_layout = {
    "border_focus":"ffffff",
    "border_normal":"000000",
    "border_width": 2,
    "fullscreen_border_width":0,
    "max_border_width":0,
}

GroupBox_theme0 = {

    "active":'2DDE1D',
    "background":'00000080',
    "block_highlight_text_color":None,
    "borderwidth":1,
    "center_aligned":True,
    "disable_drag":True,
    "fmt":'{}',
    "font":'sans',
    "fontshadow":None,
    "fontsize":20,
    "foreground":'ffffff',
    "hide_crash":False,
    "hide_unused":False,
    "highlight_method":'text',
    "inactive":'A662DF',
    "invert_mouse_wheel":True,
    #"margin":3,
    "margin_x":10,
    "margin_y":3,
    "markup":False,
    "max_chars":0,
    "mouse_callbacks":{},
    "other_current_screen_border":'F2211D',
    "other_screen_border":'1DE4F2',
    #padding:10,
    #padding_x:None,
    #padding_y:None,
    "rotate":True,
    "rounded":True,
    #spacing:-10,
    "this_current_screen_border":'DE1D95',
    "this_screen_border":'F21DEF',
    "toggle":True,
}

layouts = [
     layout.Columns(**columns_layout),
     layout.MonadTall(),
     layout.Max(),

    # layout.MonadWide(),
    # layout.Bsp(),

    # strange
    # layout.Stack(num_stacks=2),
    # layout.Matrix(),
    # layout.Tile(),
    # layout.RatioTile(),
    # layout.TreeTab(), # really strange
    # layout.VerticalTile(),
    # layout.Zoomy(), # really strange
]

widget_defaults = dict(
    font="sans",
    fontsize=20,
    padding=4,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        bottom=bar.Gap(5),
        left=bar.Gap(5),
        right=bar.Gap(5),

        top=bar.Bar(
            [
                widget.GroupBox(**GroupBox_theme0),
                widget.CurrentLayout(),
                widget.Prompt(),
                widget.WindowName(),
                widget.Systray(),
                widget.Clock(format="%a  %d/%m/%Y  %I:%M %p"),
                #widget.QuickExit(),
            ],
            background='#00000080',
            #background='#FFFFFF80',
            size=35,
            #border_width=[2, 1, 2, 1],
            #border_color=["ff00ff80", "00000080", "ff00ff80", "00000080"]
        ),
        # You can uncomment this variable if you see that on X11 floating resize/moving is laggy
        # x11_drag_polling_rate = 60,
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
floats_kept_above = True
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry

        Match(wm_class="PacketTracer"),  # GPG key password entry
        Match(wm_class="discord"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# xcursor theme (string or None) and size (integer) for Wayland backend
wl_xcursor_theme = None
wl_xcursor_size = 24

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
