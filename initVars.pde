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
byte[] deckededCardIndexes = { 0, 1, 2, 3, 4, 5, 6, 7, 8 };
int amountOfGuesses = 0;
int possibleSets = 0;
int cardsLeft = 0;
byte scorePlayer1 = 0;
byte scorePlayer2 = 0;