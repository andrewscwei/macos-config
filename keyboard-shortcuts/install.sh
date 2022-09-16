#!/usr/bin/env bash

defaults write com.apple.universalaccess com.apple.custommenu.apps -array "com.apple.Music" "com.bitwarden.desktop" "com.apple.mail" "com.tinyspeck.slackmacgap"

defaults write com.apple.Music NSUserKeyEquivalents '{
  "Go to Current Song"="@\$j";
  "Show Album in Library"="\Uf706";
  "Show in Apple Music"="\Uf707";
  "Love"="@l";
  "Loved"="@l";
}'

defaults write com.bitwarden.desktop NSUserKeyEquivalents '{
  "Sync Vault"="@r";
}'

defaults write com.apple.mail NSUserKeyEquivalents '{
  "Message Viewer"="\U200b";
  "Hide Sidebar"="@0";
  "Show Sidebar"="@0";
}'

defaults write com.tinyspeck.slackmacgap NSUserKeyEquivalents '{
  "Actual Size"="\U200b";
  "Hide Sidebar"="@0";
  "Show Sidebar"="@0";
}'
