# 1. Install NeoVim and iTerm2 if you haven’t already.
# 2. Open Automator and create a new Application.
# 3. Add a Run AppleScript action and paste in the code below. If iTerm is not running 
#    it will create a new window. It will then create a new tmux window with vim loaded
# 4. Save the Automator document as an Application in /Applications.
# 5. If you wish, you can change the application’s icon.
#     * Download neovim-mark.png from the NeoVim website repository.
#     * Open this image in Preview and copy it to the clipboard.
#     * Right-click your NeoVim application file and click Get Info.
#     * Click on the icon at the top of the info window and paste the image you copied earlier.
# 6. Open /Applications and drag your new application t the Dock if you wish.

on run {input, parameters}
	set filepaths to ""
	if input is not {} then
		repeat with currentFile in input
			set filepaths to filepaths & quoted form of POSIX path of currentFile & " "
		end repeat
	end if
	
	if application "iTerm" is not running then
		tell application "iTerm" to activate
		delay 3
	end if
	
	do shell script "cd $HOME && /bin/zsh -c \"source ~/.zshrc && /usr/local/bin/tmux new-window /usr/local/bin/nvim " & filepaths & "\""
end run
