void setup() {
    // tests();
    createCards();
    shuffleCards(cards);
    // this makes a window of width 901px x height 1001px
    size(901, 1001);
    background(WHITE);
    smooth();
    deckCards();

    possibleSets = checkPossibleSets(deckededCardIndexes);
    if(possibleSets < 1){
        endGame();
        return;
    }

    drawRasterLines();
    drawCards(deckCards);
    cardsLeft = countCardsLeft(cards);
    drawRealtimeInfo();
}

void draw() {
    
}

void mousePressed() {
    checkClickedCard(mouseX, mouseY);
}

void checkClickedCard(int x, int y) {
    byte amountOfcoordinates = (byte) CARDCOORDINATES.length;

    for (byte i = 0; i < amountOfcoordinates; i++) {
        int[] card = CARDCOORDINATES[i];
        // Check if the mouse is within the x and y range of the card
        if (
            x >= card[0] && x <= card[2] &&
            y >= card[1] && y <= card[3]
        ) {
                
            // Print the index of the clicked card
            // println("Card " + (i + 1) + " was clicked.");
            // flip the boolean
            selectedCards[i] = !selectedCards[i];
            drawSelectedCard(i, selectedCards[i]);
            
            byte count = 0;

            byte selectedCardsLength = (byte) selectedCards.length;
            byte[] cardIndexes = new byte[3];
            for (byte j = 0; j < selectedCardsLength; j++) {
                if(selectedCards[j]){
                    cardIndexes[count] = j;
                    count++;
                }
            }

            if (count >= 3) {
                amountOfGuesses++;

                String[][] pickedCards = {
                    deckCards[cardIndexes[0]],
                    deckCards[cardIndexes[1]],
                    deckCards[cardIndexes[2]],
                };

                boolean result = checkSelection(pickedCards);
                
                if(result){
                    if (amountOfGuesses % 2 == 0) {
                        scorePlayer2++;
                    } else {
                        scorePlayer1++;
                    }
                }

                for (byte j = 0; j < cardIndexes.length; ++j) {
                    deckCards[cardIndexes[j]][0] = null;
                    deckCards[cardIndexes[j]][1] = null;
                    deckCards[cardIndexes[j]][2] = null;

                    int[] drawSquare = SQUARES[cardIndexes[j]];
                    drawShape("square", drawSquare, WHITE);
                }

                for (int k = 0; k < selectedCards.length; ++k) {
                    selectedCards[k] = false;
                }

                deckCards();
                drawCards(deckCards);

                possibleSets = checkPossibleSets(deckededCardIndexes);
                
                if(possibleSets < 1){
                    endGame();
                    return;
                }
            }
            cardsLeft = countCardsLeft(cards);
            drawRealtimeInfo(); 
        }
    }
}
