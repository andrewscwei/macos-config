#!/usr/bin/env bash

defaults write com.apple.universalaccess com.apple.custommenu.apps -array "com.apple.Music" "com.bitwarden.desktop"
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
