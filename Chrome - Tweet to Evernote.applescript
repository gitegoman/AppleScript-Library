	tell application "Google Chrome"
		set sName to title of active tab of front window
		set sURL to URL of active tab of front window
	end tell
	
	tell application "Evernote"
		set sText to sName & " " & sURL
		create note notebook "Active" tags "#tweet" title sName with text sText
		set query string of window 1 to sName
		
		activate
	end tell