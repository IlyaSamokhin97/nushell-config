# config.nu
#
# Installed by:
# version = "0.112.1"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# Nushell sets "sensible defaults" for most configuration settings, 
# so your `config.nu` only needs to override these defaults if desired.
#
# You can open this file in your default editor using:
#     config nu
#
# You can also pretty-print and page through the documentation for configuration
# options using:
#     config nu --doc | nu-highlight | less -R

# theme
source ~/nu_scripts/themes/nu-themes/bright.nu

# prompt
source ~/nu_scripts/modules/prompt/oh-my-v2.nu
$env.PROMPT_COMMAND = { (get_prompt 24bit).left_prompt }
$env.PROMPT_COMMAND_RIGHT = { (get_prompt 24bit).right_prompt }
$env.PROMPT_INDICATOR = " "

# env
$env.PATH ++= ["~/.ghcup/bin"]
$env.LOCALSEND = (
	if $nu.os-info.name == "windows" {
		("D:/Downloads/LocalSend/" | path expand)
	} else {
		("~/Downloads/LocalSend/" | path expand)
	}
)
$env.TRACKEDGG_EXPORT = ([$env.LOCALSEND "tracked_export_2026-07-12.zip"] | path join)
$env.TRACKEDGG_VEGALITE = (
	if $nu.os-info.name == "windows" {
		"D:/My/Documents/tracked-gg-graph.html"
	} else {
		("~/Documents/tracked-gg-graph.html" | path expand)
	}
)

# env.config
$env.config.use_kitty_protocol = true

# aliases
def --env y [...args] {
	let tmp = (mktemp -t "yazi-cwd.XXXXXX")
	^yazi ...$args --cwd-file $tmp
	let cwd = (open $tmp)
	if $cwd != $env.PWD and ($cwd | path exists) {
		cd $cwd
	}
	rm -fp $tmp
}
