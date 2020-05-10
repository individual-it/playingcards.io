#!/bin/bash

rootURL="https://my-domain-where-the-cards-are-stored/"
cardDestFolder="."
csvFileName="import.csv"

while [[ $# -gt 0 ]]; do
  key="$1"
  case ${key} in
  -dest)
    cardDestFolder="$2"
    shift
    ;;
  -root)
    rootURL="$2"
    shift
    ;;
  *)
    # A "random" parameter is presumed to be the destination
    # Typically that will be specified at the end, or as the only
    # parameter.
    cardDestFolder="$1"
    ;;
  esac
  shift
done

echo "image;" >$cardDestFolder/$csvFileName

#create normal cards
#$1 color
#$2 number
#$3 points
function create_card() {
  convert \
    -size 412x60 \
    xc:white \
    -stroke black \
    -font Bookman-DemiItalic \
    -pointsize 70 \
    -fill $1 \
    -gravity NorthWest \
    -draw "text 0,0 '$2'" \
    -pointsize 30 \
    -draw "text 150,0 '$1'" \
    $cardDestFolder/$2-$1-tmp.png

  if [ "$3" != "" ]; then
    convert $cardDestFolder/$2-$1-tmp.png \
      -fill $1 \
      -stroke black \
      -draw "rectangle 148,28 192,55" \
      -fill white \
      -gravity NorthWest \
      -font Bookman-DemiItalic \
      -pointsize 30 \
      -draw "text 150,30 '$3'" \
      $cardDestFolder/$2-$1-tmp.png
  fi
  convert \
    -size 412x640 \
    xc:white \
    -draw "image over 40,40 0,0 '${cardDestFolder}/${2}-${1}-tmp.png'" \
    -stroke black \
    -font Bookman-Demi \
    -fill $1 \
    -gravity center \
    -pointsize 150 \
    -draw "text 0,0 '$2'" \
    -fill none \
    -draw "polyline 100,200 100,440 312,440 312,200 100,200" \
    -gravity SouthEast \
    -draw "rotate 180 image over 380,20 0,0 '${cardDestFolder}/${2}-${1}-tmp.png'" \
    $cardDestFolder/$2-$1.png

  rm $cardDestFolder/$2-$1-tmp.png
  echo $2-$1.png
}

colors=(
  RED
  BLACK
  YELLOW
  GREEN
)
counter=1
while [ $counter -le 14 ]; do
  for color in "${colors[@]}"; do
    case "$counter" in
    "10" | "14")
      points=10
      ;;
    "1")
      points=15
      ;;
    *)
      points=""
      ;;
    esac
    fileName=$(create_card $color $counter $points)
    echo $rootURL$fileName";" >>$cardDestFolder/$csvFileName
  done
  ((counter++))
done

##create the rook card
convert \
  -size 165x40 \
  xc:white \
  -stroke black \
  -font Bookman-Demi \
  -pointsize 50 \
  -gravity NorthWest \
  -draw "fill green text 0,0 'R'" \
  -draw "fill yellow text 40,0 'O'" \
  -draw "fill red text 80,0 'O'" \
  -draw "fill black text 120,0 'K'" \
  $cardDestFolder/ROOK-tmp.png

convert \
  -size 412x640 \
  xc:white \
  -stroke black \
  -strokewidth 10 \
  -font Bookman-Demi \
  -fill blue \
  -gravity center \
  -pointsize 150 \
  -draw "text 0,0 '20'" \
  -fill none \
  -draw "circle 206,320 70,320" \
  -draw "image over 0,-165 0,0 '${cardDestFolder}/ROOK-tmp.png'" \
  -draw "rotate 180 image over -165,-206 0,0 '${cardDestFolder}/ROOK-tmp.png'" \
  $cardDestFolder/ROOK.png

rm $cardDestFolder/ROOK-tmp.png
echo $rootURL"ROOK.png;" >>$cardDestFolder/$csvFileName
