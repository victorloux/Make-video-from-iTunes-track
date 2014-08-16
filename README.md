# Make videos from selected iTunes track #


This is a script for iTunes (**Mac only**) that will convert the selected tracks to music-only videos for posting on YouTube, using the file's artwork as a static image.

The `ffmpeg` utility is **required**. You may get the binaries from [here](http://www.evermeet.cx/ffmpeg/), use the one included in [ffmpegX](http://www.ffmpegx.com/) or compile it from source using `brew ffmpeg` or `port install ffmpeg +gpl +lame +x264 +xvid` (assuming you have brew or port installed).


## Installation ##

Copy the script to `~/Library/iTunes/Scripts`. The ~/Library folder is hidden by default, you need to access it using `⌘G` in the Finder. If the Scripts folder does not exist, create it.

Then you need to edit the script (double-click it to open it with AppleScript Editor, but any other text editor will do) and check out the instructions before line 20. There you'll need to set the *full path* to the `ffmpeg` utility (not just an alias). If it is properly installed you should be able to grab that info by typing `which ffmpeg` into a terminal. If you're using ffmpegX check out the comments above line 20.

## Usage ##

Select tracks in iTunes, go to the Script menu (it's the paper icon in the menu bar) and choose *Make videos from selected tracks*. If the ffmpeg path is set correctly, you'll be asked for a destination folder, and processing will start. You'll get system-wide notifications to let you know when the conversion is complete.

## Issues ##

* You need at least OS X 10.8 for this to work by default, if you're under Lion or Snow Leopard you can edit out the `display notification …` in the script to make it work.
* iTunes may hang during the conversion, I need to address this (it should be a separate process)
* Sometimes you may get a “no artwork on this track” error when the album does have an artwork — just ensure the artwork is set **on the track** and not just on the album (usually happens when the artwork was set by the iTunes Store and not added manually)

## License ##

This is released under the WTFPL license (see [COPYING](COPYING)). No warranty is given whatsoever, backup your files before using this blah blah blah.
