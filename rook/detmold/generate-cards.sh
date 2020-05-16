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

echo "label;image;" >$cardDestFolder/$csvFileName

#create normal cards
#$1 color
#$2 number
#$3 points
function create_card() {
  convert \
    -size 412x120 \
    xc:white \
    -stroke black \
    -font Bookman-DemiItalic \
    -pointsize 100 \
    -fill $1 \
    -gravity NorthWest \
    -draw "text 0,0 '$2'" \
    -pointsize 50 \
    -draw "text 135,0 '$1'" \
    $cardDestFolder/$2-$1-tmp.png

  if [ "$3" != "" ]; then
    rectangleXStart=133
    if [ "$3" -lt 10 ]; then
      ((rectangleXEnd=rectangleXStart+60))
    else
      ((rectangleXEnd=rectangleXStart+100))
    fi
    convert $cardDestFolder/$2-$1-tmp.png \
      -fill $1 \
      -stroke black \
      -draw "rectangle ${rectangleXStart},48 ${rectangleXEnd},115" \
      -fill white \
      -gravity NorthWest \
      -font Bookman-DemiItalic \
      -pointsize 70 \
      -draw "text 135,50 '$3'" \
      $cardDestFolder/$2-$1-tmp.png
  fi
  convert \
    -size 412x640 \
    xc:white \
    -draw "image over 15,15 0,0 '${cardDestFolder}/${2}-${1}-tmp.png'" \
    -stroke black \
    -font Bookman-Demi \
    -fill $1 \
    -gravity center \
    -pointsize 150 \
    -draw "text 0,0 '$2'" \
    -fill none \
    -draw "polyline 100,200 100,440 312,440 312,200 100,200" \
    -gravity SouthEast \
    -draw "rotate 180 image over 405,85 0,0 '${cardDestFolder}/${2}-${1}-tmp.png'" \
    $cardDestFolder/$2-$1.png

  rm $cardDestFolder/$2-$1-tmp.png
  echo $2-$1
}

colors=(
  RED
  BLACK
  YELLOW
  GREEN
)
#counter=2
#while [ $counter -le 15 ]; do
#  for color in "${colors[@]}"; do
#    case "$counter" in
#    "10" | "14")
#      points=10
#      ;;
#    "15")
#      points=15
#      ;;
#    "5")
#      points=5
#      ;;
#    *)
#      points=""
#      ;;
#    esac
#    label=$(create_card $color $counter $points)
#    echo $label";"$rootURL$label.png";" >>$cardDestFolder/$csvFileName
#  done
#  ((counter++))
#done

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
  -draw "ellipse 206,320 120,170 0,360" \
  -draw "image over 0,-200 0,0 '${cardDestFolder}/ROOK-tmp.png'" \
  -draw "rotate 180 image over -165,-241 0,0 '${cardDestFolder}/ROOK-tmp.png'" \
  $cardDestFolder/ROOK.png

rm $cardDestFolder/ROOK-tmp.png
echo "ROOK;"$rootURL"ROOK.png;" >>$cardDestFolder/$csvFileName
