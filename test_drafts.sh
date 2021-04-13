#!/bin/sh

# Hugo binary should be present in the folder directly above this one 
# Run hugo with theme in ../hugo-theme
../hugo server --themesDir ../ --theme hugo-theme --verbose --noHTTPCache --buildDrafts
