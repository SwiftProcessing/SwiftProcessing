#! /bin/bash
find Sources/ -name '*.swift' -exec cat {} \; > SwiftProcessing.swift
find Playgrounds/*.playground/Sources -type d -exec cp SwiftProcessing.swift {} \;
zip -r SwiftProcessingPlaygrounds.zip Playgrounds
mv  SwiftProcessingPlaygrounds.zip Website/public
rm SwiftProcessing.swift
find Playgrounds/*.playground/Sources -name SwiftProcessing.swift -exec rm {} \;
cd Website
firebase deploy --only hosting
rm ./public/SwiftProcessingPlaygrounds.zip
