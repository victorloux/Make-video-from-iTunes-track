(*
	Save iTunes songs to a videos for publishing on YouTube
	by using the song's artwork as a static image.
	Installation : copy file to ~/Library/iTunes/Scripts

	2014 Victor L. <github.com/deadpx>
	Licensed under the WTFPL v2 <http://www.wtfpl.net/txt/copying/>
*)

(*
	Set the string below to your full FFMPEG path.
	If you have ffmpegX installed it should be
		"/Applications/ffmpegx.app/Contents/Resources/ffmpeg"
	
	Otherwise open a Terminal and type `which ffmpeg`.

	If it returns nothing you might not have it installed
	or it's not in your PATH; just `brew install ffmpeg` or something.
*)
property ffmpeg_location  : "/usr/local/bin/ffmpeg"



------✂︎------------------------------------------------ 

try
	do shell script "stat " & (quoted form of ffmpeg_location)
on error number errNum
	display alert "Your ffmpeg path is not set properly. Please edit the script (line 20)."
	return
end try

property videoDestination : (choose folder with prompt "Destination of your videos")

tell application "iTunes"
	if selection is {} then
		beep
		display alert "No tracks selected"
		return
	end if

	set mySelection to selection

end tell


repeat with thisTrack in mySelection
	set fileLocation to location of thisTrack
	set fileLocation to POSIX path of fileLocation
	set fileName to artist of thisTrack & " - " & name of thisTrack

	-- Artwork

	if number of artwork of thisTrack ≥ 1

		set fileArtwork to artwork 1 of thisTrack

		if fileArtwork's format is «class PNG » then
			set extension to "png"
		else
			set extension to "jpg"
		end if
		
		set fileArtworkLocation to (((path to temporary items from user domain) as text) & fileName & "." & extension)
		set fileOutputLocation  to ((videoDestination as text) & fileName & ".mp4")
		set fileArtworkData to fileArtwork's raw data

		-- write the artwork's raw data to a temp file
		set fp to open for access fileArtworkLocation with write permission
		set eof fp to 0
		write fileArtworkData to fp
		close access fp

		-- notices & actual encoding
		display notification with title "Starting encoding…" subtitle fileName
		delay 0.5

		do shell script ffmpeg_location & " -loop 1 -i " & quoted form of POSIX path of fileArtworkLocation & " -i " & quoted form of fileLocation & " -c:v libx264 -c:a aac -strict experimental -b:a 192k -shortest " & quoted form of POSIX path of fileOutputLocation

		display notification with title "Video encoded" subtitle (fileName & " was turned to a video.")
		delay 0.5
	else
		beep
		display alert "No artwork available for the track " & fileName
	end if
end repeat