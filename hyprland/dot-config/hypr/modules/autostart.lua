-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
hl.on("hyprland.start", function ()
  hl.exec_cmd("qs -c noctalia-shell")
  hl.exec_cmd("hyprpaper")
  hl.exec_cmd("hypridle")
  hl.exec_cmd("keepassxc")
  hl.exec_cmd("nextcloud")
  hl.exec_cmd("yubico-authenticator")
  hl.exec_cmd("/home/cedric/.local/bin/sunshine-start.sh")
end)
