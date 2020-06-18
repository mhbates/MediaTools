@ECHO OFF

rem This loops through all files of type fileType in the folder it's in and 
rem sets the new default audio track to the one called out 
rem in the newDefaultAudioTrack variable

rem Requires mkvpropedit.exe in the same folder, just to keep things simple

rem File type
SET fileType=mkv

rem Number of audio tracks in the files
SET /A numAudioTracks=3

rem The track that we want to set as the new default
SET /A newDefaultAudioTrack=2

FOR %%G IN ("*.%fileType%") DO (

	echo %%G

	rem The "/L" denotes that this for loop will run in a numerical fashion, as opposed to a list
	FOR /L %%J IN (1,1,%numAudioTracks%) DO (
		
		rem If this iteration is the audio track we want as the new default, set accordingly
		IF %%J==%newDefaultAudioTrack% (
			mkvpropedit.exe "%%G" --edit track:a%%J --set flag-default=1
		)
		IF NOT %%J==%newDefaultAudioTrack% (
			mkvpropedit.exe "%%G" --edit track:a%%J --set flag-default=0
		)
	)
)
PAUSE