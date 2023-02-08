/* Characteristics */
String[] amounts = { "1", "2", "3" };
String[] shapes = { "triangle", "rectangle", "ellipse" };
String[] colors = { "red", "green", "blue" };
String[][] cards = new String[27][3];

/* State management */
int[][] horizontalLines = new int[3][3];

horizontalLines = {}


/* Colors */
final color RED   = color(255, 0, 0);
final color GREEN = color(0, 255, 0);
final color BLUE  = color(0, 0, 255);
final color BLACK = color(255, 255, 255);
final color WHITE = color(0, 0, 0);

void setup() {
    createCards();
    shuffleCards(cards);

    // println("SHUFFLED");
    // for (int a = 0; a < cards.length; a++) {
    //     println(cards[a]);
    // }

    // this makes a window of width 900px x height 1000px
    size(900, 1000);
    background(255);
    color black = getColor(BLACK);
    println("black");
    println(black);
    // drawShape();
    drawShape(shapes[0]);
    drawShape(shapes[1]);
    drawShape(shapes[2]);
}

void createCards() {
    int cardIndex = 0;

    for (int a = 0; a < amounts.length; a++) {
        for (int s = 0; s < shapes.length; s++) {
            for (int c = 0; c < colors.length; c++) {
                String[] card = {
                    amounts[a],
                    shapes[s],
                    colors[c]
                };

                cards[cardIndex] = card;
                cardIndex++;
            }
        }
    }
}

void shuffleCards(String[][] cards) {
    int amountOfCards = cards.length;

    for (int i = 0; i < amountOfCards; i++) {
        int rand = (int) random(i, amountOfCards);
        String[] card = cards[rand];
        cards[rand] = cards[i];
        cards[i] = card;
    }
}

void drawShape(String shape) {
  switch (shape) {
    case "triangle":
      triangle(50, 75, 75, 50, 100, 75);
      break;
    case "rectangle":
      rect(50, 50, 50, 50);
      break;
    case "ellipse":
      ellipse(75, 75, 50, 50);
      break;
    default:
      println("Invalid shape");
      break;
  }
}

void getRgbColor(String colorName) {
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
        case "black":
            rgbColor = BLUE;
        break;
        case "white":
            rgbColor = WHITE;
        break;
        default:
            println("Invalid colorname");
        break;
    }
}

// String numberArrayToString(int[] numbers){
//     String numbersString = join(numbers, ", ");
//     return commaSeporated;
// }


