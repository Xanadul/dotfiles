# colors = {
# "bg":     '#282a36',
# "cl":     '#44475a',
# "fg":     '#f8f8f2',
# "comm":   '#6272a4',
# "cyan":   '#8be9fd',
# "green":  '#50fa7b',
# "orange": '#ffb86c',
# "pink":   '#ff79c6',
# "purple": '#bd93f9',
# "red":    '#ff5555',
# "yellow": '#f1fa8c'
# }
colors = {
    "bg": "#fffbfc",
    "cl": "#44475a",
    "fg": "#f8f8f2",
    "comm": "#6272a4",
    "cyan": "#8be9fd",
    "green": "#50fa7b",
    "orange": "#ffb86c",
    "pink": "#0079c6",
    "purple": "#0093f9",
    "red": "#ff5555",
    "yellow": "#f1fa8c",
}

config.load_autoconfig(True)

# adblock-update

import dracula.draw

dracula.draw.blood(c, {"spacing": {"vertical": 6, "horizontal": 8}})
config.set("colors.webpage.preferred_color_scheme", "dark")

# import elia.draw
#
# elia.draw.cola(c, {
#    'spacing': {
#        'vertical': 6,
#        'horizontal': 8
#    }
# })
# config.set('colors.webpage.preferred_color_scheme' ,'light')

# import catppuccin
# catppuccin.setup(c, 'latte', True)
# config.set('colors.webpage.preferred_color_scheme' ,'light')

c.fonts.default_family = '"Source Code Pro"'  # noqa: F821

c.fonts.default_size = "14pt"

c.fonts.completion.entry = "default_size Source Code Pro"

c.fonts.debug_console = "default_size Source Code Pro"

c.fonts.prompts = "default_size sans-serif"

c.fonts.statusbar = 'default_size "Source Code Pro"'

config.set("content.cookies.accept", "no-3rdparty")
config.set("content.cookies.accept", "all", "chrome-devtools://*")
config.set("content.cookies.accept", "all", "devtools://*")

config.set(
    "content.headers.user_agent",
    "Mozilla/5.0 ({os_info}) AppleWebKit/{webkit_version} (KHTML, like Gecko) {upstream_browser_key}/{upstream_browser_version} Safari/{webkit_version}",
    "https://web.whatsapp.com/",
)
config.set(
    "content.headers.user_agent",
    "Mozilla/5.0 ({os_info}; rv:109.0) Gecko/20100101 Firefox/115.0",
    "https://accounts.google.com/*",
)
config.set(
    "content.headers.user_agent",
    "Mozilla/5.0 ({os_info}) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99 Safari/537.36",
    "https://*.slack.com/*",
)
config.set(
    "content.headers.user_agent",
    "Mozilla/5.0 ({os_info}; rv:109.0) Gecko/20100101 Firefox/115.0",
    "https://docs.google.com/*",
)
config.set(
    "content.headers.user_agent",
    "Mozilla/5.0 ({os_info}; rv:109.0) Gecko/20100101 Firefox/115.0",
    "https://drive.google.com/*",
)

config.set("content.javascript.enabled", True, "chrome-devtools://*")
config.set("content.javascript.enabled", True, "devtools://*")
config.set("content.javascript.enabled", True, "chrome://*/*")
config.set("content.javascript.enabled", True, "qute://*/*")
config.set("content.javascript.enabled", True, "https://discord.com/*")

config.set("content.javascript.enabled", True, "https://192.168.1.2/3003")

config.set("content.javascript.clipboard", "access")

config.set("content.images", True, "chrome-devtools://*")
config.set("content.images", True, "devtools://*")
config.set("content.autoplay", False)

config.set("content.notifications.enabled", True, "https://www.youtube.com")

c.downloads.location.directory = "~/Downloads"

config.set("zoom.default", "150%")

c.url.searchengines = {
    #'DEFAULT': 'hanako.ts:8380/search?q={}&category_general=1&language=en-US&time_range=&safesearch=0&theme=simple',
    "DEFAULT": "https://search.brave.com/search?q={}&source=web",
    "am": "https://www.amazon.de/s?k={}",
    "aw": "https://wiki.archlinux.org/?search={}",
    "ge": "https://wiki.gentoo.org/index.php?title=Special%3ASearch&search={}&go=Go",
    "go": "https://www.google.com/search?q={}",
    "re": "https://www.reddit.com/r/{}",
    "ub": "https://www.urbandictionary.com/define.php?term={}",
    "wiki": "https://en.wikipedia.org/wiki/{}",
    "yt": "https://www.youtube.com/results?search_query={}",
}

c.url.default_page = "search.brave.com:3003"
c.url.start_pages = "search.brave.com:3003"

config.set("auto_save.session", True)

config.set("session.lazy_restore", True)

c.aliases = {"q": "quit", "w": "session-save", "wq": "quit --save"}

config.unbind("H")
config.unbind("sk")
config.unbind("M")
config.unbind("Sq")
config.unbind("gb")
config.unbind("<Ctrl+Shift+w>")
config.unbind("wi")
config.unbind("wIf")
config.unbind("gd")
config.unbind("ad")
config.unbind("cd")
config.unbind("L")
config.unbind("Sh")
config.unbind("<Ctrl+h>")
config.unbind("q")
config.unbind("@")
config.unbind("<Ctrl+Shift+Tab>")
config.unbind("o")
config.unbind("b")
config.unbind("m")
config.unbind("ZQ")
config.unbind("<Ctrl+q>")
config.unbind("<Ctrl+Alt+p>")
config.unbind("sf")
config.unbind("ss")
config.unbind("Ss")
config.unbind("<Ctrl+s>")
config.unbind("gC")
config.unbind("d")
config.unbind("<Ctrl+w>")
config.unbind("T")
config.unbind("gD")
config.unbind("gm")
config.unbind("<Alt+m>")
config.unbind("J")
config.unbind("<Ctrl+PgDown>")
config.unbind("co")
config.unbind("<Ctrl+p>")
config.unbind("K")
config.unbind("<Ctrl+PgUp>")
config.unbind("gt")
config.unbind("<Ctrl+Shift+t>")
config.unbind("gf")

# These are all bound to "reload" by default.... WHYYYYY?
config.unbind("tsu")
config.unbind("tsh")
config.unbind("tpu")
config.unbind("tiu")
config.unbind("tih")
config.unbind("tcu")
config.unbind("tch")
config.unbind("tph")
config.unbind("tcH")
config.unbind("tiH")
config.unbind("tpH")
config.unbind("tsH")
config.unbind("tCh")
config.unbind("tCu")
config.unbind("tCH")
config.unbind("tIh")
config.unbind("tIu")
config.unbind("tIH")
config.unbind("tPh")
config.unbind("tPu")
config.unbind("tPH")
config.unbind("tSh")
config.unbind("tSu")
config.unbind("tSH")

config.bind("<Space><Space>", "cmd-set-text -s :")
config.bind("<Space>.", "cmd-set-text -s :open ")
config.bind("<Space>t", "cmd-set-text -s :open -t")
config.bind("<Space>n", "cmd-set-text -s :open -t")
config.bind("<Control+Down>", "tab-next")
config.bind("<Control+Up>", "tab-prev")
config.bind("<Shift+Down>", "tab-move +")
config.bind("<Shift+Up>", "tab-move -")

config.bind("<Space>fm", "hint links spawn umpv {hint-url}")
config.bind("<Space>fM", "hint links spawn mpv {hint-url}")
config.bind("<Space>fy", 'hint links spawn wl-copy "{hint-url}"')

config.bind("<Space>ts", "config-cycle statusbar.show never always")
config.bind("<Space>tt", "config-cycle tabs.show never always")
config.bind(
    "<Space>ta",
    "config-cycle statusbar.show never always;; config-cycle tabs.show always never",
)

config.bind("<Space>bb", "set-cmd-text -s :tab-select ")
config.bind("<Space>bc", "tab-close")
config.bind("<Space>bd", "tab-close")
config.bind("D", "tab-close")

config.bind("<Control+Left>", "back")
config.bind("<Control+Right>", "forward")

config.set("hints.chars", "nctaresi")

c.colors.hints.bg = colors["bg"]
c.colors.hints.fg = colors["pink"]
# c.colors.hints.match.fg = '#98be65'
c.colors.hints.match.fg = colors["green"]

config.set("fonts.hints", "bold 18pt JetBrainsMono")

config.set("tabs.show", "always")
config.set("tabs.position", "left")

config.set("tabs.max_width", 350)
config.set("tabs.width", "12%")

config.set("tabs.select_on_remove", "prev")

config.set("tabs.title.format", "{index}{audio}:  {current_title}")
config.set("fonts.tabs.unselected", "12pt default_family")

config.set("statusbar.padding", {"bottom": 6, "left": 8, "right": 8, "top": 6})
config.set(
    "statusbar.widgets", ["keypress", "url", "scroll", "history", "tabs", "progress"]
)
