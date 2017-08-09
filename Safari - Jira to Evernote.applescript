
# ______________________________
# Function to find & replace text

on findAndReplaceInText(theText, theSearchString, theReplacementString)
	set AppleScript's text item delimiters to theSearchString
	set theTextItems to every text item of theText
	set AppleScript's text item delimiters to theReplacementString
	set theText to theTextItems as string
	set AppleScript's text item delimiters to ""
	return theText
end findAndReplaceInText

# ______________________________
# Function to search Evernote

on searchAndActivateEvernote(theText)
	tell application "Evernote"
		set query string of window 1 to theText
		activate
	end tell
end searchAndActivateEvernote

# ______________________________
# Main Flow

-- Get Jira issue number from Safari

tell application "Safari"
	set sName to name of front document
end tell

set sName to findAndReplaceInText(sName, " - Eczacıbaşı Tüketim Ürünleri Grubu JIRA", "")
set sName to findAndReplaceInText(sName, "]", " -")
set sName to findAndReplaceInText(sName, "[", "")

-- If note exists in Evernote, locate it

tell application "Evernote"
	set oNotes to find notes "intitle:\"" & sName & "\""
end tell

if length of oNotes > 0 then
	searchAndActivateEvernote(sName)
	return
end if

-- Create & locate note in Evernote

tell application "Evernote"
	
	set sTempContent to "
	<br/><br/><hr/>
	<b>Hazırlık</b><br/>
	<br/>
	<en-todo/>Jira'da durumu ilerlet<br/>
	<br/><hr/>
	<b>Geliştirme</b><br/>
	<br/>
	<en-todo/>İncele<br/>
	<en-todo/>İş listesi çıkar<br/>
	<br/><hr/>
	<b>Test</b><br/>
	<br/>
	<en-todo/>EPC<br/>
	<en-todo/>Task release<br/>
	<en-todo/>Text<br/>
	<br/><hr/>
	<b>İlerleme</b><br/>
	<br/>
	<en-todo/>Jira'yı ilerletip not yaz<br/>
	<br/><hr/>
	<b>Kapanış</b><br/>
	<br/>
	<en-todo/>Son saat girişini tamamla<br/>
	<en-todo/>Evernote maddesini sil<br/>
	"
	
	set oNewNote to create note notebook "Active" tags "#ecz" title sName with enml sTempContent
end tell

searchAndActivateEvernote(sName)