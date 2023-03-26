# Autogenerated config.py
#
# NOTE: config.py is intended for advanced users who are comfortable
# with manually migrating the config file on qutebrowser upgrades. If
# you prefer, you can also configure qutebrowser using the
# :set/:bind/:config-* commands without having to write a config.py
# file.
#
# Documentation:
#   qute://help/configuring.html
#   qute://help/settings.html

# Change the argument to True to still load settings configured via autoconfig.yml
config.load_autoconfig(False)

# Aliases for commands. The keys of the given dictionary are the
# aliases, while the values are the commands they map to.
# Type: Dict
c.aliases = {'q': 'close', 'qa': 'quit', 'w': 'session-save', 'wq': 'quit --save', 'wqa': 'quit --save'}

# Always restore open sites when qutebrowser is reopened. Without this
# option set, `:wq` (`:quit --save`) needs to be used to save open tabs
# (and restore them), while quitting qutebrowser in any other way will
# not save/restore the session. By default, this will save to the
# session which was last loaded. This behavior can be customized via the
# `session.default_name` setting.
# Type: Bool
c.auto_save.session = True

# Which cookies to accept. With QtWebEngine, this setting also controls
# other features with tracking capabilities similar to those of cookies;
# including IndexedDB, DOM storage, filesystem API, service workers, and
# AppCache. Note that with QtWebKit, only `all` and `never` are
# supported as per-domain values. Setting `no-3rdparty` or `no-
# unknown-3rdparty` per-domain on QtWebKit will have the same effect as
# `all`. If this setting is used with URL patterns, the pattern gets
# applied to the origin/first party URL of the page making the request,
# not the request URL. With QtWebEngine 5.15.0+, paths will be stripped
# from URLs, so URL patterns using paths will not match. With
# QtWebEngine 5.15.2+, subdomains are additionally stripped as well, so
# you will typically need to set this setting for `example.com` when the
# cookie is set on `somesubdomain.example.com` for it to work properly.
# To debug issues with this setting, start qutebrowser with `--debug
# --logfilter network --debug-flag log-cookies` which will show all
# cookies being set.
# Type: String
# Valid values:
#   - all: Accept all cookies.
#   - no-3rdparty: Accept cookies from the same origin only. This is known to break some sites, such as GMail.
#   - no-unknown-3rdparty: Accept cookies from the same origin only, unless a cookie is already set for the domain. On QtWebEngine, this is the same as no-3rdparty.
#   - never: Don't accept cookies at all.
config.set('content.cookies.accept', 'all', 'chrome-devtools://*')

# Which cookies to accept. With QtWebEngine, this setting also controls
# other features with tracking capabilities similar to those of cookies;
# including IndexedDB, DOM storage, filesystem API, service workers, and
# AppCache. Note that with QtWebKit, only `all` and `never` are
# supported as per-domain values. Setting `no-3rdparty` or `no-
# unknown-3rdparty` per-domain on QtWebKit will have the same effect as
# `all`. If this setting is used with URL patterns, the pattern gets
# applied to the origin/first party URL of the page making the request,
# not the request URL. With QtWebEngine 5.15.0+, paths will be stripped
# from URLs, so URL patterns using paths will not match. With
# QtWebEngine 5.15.2+, subdomains are additionally stripped as well, so
# you will typically need to set this setting for `example.com` when the
# cookie is set on `somesubdomain.example.com` for it to work properly.
# To debug issues with this setting, start qutebrowser with `--debug
# --logfilter network --debug-flag log-cookies` which will show all
# cookies being set.
# Type: String
# Valid values:
#   - all: Accept all cookies.
#   - no-3rdparty: Accept cookies from the same origin only. This is known to break some sites, such as GMail.
#   - no-unknown-3rdparty: Accept cookies from the same origin only, unless a cookie is already set for the domain. On QtWebEngine, this is the same as no-3rdparty.
#   - never: Don't accept cookies at all.
config.set('content.cookies.accept', 'all', 'devtools://*')

# Value to send in the `Accept-Language` header. Note that the value
# read from JavaScript is always the global value.
# Type: String
config.set('content.headers.accept_language', '', 'https://matchmaker.krunker.io/*')

# User agent to send.  The following placeholders are defined:  *
# `{os_info}`: Something like "X11; Linux x86_64". * `{webkit_version}`:
# The underlying WebKit version (set to a fixed value   with
# QtWebEngine). * `{qt_key}`: "Qt" for QtWebKit, "QtWebEngine" for
# QtWebEngine. * `{qt_version}`: The underlying Qt version. *
# `{upstream_browser_key}`: "Version" for QtWebKit, "Chrome" for
# QtWebEngine. * `{upstream_browser_version}`: The corresponding
# Safari/Chrome version. * `{qutebrowser_version}`: The currently
# running qutebrowser version.  The default value is equal to the
# unchanged user agent of QtWebKit/QtWebEngine.  Note that the value
# read from JavaScript is always the global value. With QtWebEngine
# between 5.12 and 5.14 (inclusive), changing the value exposed to
# JavaScript requires a restart.
# Type: FormatString
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}) AppleWebKit/{webkit_version} (KHTML, like Gecko) {upstream_browser_key}/{upstream_browser_version} Safari/{webkit_version}', 'https://web.whatsapp.com/')

# User agent to send.  The following placeholders are defined:  *
# `{os_info}`: Something like "X11; Linux x86_64". * `{webkit_version}`:
# The underlying WebKit version (set to a fixed value   with
# QtWebEngine). * `{qt_key}`: "Qt" for QtWebKit, "QtWebEngine" for
# QtWebEngine. * `{qt_version}`: The underlying Qt version. *
# `{upstream_browser_key}`: "Version" for QtWebKit, "Chrome" for
# QtWebEngine. * `{upstream_browser_version}`: The corresponding
# Safari/Chrome version. * `{qutebrowser_version}`: The currently
# running qutebrowser version.  The default value is equal to the
# unchanged user agent of QtWebKit/QtWebEngine.  Note that the value
# read from JavaScript is always the global value. With QtWebEngine
# between 5.12 and 5.14 (inclusive), changing the value exposed to
# JavaScript requires a restart.
# Type: FormatString
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}; rv:90.0) Gecko/20100101 Firefox/90.0', 'https://accounts.google.com/*')

# User agent to send.  The following placeholders are defined:  *
# `{os_info}`: Something like "X11; Linux x86_64". * `{webkit_version}`:
# The underlying WebKit version (set to a fixed value   with
# QtWebEngine). * `{qt_key}`: "Qt" for QtWebKit, "QtWebEngine" for
# QtWebEngine. * `{qt_version}`: The underlying Qt version. *
# `{upstream_browser_key}`: "Version" for QtWebKit, "Chrome" for
# QtWebEngine. * `{upstream_browser_version}`: The corresponding
# Safari/Chrome version. * `{qutebrowser_version}`: The currently
# running qutebrowser version.  The default value is equal to the
# unchanged user agent of QtWebKit/QtWebEngine.  Note that the value
# read from JavaScript is always the global value. With QtWebEngine
# between 5.12 and 5.14 (inclusive), changing the value exposed to
# JavaScript requires a restart.
# Type: FormatString
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99 Safari/537.36', 'https://*.slack.com/*')

# Load images automatically in web pages.
# Type: Bool
config.set('content.images', True, 'chrome-devtools://*')

# Load images automatically in web pages.
# Type: Bool
config.set('content.images', True, 'devtools://*')

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'chrome-devtools://*')

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'devtools://*')

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'chrome://*/*')

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'qute://*/*')

# Allow websites to record audio.
# Type: BoolAsk
# Valid values:
#   - true
#   - false
#   - ask
config.set('content.media.audio_capture', True, 'https://discord.com')

# Allow websites to show notifications.
# Type: BoolAsk
# Valid values:
#   - true
#   - false
#   - ask
config.set('content.notifications.enabled', False, 'https://ko-fi.com')

# Allow websites to show notifications.
# Type: BoolAsk
# Valid values:
#   - true
#   - false
#   - ask
config.set('content.notifications.enabled', True, 'https://myfriendsare.gay')

# Width (in pixels) of the scrollbar in the completion window.
# Type: Int
c.completion.scrollbar.width = 15

# Padding (in pixels) of the scrollbar handle in the completion window.
# Type: Int
c.completion.scrollbar.padding = 2

# CSS border value for hints.
# Type: String
c.hints.border = '0px solid #282a36'

# Padding (in pixels) for hints.
# Type: Padding
c.hints.padding = {'bottom': 0, 'left': 6, 'right': 6, 'top': 0}

# Rounding radius (in pixels) for the edges of hints.
# Type: Int
c.hints.radius = 0

# Characters used for hint strings.
# Type: UniqueCharString
c.hints.chars = 'ntesiroahdlpjbmgkvufcyw'

# When to show the statusbar.
# Type: String
# Valid values:
#   - always: Always show the statusbar.
#   - never: Always hide the statusbar.
#   - in-mode: Show the statusbar when in modes other than normal mode.
c.statusbar.show = 'always'

# Padding (in pixels) for the statusbar.
# Type: Padding
c.statusbar.padding = {'top': 6, 'right': 8, 'bottom': 6, 'left': 8}

# List of widgets displayed in the statusbar.
# Type: List of StatusbarWidget
# Valid values:
#   - url: Current page URL.
#   - scroll: Percentage of the current page position like `10%`.
#   - scroll_raw: Raw percentage of the current page position like `10`.
#   - history: Display an arrow when possible to go back/forward in history.
#   - tabs: Current active tab, e.g. `2`.
#   - keypress: Display pressed keys when composing a vi command.
#   - progress: Progress bar for the current page loading.
#   - text:foo: Display the static text after the colon, `foo` in the example.
c.statusbar.widgets = ['keypress', 'url', 'history', 'tabs']

# Scaling factor for favicons in the tab bar. The tab size is unchanged,
# so big favicons also require extra `tabs.padding`.
# Type: Float
c.tabs.favicons.scale = 1.0

# Padding (in pixels) around text for tabs.
# Type: Padding
c.tabs.padding = {'bottom': 3, 'left': 3, 'right': 0, 'top': 3}

# Which tab to select when the focused tab is removed.
# Type: SelectOnRemove
# Valid values:
#   - prev: Select the tab which came before the closed one (left in horizontal, above in vertical).
#   - next: Select the tab which came after the closed one (right in horizontal, below in vertical).
#   - last-used: Select the previously selected tab.
c.tabs.select_on_remove = 'next'

# When to show the tab bar.
# Type: String
# Valid values:
#   - always: Always show the tab bar.
#   - never: Always hide the tab bar.
#   - multiple: Hide the tab bar if only one tab is open.
#   - switching: Show the tab bar when switching tabs.
c.tabs.show = 'multiple'

# Format to use for the tab title. The following placeholders are
# defined:  * `{perc}`: Percentage as a string like `[10%]`. *
# `{perc_raw}`: Raw percentage, e.g. `10`. * `{current_title}`: Title of
# the current web page. * `{title_sep}`: The string `" - "` if a title
# is set, empty otherwise. * `{index}`: Index of this tab. *
# `{aligned_index}`: Index of this tab padded with spaces to have the
# same   width. * `{relative_index}`: Index of this tab relative to the
# current tab. * `{id}`: Internal tab ID of this tab. * `{scroll_pos}`:
# Page scroll position. * `{host}`: Host of the current web page. *
# `{backend}`: Either `webkit` or `webengine` * `{private}`: Indicates
# when private mode is enabled. * `{current_url}`: URL of the current
# web page. * `{protocol}`: Protocol (http/https/...) of the current web
# page. * `{audio}`: Indicator for audio/mute status.
# Type: FormatString
c.tabs.title.format = '{audio} {current_title}'

# Format to use for the tab title for pinned tabs. The same placeholders
# like for `tabs.title.format` are defined.
# Type: FormatString
c.tabs.title.format_pinned = None

# Width (in pixels) of the progress indicator (0 to disable).
# Type: Int
c.tabs.indicator.width = 0

# Padding (in pixels) for tab indicators.
# Type: Padding
c.tabs.indicator.padding = {'bottom': 2, 'left': 0, 'right': 4, 'top': 2}

# Format to use for the window title. The same placeholders like for
# `tabs.title.format` are defined.
# Type: FormatString
c.window.title_format = '{perc}{current_title}{title_sep}qutebrowser'

# Text color of the completion widget. May be a single color to use for
# all columns or a list of three colors, one for each column.
# Type: List of QtColor, or QtColor
c.colors.completion.fg = '#f8f8f2'

# Background color of the completion widget for odd rows.
# Type: QssColor
c.colors.completion.odd.bg = '#282a36'

# Background color of the completion widget for even rows.
# Type: QssColor
c.colors.completion.even.bg = '#282a36'

# Foreground color of completion widget category headers.
# Type: QtColor
c.colors.completion.category.fg = '#f8f8f2'

# Background color of the completion widget category headers.
# Type: QssColor
c.colors.completion.category.bg = '#282a36'

# Top border color of the completion widget category headers.
# Type: QssColor
c.colors.completion.category.border.top = '#282a36'

# Bottom border color of the completion widget category headers.
# Type: QssColor
c.colors.completion.category.border.bottom = '#282a36'

# Foreground color of the selected completion item.
# Type: QtColor
c.colors.completion.item.selected.fg = '#f8f8f2'

# Background color of the selected completion item.
# Type: QssColor
c.colors.completion.item.selected.bg = '#44475a'

# Top border color of the selected completion item.
# Type: QssColor
c.colors.completion.item.selected.border.top = '#44475a'

# Bottom border color of the selected completion item.
# Type: QssColor
c.colors.completion.item.selected.border.bottom = '#44475a'

# Foreground color of the matched text in the completion.
# Type: QtColor
c.colors.completion.match.fg = '#ffb86c'

# Color of the scrollbar handle in the completion view.
# Type: QssColor
c.colors.completion.scrollbar.fg = '#f8f8f2'

# Color of the scrollbar in the completion view.
# Type: QssColor
c.colors.completion.scrollbar.bg = '#282a36'

# Background color for the download bar.
# Type: QssColor
c.colors.downloads.bar.bg = '#282a36'

# Color gradient stop for download backgrounds.
# Type: QtColor
c.colors.downloads.stop.bg = '#282a36'

# Color gradient interpolation system for download backgrounds.
# Type: ColorSystem
# Valid values:
#   - rgb: Interpolate in the RGB color system.
#   - hsv: Interpolate in the HSV color system.
#   - hsl: Interpolate in the HSL color system.
#   - none: Don't show a gradient.
c.colors.downloads.system.bg = 'none'

# Foreground color for downloads with errors.
# Type: QtColor
c.colors.downloads.error.fg = '#ff5555'

# Background color for downloads with errors.
# Type: QtColor
c.colors.downloads.error.bg = '#282a36'

# Font color for hints.
# Type: QssColor
c.colors.hints.fg = '#282a36'

# Background color for hints. Note that you can use a `rgba(...)` value
# for transparency.
# Type: QssColor
c.colors.hints.bg = '#bd93f9'

# Font color for the matched part of hints.
# Type: QtColor
c.colors.hints.match.fg = '#282a36'

# Text color for the keyhint widget.
# Type: QssColor
c.colors.keyhint.fg = '#bd93f9'

# Highlight color for keys to complete the current keychain.
# Type: QssColor
c.colors.keyhint.suffix.fg = '#44475a'

# Background color of the keyhint widget.
# Type: QssColor
c.colors.keyhint.bg = '#282a36'

# Foreground color of an error message.
# Type: QssColor
c.colors.messages.error.fg = '#ff5555'

# Background color of an error message.
# Type: QssColor
c.colors.messages.error.bg = '#282a36'

# Border color of an error message.
# Type: QssColor
c.colors.messages.error.border = '#282a36'

# Foreground color of a warning message.
# Type: QssColor
c.colors.messages.warning.fg = '#ff5555'

# Background color of a warning message.
# Type: QssColor
c.colors.messages.warning.bg = '#282a36'

# Border color of a warning message.
# Type: QssColor
c.colors.messages.warning.border = '#282a36'

# Foreground color of an info message.
# Type: QssColor
c.colors.messages.info.fg = '#6272a4'

# Background color of an info message.
# Type: QssColor
c.colors.messages.info.bg = '#282a36'

# Border color of an info message.
# Type: QssColor
c.colors.messages.info.border = '#282a36'

# Foreground color for prompts.
# Type: QssColor
c.colors.prompts.fg = '#8be9fd'

# Border used around UI elements in prompts.
# Type: String
c.colors.prompts.border = '1px solid #282a36'

# Background color for prompts.
# Type: QssColor
c.colors.prompts.bg = '#282a36'

# Background color for the selected item in filename prompts.
# Type: QssColor
c.colors.prompts.selected.bg = '#44475a'

# Foreground color of the statusbar.
# Type: QssColor
c.colors.statusbar.normal.fg = '#f8f8f2'

# Background color of the statusbar.
# Type: QssColor
c.colors.statusbar.normal.bg = '#282a36'

# Foreground color of the statusbar in insert mode.
# Type: QssColor
c.colors.statusbar.insert.fg = '#ffffff'

# Background color of the statusbar in insert mode.
# Type: QssColor
c.colors.statusbar.insert.bg = '#181920'

# Foreground color of the statusbar in passthrough mode.
# Type: QssColor
c.colors.statusbar.passthrough.fg = '#ffb86c'

# Background color of the statusbar in passthrough mode.
# Type: QssColor
c.colors.statusbar.passthrough.bg = '#282a36'

# Foreground color of the statusbar in private browsing mode.
# Type: QssColor
c.colors.statusbar.private.fg = '#e0e0e0'

# Background color of the statusbar in private browsing mode.
# Type: QssColor
c.colors.statusbar.private.bg = '#282a36'

# Foreground color of the statusbar in command mode.
# Type: QssColor
c.colors.statusbar.command.fg = '#ff79c6'

# Background color of the statusbar in command mode.
# Type: QssColor
c.colors.statusbar.command.bg = '#282a36'

# Foreground color of the statusbar in private browsing + command mode.
# Type: QssColor
c.colors.statusbar.command.private.fg = '#e0e0e0'

# Background color of the statusbar in private browsing + command mode.
# Type: QssColor
c.colors.statusbar.command.private.bg = '#282a36'

# Foreground color of the statusbar in caret mode.
# Type: QssColor
c.colors.statusbar.caret.fg = '#ffb86c'

# Background color of the statusbar in caret mode.
# Type: QssColor
c.colors.statusbar.caret.bg = '#282a36'

# Foreground color of the statusbar in caret mode with a selection.
# Type: QssColor
c.colors.statusbar.caret.selection.fg = '#ffb86c'

# Background color of the statusbar in caret mode with a selection.
# Type: QssColor
c.colors.statusbar.caret.selection.bg = '#282a36'

# Background color of the progress bar.
# Type: QssColor
c.colors.statusbar.progress.bg = '#282a36'

# Default foreground color of the URL in the statusbar.
# Type: QssColor
c.colors.statusbar.url.fg = '#f8f8f2'

# Foreground color of the URL in the statusbar on error.
# Type: QssColor
c.colors.statusbar.url.error.fg = '#ff5555'

# Foreground color of the URL in the statusbar for hovered links.
# Type: QssColor
c.colors.statusbar.url.hover.fg = '#8be9fd'

# Foreground color of the URL in the statusbar on successful load
# (http).
# Type: QssColor
c.colors.statusbar.url.success.http.fg = '#50fa7b'

# Foreground color of the URL in the statusbar on successful load
# (https).
# Type: QssColor
c.colors.statusbar.url.success.https.fg = '#50fa7b'

# Foreground color of the URL in the statusbar when there's a warning.
# Type: QssColor
c.colors.statusbar.url.warn.fg = '#f1fa8c'

# Background color of the tab bar.
# Type: QssColor
c.colors.tabs.bar.bg = '#44475a'

# Color gradient start for the tab indicator.
# Type: QtColor
c.colors.tabs.indicator.start = '#ffb86c'

# Color gradient end for the tab indicator.
# Type: QtColor
c.colors.tabs.indicator.stop = '#50fa7b'

# Color for the tab indicator on errors.
# Type: QtColor
c.colors.tabs.indicator.error = '#ff5555'

# Color gradient interpolation system for the tab indicator.
# Type: ColorSystem
# Valid values:
#   - rgb: Interpolate in the RGB color system.
#   - hsv: Interpolate in the HSV color system.
#   - hsl: Interpolate in the HSL color system.
#   - none: Don't show a gradient.
c.colors.tabs.indicator.system = 'none'

# Foreground color of unselected odd tabs.
# Type: QtColor
c.colors.tabs.odd.fg = '#f8f8f2'

# Background color of unselected odd tabs.
# Type: QtColor
c.colors.tabs.odd.bg = '#44475a'

# Foreground color of unselected even tabs.
# Type: QtColor
c.colors.tabs.even.fg = '#f8f8f2'

# Background color of unselected even tabs.
# Type: QtColor
c.colors.tabs.even.bg = '#44475a'

# Foreground color of selected odd tabs.
# Type: QtColor
c.colors.tabs.selected.odd.fg = '#282a36'

# Background color of selected odd tabs.
# Type: QtColor
c.colors.tabs.selected.odd.bg = '#bd93f9'

# Foreground color of selected even tabs.
# Type: QtColor
c.colors.tabs.selected.even.fg = '#282a36'

# Background color of selected even tabs.
# Type: QtColor
c.colors.tabs.selected.even.bg = '#bd93f9'

# Foreground color of pinned unselected odd tabs.
# Type: QtColor
c.colors.tabs.pinned.odd.fg = '#282a36'

# Background color of pinned unselected odd tabs.
# Type: QtColor
c.colors.tabs.pinned.odd.bg = '#ff79c6'

# Foreground color of pinned unselected even tabs.
# Type: QtColor
c.colors.tabs.pinned.even.fg = '#282a36'

# Background color of pinned unselected even tabs.
# Type: QtColor
c.colors.tabs.pinned.even.bg = '#ff79c6'

# Foreground color of pinned selected odd tabs.
# Type: QtColor
c.colors.tabs.pinned.selected.odd.fg = '#282a36'

# Background color of pinned selected odd tabs.
# Type: QtColor
c.colors.tabs.pinned.selected.odd.bg = '#bd93f9'

# Foreground color of pinned selected even tabs.
# Type: QtColor
c.colors.tabs.pinned.selected.even.fg = '#282a36'

# Background color of pinned selected even tabs.
# Type: QtColor
c.colors.tabs.pinned.selected.even.bg = '#bd93f9'

# Default font families to use. Whenever "default_family" is used in a
# font setting, it's replaced with the fonts listed here. If set to an
# empty value, a system-specific monospace default is used.
# Type: List of Font, or Font
c.fonts.default_family = 'Bad Comic'

# Default font size to use. Whenever "default_size" is used in a font
# setting, it's replaced with the size listed here. Valid values are
# either a float value with a "pt" suffix, or an integer value with a
# "px" suffix.
# Type: String
c.fonts.default_size = '18pt'

# Bindings for normal mode
config.bind('E', 'tab-prev')
config.unbind('H')
config.bind('I', 'tab-next')
config.unbind('J')
config.unbind('K')
config.unbind('L')
config.bind('T', 'set-cmd-text --space :open --tab')
config.bind('a', 'repeat-command')
config.bind('e', 'scroll down')
config.bind('f', 'hint')
config.unbind('h')
config.bind('i', 'scroll up')
config.unbind('j')
config.unbind('k')
config.unbind('l')
config.bind('n', 'back')
config.bind('o', 'forward')
config.bind('s', 'spawn --userscript qute-bitwarden')
config.bind('t', 'set-cmd-text --space :open')
