#!/bin/bash

filedate=$(date +"%m%d%y")

# build latex file
#latexmk -pdf -c -interaction=nonstopmode
pdflatex resume.tex

# push to git repo
git add -A
git commit -m "Autobuild on $(date)"
git tag $filedate
git push origin master
git push --tags origin

# make named resume file
mkdir -p resumeOnly
rm -f resumeOnly/*
resumefilename="DhanveeIvaturiResume$filedate.pdf"
cp resume.pdf resumeOnly/$resumefilename
cd resumeOnly

git init
git remote add resume git@github.com:Ludikrous/Resume.git
git add $resumefilename
git commit -m "Autobuild on $(date)"
git push -f --set-upstream resume master

rm -rf resumeOnly
