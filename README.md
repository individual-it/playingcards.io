#card sets for playingcards.io

This repo contains sets of cards for http://playingcards.io and scripts to create them.
(So far only [ROOK](https://en.wikipedia.org/wiki/Rook_(card_game)))

##Use pre-created deck
![HOWTO Video](https://raw.githubusercontent.com/individual-it/playingcards.io/master/howto.gif)
1. Download the CVS file to your computer e.g. [ROOK](https://raw.githubusercontent.com/individual-it/playingcards.io/master/rook/cards/import.csv)
2. Go to [playingcards.io](http://playingcards.io/)
3. Click on "Other/Custom"
4. Start the Game and enter the room
5. Click on "RECALL & SHUFFLE"
6. Edit the Table
7. Edit the existing Deck and select the "Card Data" tab
8. Scroll down and "REMOVE EVERYTHING"
9. Click on "IMPORT CSV" and select the downloaded CSV file from 1.
10. Click on "ALL+1" (you can also remove some cards, e.g. if you play with 4 people only)
12. If you like adjust the rest of the table,
e.g. you can create a new card-holder for the nest, add counters for the points, pins for who is leading the game or partner etc.

You are ready to go!

##Modify the deck
1. clone or download the whole repo
2. run `generate-cards.sh`. Parameters:
   1. `-dest /folder/on/your/computer` - where to save the deck
   2. `-root https://some-url-in-the-cloud/` - folder in the cloud where your images will be accessible, the script will add the image name to it
3. read about [imagemagic](https://imagemagick.org)
4. adjust the script all you like
5. rerun `generate-cards.sh`
6. check the result
7. upload the images to the cloud storage, you have set with `-root`
9. follow "Use pre-created deck" to import the deck to [playingcards.io](http://playingcards.io/)

##Ideas/Issues
please open an [issue](https://github.com/individual-it/playingcards.io/issues)

##Create more decks
Do you want to create more different decks? E.g. I know that people play ROOK in a lot of different variants. Please make a script and submit a [pull-request](https://help.github.com/en/github/collaborating-with-issues-and-pull-requests/creating-a-pull-request).
Please make sure the game idea, and the design is in teh public domain. 
