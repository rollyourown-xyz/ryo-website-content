#!/bin/sh

# Hugo binary should be present in the folder directly above this one 
# Run hugo with theme in ../hugo-theme
../hugo server --themesDir ../ --theme hugo-theme --verbose --noHTTPCache --buildDrafts


# To export the site to the filesystem, run this script, cd to the directory where the site
# should be exported and then run the following command:
# wget --recursive --convert-links --html-extension --restrict-file-names=windows --page-requisites --no-parent --domains localhost localhost:1313
