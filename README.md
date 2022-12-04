# `fs-protokoll.cls`
This is a $\LaTeX$ class used to write minutes for meetings of the different panels and committees of the mathematics student council of the University of Bonn.

This is a new and improved version, based on my previous works. Besides multiple improvements, it now fully supports minutes written in German and English (by using the class arguments `ngerman` or `english`).

### document class arguments
At the moment the following document class arguments are supported:

* `draft`: *flag*, add a draft watermark (*complementary flag*: `final`)
* `gremium`: *string*, name of the panel for which the minutes are written (supported: "FSR", "FSV"). If neither "FSR" nor "FSV" are specified, one has to manually set the panel's name (in genitive) and its article via `\gremiums` resp. `\gremiumprefix`
* `wideoverview`: *flag*, extend the overview on the first page further than the main text width
* `raggedtitle`: *flag*, formats the title as `\raggedright` instead of the justification
* `TOPindent`: *length*, the length of indentation of the agenda item headings (*default: -1.25cm*)
* `logofile`: *string*, file from which the logo is loaded (*default: fs-logo-transparent.png*)
* `hyphens`: *flag*, allows linebreaks on hyphens in hyperlinks

### Further settings
The following settings can be changed by writing `\SETTINGNAMEtrue` or `\SETTINGNAMEfalse` in the preamble, e.g. `\konstitrue` to enable the `konsti` setting.

* `konsti` (default: `false`): enables predefined settings for a constituent session of a panel
* `useordentliche` (default: `false`): changes the title style to show the session number and whether its a regular or special session (German: "ordentlich/außerordentlich"). Then, the session number has to be specified via `\sessionnr`.
* `ordentlichesitzung` (default: `true`): flags the session as a regular one. If false, a special session is assumed.
* `oeffentlichesprotokoll` (default: `true`): TODO
* `leitung` (default: `true`): If disabled, no head of the meeting or keeper of the minutes are displayed
* `unterschrift` (default: `true`): If disabled, no signature lines are displayed on the last page of the minutes
* `fusszeile` (default: `true`): If disabled, the text in the footer is removed.
* `internet` (default: `true`): If disabled, the slogan from the sidebar that all minutes can be found on the website of the Fachschaft is removed
* `terminliste` (default: `true`): If enabled, a table with upcoming dates (which has to be specified via `\termtable`) is displayed on the first page
* `fsrvorstandunterschrift` (default: `true`): If enabled, signature lines for the old and new board of the FSR are shown in case of a constituent meeting.
* `mitgliederliste` (default: `true`): shows a list of attending panel members, separately from the other attendess. Should not be set by hand.

### defined commands
* `\leiter`: Specify the head of the meeting. Accepts an optional argument to specifiy how it is called in the minutes.
* `\protokollant`: Specify the keeper of the minutes. Accepts an optional argument to specifiy how the it is called in the minutes.
* `\mitglieder`: List all attending members of the panels.  Accepts an optional argument to specifiy how it is called in the minutes.
* `\fehlende`: List all missing members of the panel with no valid excuse. Accepts an optional argument to specifiy how it is called in the minutes.
* `\entfehlende`: List all missing members of the panel with valid excuse. Accepts an optional argument to specifiy how it is called in the minutes.
* `\anwesende`: List all other attendees. Accepts an optional argument to specifiy how it is called in the minutes.
* `\titel`: 
* `\date`: Specify the date of the meeting.
* `\beginn`: Specify the start of the meeting
* `\Ende`: Specify the end of the meeting
* `\gremiums`: 
* `\gremiumprefix`: 
* `\sitzungsnr`: 
* `\TOP`: 
* `\sitzungsbreak`:
* `\termtable`:
* `\termine`:
* `\oldfsr`:
* `\newfsr`:
* `\anhang`:

### defined environments
* `nominationtable`: 
* `antragstable`: 
* `nichtoeff`:
