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

void endGame() {
    background(WHITE);

    // Determine the winner
    String winner = "";
    if (scorePlayer1 > scorePlayer2) {
        winner = "Player 1";
    } else if (scorePlayer2 > scorePlayer1) {
        winner = "Player 2";
    } else {
        winner = "Tie game";
    }

    // Display the final scores and winner
    textSize(32);
    fill(BLACK);
    text("Final Scores:", 100, 100);
    textSize(24);
    text("Player 1: " + scorePlayer1, 100, 150);
    text("Player 2: " + scorePlayer2, 100, 200);
    textSize(32);
    text(winner + " wins!", 100, 300);
}

void drawRealtimeInfo() {
    textAlign(CENTER);
    textSize(20);
    fill(255);
    rect(0, 900, width, 100);
    fill(0);
    text("Mogelijke sets: " + possibleSets, width/2, 930);
    text("Kaarten over: " + cardsLeft, width/2, 970);
    
    textSize(20);
    fill(0);
    text("Speler 1: " + scorePlayer1, 100, 950);
    text("Speler 2: " + scorePlayer2, width - 100, 950);
}