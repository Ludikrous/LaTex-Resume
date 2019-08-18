#!/bin/bash

filedate=$(date +"%m%d%y")

# build latex file
latexmk -pdf -c -interaction=nonstopmode

# push to git repo
git add -a
git commit -m "Autobuild on $(date)"
git tag -a $filedate
git push origin

# make named resume file
mkdir -p resumeOnly
resumefilename="DhanveeIvaturiResume$filedate.pdf"
cp resume.pdf resumeOnly/$resumefilename
cd resumeOnly

git init
git remote add resume git@github.com:Ludikrous/Resume.git
git add $resumefilename
git commit -m "Autobuild on $(date)"
git push resume
