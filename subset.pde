/* Characteristics */
final String[] AMOUNTS = { "1", "2", "3" };
final String[] SHAPES = { "triangle", "rectangle", "ellipse" };
final String[] COLORS = { "red", "green", "blue" };
String[][] cards = new String[27][3];
String[][] deckCards = new String[9][3];

/* Raster lines */
// [0]xBegin [1]yBegin [2]xEnd [3]yEnd
final int[][] RASTERLINES = {
    // horizontal lines
    {0, 0, 900, 0},
    {0, 300, 900, 300},
    {0, 600, 900, 600},
    {0, 900, 900, 900},
    // vertical lines
    {0, 0, 0, 900},
    {300, 0, 300, 900},
    {600, 0, 600, 900},
    {900, 0, 900, 900},
};

final int[][] CARDCOORDINATES = {
    // [0]xBegin [1]yBegin [2]xEnd [3]yEnd
    // row 1
    {0, 0, 300, 300},
    {300, 0, 600, 300},
    {600, 0, 900, 300},
    // row 2
    {0, 300, 300, 600},
    {300, 300, 600, 600},
    {600, 300, 900, 600},
    // row 3
    {0, 600, 300, 900},
    {300, 600, 600, 900},
    {600, 600, 900, 900},
};

final int[][] SQUARES = {
    // [0]xBegin [1]yBegin [2]xEnd [3]yEnd
    // row 1
    {0, 0, 300, 300},
    {300, 0, 300, 300},
    {600, 0, 300, 300},
    // row 2
    {0, 300, 300, 300},
    {300, 300, 300, 300},
    {600, 300, 300, 300},
    // row 3
    {0, 600, 300, 300},
    {300, 600, 300, 300},
    {600, 600, 300, 300},
};


final int[][] TRIANGLES = {
    { 75, 150, 25, 250, 125, 250 },
    { 225, 150, 275, 250, 175, 250 },
    { 150, 50, 100, 150, 200, 150 },
};

final int[][] RECTANGLES = {
    { 75, 30, 150, 50 },
    { 75, 125, 150, 50 },
    { 75, 220, 150, 50 },
};

final int[][] ELLIPSE = {
    { 150, 30, 150, 50 },
    { 150, 125, 150, 50 },
    { 150, 220, 150, 50 },
};

/* Colors */
final color RED   = color(255, 0, 0);
final color GREEN = color(0, 255, 0);
final color BLUE  = color(0, 0, 255);
final color BLACK = color(0);
final color WHITE = color(255);
final color GREY  = color(128);

boolean[] selectedCards = new boolean[9];

void setup() {
    createCards();
    shuffleCards(cards);
    // this makes a window of width 901px x height 1001px
    size(901, 1001);
    background(WHITE);
    drawRasterLines();
    deckCards();

    drawCards(deckCards);

    byte[] deckCardIndexes = {0, 1, 2, 3, 4, 5, 6, 7, 8};
    byte[][] cardCombinations = generateUniqueSets(deckCardIndexes);
    int combinationSize = cardCombinations.length;
    String[][] currentDeck = new String[combinationSize][3];
    int correctSets = 0;

    for (int i = 0; i < combinationSize; i++) {
        currentDeck[0] = cards[cardCombinations[i][0]];
        currentDeck[1] = cards[cardCombinations[i][1]];
        currentDeck[2] = cards[cardCombinations[i][2]];
        if(checkSelection(currentDeck)) correctSets++;
    }
    print("correctSets: ");
    println(correctSets);
}

void draw() {
    
}

void mousePressed() {
    checkClickedCard(mouseX, mouseY);
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

void shuffleCards(String[][] cards) {
    byte amountOfCards = (byte) cards.length;

    for (byte i = 0; i < amountOfCards; i++) {
        byte rand = (byte) random(i, amountOfCards);
        String[] card = cards[rand];
        cards[rand] = cards[i];
        cards[i] = card;
    }
}

void drawShape(
    String shape, 
    int[] coordinates,
    int rgbColor
) {
    fill(rgbColor);
    switch (shape) {
        case "line":
            line(coordinates[0], coordinates[1], coordinates[2], coordinates[3]);
            break;
        case "triangle":
            float[] triangleCoords = new float[coordinates.length];
            for (int i = 0; i < coordinates.length; i++) {
                triangleCoords[i] = (float) coordinates[i];
            }
            triangle(triangleCoords[0], triangleCoords[1], triangleCoords[2], triangleCoords[3], triangleCoords[4], triangleCoords[5]);

            break;
        case "rectangle":
            rect(coordinates[0], coordinates[1], coordinates[2], coordinates[3]);
            break;
        case "ellipse":
            float[] ellipseCoords = new float[coordinates.length];
            for (int i = 0; i < coordinates.length; i++) {
                ellipseCoords[i] = (float) coordinates[i];
            }
            ellipse(ellipseCoords[0], ellipseCoords[1], ellipseCoords[2], ellipseCoords[3]);
            break;
        case "square":
            fill(rgbColor);
            rect(coordinates[0], coordinates[1], coordinates[2], coordinates[3]);
            break;
        default:
            println("Invalid shape");
            break;
    }
}

color getRgbColor(String colorName) {
    color rgbColor = color(255, 255, 255);

    switch (colorName) {
        case "red":
            rgbColor = RED;
            break;
        case "green":
            rgbColor = GREEN;
            break;
        case "blue":
            rgbColor = BLUE;
            break;
        default:
            println("Invalid colorName");
            break;
    }

    return rgbColor;
}

void drawRasterLines() {
    byte amountOfRasterLines = (byte) RASTERLINES.length;
    for (byte i = 0; i < amountOfRasterLines; i++) {
        drawShape("line", RASTERLINES[i], (int) 0);
    }
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
            println("Card " + (i + 1) + " was clicked.");
            // flip the boolean
            selectedCards[i] = !selectedCards[i];
            drawSelectedCard(i, selectedCards[i]);
            
            byte count = 0;
            for (boolean value : selectedCards) {
                if (value == true) count++;
            }

            if (count >= 3) {
                
            }
        }
    }
}


void drawSelectedCard(byte index, boolean selected) {
    byte amountOfcoordinates = (byte) CARDCOORDINATES.length;
    color squareColor = WHITE;
    if(selected) {
        squareColor = GREY;
    }

    int[] drawSquare = SQUARES[index];
    drawShape("square", drawSquare, squareColor);

    String[][] emptyCards = new String[9][3];

    emptyCards[index] = deckCards[index];
    drawCards(emptyCards);
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
            for (byte cardIndex = (byte) (cardsAmount - 1); cardIndex >= 0; cardIndex--) {
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
        println(i);
        println(deckCards[i]);
    }
}

void drawCards(String[][] cards) {
    byte cardsAmount = byte(cards.length);
    for (byte i = 0; i < cardsAmount; i++) {
        // this will prevent empty arrays to enter the switch statment
        if (cards[i].length == 0 ||
            cards[i][0] == null ||
            cards[i][1] == null ||
            cards[i][2] == null
        ) continue;
        

        byte amount = Byte.parseByte(cards[i][0]);
        color rgbColor = getRgbColor(cards[i][2]);
        String shape = cards[i][1];

        switch (shape) {
            case "triangle":
                switch (amount) {
                    case 1 :
                        for (byte t = 2; t < 3; t++) {
                            int[] triangle = {
                                (TRIANGLES[t][0] + CARDCOORDINATES[i][0]),
                                (TRIANGLES[t][1] + CARDCOORDINATES[i][1]),
                                (TRIANGLES[t][2] + CARDCOORDINATES[i][0]),
                                (TRIANGLES[t][3] + CARDCOORDINATES[i][1]),
                                (TRIANGLES[t][4] + CARDCOORDINATES[i][0]),
                                (TRIANGLES[t][5] + CARDCOORDINATES[i][1]),
                            };
                            drawShape(
                                shape,
                                triangle,
                                rgbColor
                            );
                        }
                        break;
                    case 2 :
                        for (byte t = 0; t < 2; t++) {
                            int[] triangle = {
                                (TRIANGLES[t][0] + CARDCOORDINATES[i][0]),
                                (TRIANGLES[t][1] + CARDCOORDINATES[i][1]),
                                (TRIANGLES[t][2] + CARDCOORDINATES[i][0]),
                                (TRIANGLES[t][3] + CARDCOORDINATES[i][1]),
                                (TRIANGLES[t][4] + CARDCOORDINATES[i][0]),
                                (TRIANGLES[t][5] + CARDCOORDINATES[i][1]),
                            };
                            drawShape(
                                shape,
                                triangle,
                                rgbColor
                            );
                        }
                        break;
                    case 3 :
                        for (byte t = 0; t < 3; t++) {
                            int[] triangle = {
                                (TRIANGLES[t][0] + CARDCOORDINATES[i][0]),
                                (TRIANGLES[t][1] + CARDCOORDINATES[i][1]),
                                (TRIANGLES[t][2] + CARDCOORDINATES[i][0]),
                                (TRIANGLES[t][3] + CARDCOORDINATES[i][1]),
                                (TRIANGLES[t][4] + CARDCOORDINATES[i][0]),
                                (TRIANGLES[t][5] + CARDCOORDINATES[i][1]),
                            };
                            drawShape(
                                shape,
                                triangle,
                                rgbColor
                            );
                        }
                        break;
                    default:
                        println("Invalid amount of triangles");
                        break;	
                }
                break;
            case "rectangle":
                for (byte r = 0; r < amount; r++) {
                    int[] rectangle = {
                        (RECTANGLES[r][0] + CARDCOORDINATES[i][0]),
                        (RECTANGLES[r][1] + CARDCOORDINATES[i][1]),
                        RECTANGLES[r][2],
                        RECTANGLES[r][3],
                    };
                    drawShape(
                        shape,
                        rectangle,
                        rgbColor
                    );
                }
                break;
            case "ellipse":
                for (byte r = 0; r < amount; r++) {
                    int[] ellipse = {
                        (ELLIPSE[r][0] + CARDCOORDINATES[i][0]),
                        (ELLIPSE[r][1] + CARDCOORDINATES[i][1]),
                        ELLIPSE[r][2],
                        ELLIPSE[r][3],
                    };
                    drawShape(
                        shape,
                        ellipse,
                        rgbColor
                    );
                }
                break;
            case "square":
                break;
            default:
                println("Invalid shape");
                break;
        }
    }
}

boolean checkSelection(String[][] cards) {
    byte numAttributes = (byte) cards[0].length;
    boolean[] correctAttribute = new boolean[numAttributes];

    for (byte i = 0; i < numAttributes; i++) {
        String card1 = cards[0][i];
        String card2 = cards[1][i];
        String card3 = cards[2][i];

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
            return false;
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
    // Print all sets
    // for (int i = 0; i < numSets; i++) {
    //     for (int j = 0; j < 3; j++) {
    //         print(sets[i][j] + " ");
    //     }
    // }
}
