#!/usr/bin/env bash

defaults write com.apple.universalaccess com.apple.custommenu.apps -array "com.apple.Music" "com.bitwarden.desktop" "com.apple.mail" "com.tinyspeck.slackmacgap" "com.apple.Preview" "com.bitwarden.desktop"

defaults write com.apple.Music NSUserKeyEquivalents '{
  "Go to Current Song"="@\$j";
  "Show Album in Library"="\Uf706";
  "Show in Apple Music"="\Uf707";
  "Show Lyrics"="@~u";
  "Hide Lyrics"="@~u";
  "Show Playing Next"="@y";
  "Hide Playing Next"="@y";
  "Love"="@l";
  "Loved"="@l";
  "Burn Playlist to Disc..."="\U200b";
  "\033Controls\033Shuffle\033On"="@s";
  "\033Controls\033Shuffle\033Off"="@$s";
  "\033Controls\033Repeat\033One"="@r";
  "\033Controls\033Repeat\033Off"="@$r";
  "\033View\033Sort By\033Title"="@1";
  "\033View\033Sort By\033Genre"="@2";
  "\033View\033Sort By\033Year"="@3";
  "\033View\033Sort By\033Artist"="@4";
  "\033View\033Sort By\033Album"="@5";
  "\033View\033Sort By\033Time"="@6";
  "\033View\033Sort By\033Playlist Order"="@0";
  "\033Window\033Music"="@~0";
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

defaults write com.apple.Preview NSUserKeyEquivalents '{
  "Adjust Size..."="~@i";
  "Export..."="\UF70F";
}'

defaults write com.bitwarden.desktop NSUserKeyEquivalents '{
  "Sync vault"="@r";
  "Export vault"="@\U000A";
}'