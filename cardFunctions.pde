void shuffleCards(String[][] cards) {
    byte amountOfCards = (byte) cards.length;

    for (byte i = 0; i < amountOfCards; i++) {
        byte rand = (byte) random(i, amountOfCards);
        String[] card = cards[rand];
        cards[rand] = cards[i];
        cards[i] = card;
    }
}

void deckCards() {
    byte deckCardsAmount = (byte) deckCards.length;
    byte cardsAmount = (byte) cards.length;

    for (byte i = 0; i < deckCardsAmount; i++) {
        if(
            deckCards[i][0] == null &&
            deckCards[i][1] == null &&
            deckCards[i][2] == null
        ){
            boolean cardFound = false;
            for (int cardIndex = (cardsAmount - 1); cardIndex >= 0; cardIndex--) {
                if(
                    cards[cardIndex][0] != null &&
                    cards[cardIndex][1] != null &&
                    cards[cardIndex][2] != null
                ){
                    cardFound = true;
                    deckCards[i][0] = cards[cardIndex][0];
                    deckCards[i][1] = cards[cardIndex][1];
                    deckCards[i][2] = cards[cardIndex][2];
                    
                    cards[cardIndex][0] = null;
                    cards[cardIndex][1] = null;
                    cards[cardIndex][2] = null;
                    break;
                }
            }
            if(!cardFound) {
                println("No card found!!!");
            }
        }
    }
}

void checkCards(String[][] selectedCards) {
    byte selectedCardsAmount = (byte) selectedCards.length;
    boolean [] correct = new boolean[3];
    
    for (byte i = 0; i < selectedCardsAmount; i++) {
        deckCards[i] = cards[i];
    }
}

boolean checkSelection(String[][] cards) {
    byte numAttributes = (byte) cards[0].length;
    boolean[] correctAttribute = new boolean[numAttributes];

    for (int i = 0; i < numAttributes; i++) {
        String card1 = cards[0][i];
        String card2 = cards[1][i];
        String card3 = cards[2][i];
        if(
            card1 != null &&
            card2 != null &&
            card3 != null
        ){
            if (card1.equals(card2) &&
                card2.equals(card3)
            ) {
                correctAttribute[i] = true;
            } else if (
                !card1.equals(card2) &&
                !card1.equals(card3) &&
                !card2.equals(card3)
            ) {
                correctAttribute[i] = true;
            } else {
                correctAttribute[i] = false;
            }
        }
    }

    for (boolean correct : correctAttribute) {
        if (!correct) return false;
    }

    return true;
}

byte[][] generateUniqueSets(byte[] arr) {
    int numSets = 0;
    byte amountOfCards = (byte) arr.length;

    byte[][] sets = new byte[amountOfCards*(amountOfCards - 1)*(amountOfCards -2 )/6][3];

    for (byte i = 0; i < amountOfCards - 2; i++) {
        for (byte j = (byte)(i + 1); j < amountOfCards - 1; j++) {
            for (byte k = (byte)(j + 1); k < amountOfCards; k++) {
            sets[numSets][0] = arr[i];
            sets[numSets][1] = arr[j];
            sets[numSets][2] = arr[k];
            numSets++;
            }
        }
    }
    return sets;
}

void printCards(String[][] cards){
    for (byte i = 0; i < cards.length; i++) {
        println("______________" + i + "______________");
        print(cards[i][0]);
        print(", ");
        print(cards[i][1]);
        print(", ");
        print(cards[i][2]);
        println();
    }
}

int checkPossibleSets(byte[] indexes){
    byte[][] cardCombinations = generateUniqueSets(indexes);
    int combinationSize = cardCombinations.length;
    String[][] currentDeck = new String[combinationSize][3];
    int correctSets = 0;

    for (int i = 0; i < combinationSize; i++) {
        currentDeck[0] = deckCards[cardCombinations[i][0]];
        currentDeck[1] = deckCards[cardCombinations[i][1]];
        currentDeck[2] = deckCards[cardCombinations[i][2]];
        if(checkSelection(currentDeck) == true){
            correctSets++;
        }
    }
    
    return correctSets;
}

int countCardsLeft(String[][] cardArray) {
    int count = 0;
    for (int i = 0; i < cardArray.length; i++) {
        if (
            cardArray[i][0] != null &&
            cardArray[i][1] != null &&
            cardArray[i][2] != null
        ) {
            count++;
        }
    }
    return count;
}

void createCards() {
    byte cardIndex = 0;
    byte amountOfAmounts = (byte) AMOUNTS.length;
    byte amountOfShapes = (byte) SHAPES.length;
    byte amountOfColors = (byte) COLORS.length;

    for (byte a = 0; a < amountOfAmounts; a++) {
        for (byte s = 0; s < amountOfShapes; s++) {
            for (byte c = 0; c < amountOfColors; c++) {
                String[] card = {
                    AMOUNTS[a],
                    SHAPES[s],
                    COLORS[c]
                };

                cards[cardIndex] = card;
                cardIndex++;
            }
        }
    }
}