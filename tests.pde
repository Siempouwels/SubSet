
void tests() {
    createCards();
    if(cards.length == 27) println("Correct");
    String[][] oldOrder = new String[27][3];
    shuffleCards(cards);
    if(
        cards[0][0] != oldOrder [0][0] ||
        cards[0][1] != oldOrder [0][1] ||
        cards[0][2] != oldOrder [0][2]
    ){
        println("Correct");
    }

    deckCards();
    for (int i = 0; i < 9; ++i) {
        if(
            deckCards[i][0] == null ||
            deckCards[i][1] == null ||
            deckCards[i][2] == null
        ){
            println("Error");
        }
    }
    println("Correct");

    byte[][] cardCombinations = generateUniqueSets(deckededCardIndexes);

    possibleSets = checkPossibleSets(deckededCardIndexes);
    if(possibleSets > 0) println("Correct");
    
    color red = getRgbColor("red");
    color green = getRgbColor("green");
    color blue = getRgbColor("blue");
    color randomString = getRgbColor("blue");
    if(
        red == -65536 &&
        green == -16711936 &&
        blue == -16776961 &&
        randomString == -1
    ){
        println("Correct");
    }

}