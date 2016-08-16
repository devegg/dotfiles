#!/bin/sh

# Inspired by https://github.com/mathiasbynens/dotfiles

username="Brian Boyd"

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.osx` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

############################################################################
# General UI/UX                                                            #
############################################################################

# Set computer name (as done via System Preferences → Sharing)
sudo scutil --set ComputerName "$username"
sudo scutil --set HostName "$username"

# Disable the sound effects on boot
sudo nvram SystemAudioVolume=" "

# Reveal IP address, hostname, OS version, etc. when clicking the clock
# in the login window
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

############################################################################
# Screen                                                                   #
############################################################################

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Save screenshots to ~/Screenshots
mkdir -p "${HOME}/Screenshots"
defaults write com.apple.screencapture location -string "${HOME}/Screenshots"

# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type -string "png"

############################################################################
# Finder                                                                   #
############################################################################

# Finder: disable window and Get Info animations
defaults write com.apple.finder DisableAllAnimations -bool true

# General: Enable icons for hard drives, servers, and removable media on the desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Finder: show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Finder: allow text selection in Quick Look
defaults write com.apple.finder QLEnableTextSelection -bool true

# Finder: display full path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# General: enable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool true

# Use columns view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `Nlsv`, `Flwv`
defaults write com.apple.finder FXPreferredViewStyle -string "clmv"

# General: enable the warning before emptying the Trash
defaults write com.apple.finder WarnOnEmptyTrash -bool true

# Show the ~/Library folder
chflags nohidden ~/Library

############################################################################
# Dock, Dashboard, and hot corners                                         #
############################################################################

# Dock: enable highlight hover effect for the grid view of a stack
defaults write com.apple.dock mouse-over-hilite-stack -bool true

# Set the icon size of Dock items to 48 pixels
defaults write com.apple.dock tilesize -int 48

# Dock: minimize windows into their application's icon
defaults write com.apple.dock minimize-to-application -bool true

# Dock: automatically hide and show
defaults write com.apple.dock autohide -bool true

############################################################################
# Terminal & iTerm 2                                                       #
############################################################################

# Only use UTF-8 in Terminal.app
defaults write com.apple.terminal StringEncodings -array 4

# iTerm: enable prompt when quitting iTerm
defaults write com.googlecode.iterm2 PromptOnQuit -bool true

############################################################################
# Kill affected applications                                               #
############################################################################

for app in "Dock" "Finder" "SystemUIServer" "Terminal" "iCal"; do
    killall "${app}" > /dev/null 2>&1
done

echo "Done. Note that some of these changes require a logout/restart to take effect."
