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
    {
        75,
        150,
        25,
        250,
        125,
        250,
    },
        {
        225,
        150,
        275,
        250,
        175,
        250,
    },
    {
        150,
        50,
        100,
        150,
        200,
        150,
    },
};

/* Colors */
final color RED   = color(255, 0, 0);
final color GREEN = color(0, 255, 0);
final color BLUE  = color(0, 0, 255);
final color BLACK = color(0);
final color WHITE = color(255);
final color GREY  = color(128);

// make sure it is finished drawing
final byte AMOUNTOFCARDS = 9;
boolean finishedDrawing = false;
boolean[] selectedCards = new boolean[AMOUNTOFCARDS];

void setup() {
    createCards();
    shuffleCards(cards);
    // this makes a window of width 900px x height 1000px
    size(902, 1002);
    background(WHITE);
    drawRasterLines();
    deckCards();
    drawCards(deckCards);

    // x1_1,
    // y1_1,
    // x2_1,
    // y2_1,
    // x3_1,
    // y3_1

    
    // point(150, 50);
    // point(100, 150);
    // point(200, 150);
    // println(triangle1);
    // drawShape("triangle", triangle1, RED);
    // drawShape("triangle", triangle2, BLUE);
    // drawShape("triangle", triangle3, GREEN);


    finishedDrawing = true;
    // drawShape("triangle");
}

void draw() {
    
}

void mousePressed() {
    if(!finishedDrawing) return;
  
    checkClickedCard(mouseX, mouseY);
    // fill(0);
    // ellipse(mouseX, mouseY, 50, 50);
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
// , byte amount = 1, color rgbColor = BLACK
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
            println("triangleeeeeeeeeeeee");
            float[] floatCoords = new float[coordinates.length];
            for (int i = 0; i < coordinates.length; i++) {
                floatCoords[i] = (float) coordinates[i];
            }
            triangle(floatCoords[0], floatCoords[1], floatCoords[2], floatCoords[3], floatCoords[4], floatCoords[5]);

            break;
        case "rectangle":
            rect(50, 50, 50, 50);
            break;
        case "ellipse":
            ellipse(75, 75, 50, 50);
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
        if (x >= card[0] && x <= card[2] &&
            y >= card[1] && y <= card[3]) {
                
            // Print the index of the clicked card
            println("Card " + (i + 1) + " was clicked.");
            // flip the boolean
            selectedCards[i] = !selectedCards[i];
            drawSelectedCard(i, selectedCards[i]);
        }
    }
}


void drawSelectedCard(byte index, boolean selected) {
    byte amountOfcoordinates = (byte) CARDCOORDINATES.length;
    color squareColor = WHITE;
    if(selected) {
        squareColor = GREY;
    }

    int[] drawSquare = new int[SQUARES[index].length];
    arrayCopy(SQUARES[index], 0, drawSquare, 0, SQUARES[index].length);
    drawShape("square", drawSquare, squareColor);
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
    for (byte i = 0; i < cardsAmount; ++i) {
        byte amount = Byte.parseByte(cards[i][0]);
        color rgbColor = getRgbColor(cards[i][2]);
        String shape = cards[i][1];

        switch (shape) {
            case "triangle":
                switch (amount) {
                    case 1 :
                        for (byte t = 1; t < 1; ++t) {
                            TRIANGLES[t][0] += CARDCOORDINATES[i][0];
                            TRIANGLES[t][1] += CARDCOORDINATES[i][1];
                            TRIANGLES[t][2] += CARDCOORDINATES[i][0];
                            TRIANGLES[t][3] += CARDCOORDINATES[i][1];
                            TRIANGLES[t][4] += CARDCOORDINATES[i][0];
                            TRIANGLES[t][5] += CARDCOORDINATES[i][1];
                            drawShape(
                                shape,
                                TRIANGLES[t],
                                rgbColor
                            );
                        }
                        break;
                    case 2 :
                        for (byte t = 2; t < 3; ++t) {
                            TRIANGLES[t][0] += CARDCOORDINATES[i][0];
                            TRIANGLES[t][1] += CARDCOORDINATES[i][1];
                            TRIANGLES[t][2] += CARDCOORDINATES[i][0];
                            TRIANGLES[t][3] += CARDCOORDINATES[i][1];
                            TRIANGLES[t][4] += CARDCOORDINATES[i][0];
                            TRIANGLES[t][5] += CARDCOORDINATES[i][1];
                            drawShape(
                                shape,
                                TRIANGLES[t],
                                rgbColor
                            );
                        }
                        break;
                    case 3 :
                        for (byte t = 0; t < 3; ++t) {
                            TRIANGLES[t][0] += CARDCOORDINATES[i][0];
                            TRIANGLES[t][1] += CARDCOORDINATES[i][1];
                            TRIANGLES[t][2] += CARDCOORDINATES[i][0];
                            TRIANGLES[t][3] += CARDCOORDINATES[i][1];
                            TRIANGLES[t][4] += CARDCOORDINATES[i][0];
                            TRIANGLES[t][5] += CARDCOORDINATES[i][1];
                            drawShape(
                                shape,
                                TRIANGLES[t],
                                rgbColor
                            );
                        }
                        break;
                        
                    default:
                        println("Invalid shape");
                        break;	
                }

                break;
            case "rectangle":
                break;
            case "ellipse":
                break;
            case "square":
                break;
            default:
                println("Invalid shape");
                break;
        }
    }
}
