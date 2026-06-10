-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

hl.env("XCURSOR_SIZE", "22")
hl.env("HYPRCURSOR_SIZE", "22")
hl.env("HYPRCURSOR_THEME", "XCursor-Pro-Hyprcursor-Dark")
-- hl.env("GTK_THEME", "Adwaita:dark")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")

-- Disable Pulse on Wine (fallback to alsa)
hl.env("WINEDLLOVERRIDES", "winepulse.drv=")
