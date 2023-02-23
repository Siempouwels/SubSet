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
    int cardIndex = 0;
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
    byte amount,
    int rgbColor
) {
    if(amount < 1) amount = 1;

    switch (shape) {
        case "line":
            stroke(rgbColor);
            for (byte i = 0; i < amount; ++i) {
                line(coordinates[0], coordinates[1], coordinates[2], coordinates[3]);
            }
        break;
        case "triangle":
            fill(255, 0, 0);
            triangle(50, 50, 150, 50, 100, 150);
            // for (byte i = 0; i < amount; ++i) {
            //     triangle(coordinates[0], coordinates[1], coordinates[2], coordinates[3]);
            // }
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
        drawShape("line", RASTERLINES[i], (byte) 1, (int) 0);
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
    drawShape("square", drawSquare, (byte) 1, squareColor);
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
