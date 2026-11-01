// ==========================================================
// SPOT IT - ZOO ANIMAL SEARCH GAME
// Processing - Java Mode
// ==========================================================


// ==========================================================
// IMAGES
// ==========================================================

PImage ZooScene;

// Stores ALL animal images
PImage[] animalImages;


// ==========================================================
// ANIMAL INFORMATION
// ==========================================================

// Names must be in the SAME ORDER as the images loaded in setup()
String[] animalNames = {
  "GORILLA",
  "FLAMINGO",
  "PEACOCK",
  "CROCODILE",
  "KOALA",
  "PARROT",
  "SNAKE",
  "CHEETAH",
  "MEERKAT",
  "TOUCAN",
  "MONKEY",
  "PANDA",
  "OWL",
  "KANGAROO",
  "ZEBRA",
  "ELEPHANT",
  "HIPPO",
  "LION",
  "TURTLE"
};


// ==========================================================
// ANIMALS CURRENTLY ON SCREEN
// ==========================================================

// Exactly 6 animals are displayed
int numberOnScreen = 6;

// Stores which animal is in each enclosure
int[] animalsOnScreen = new int[numberOnScreen];


// ==========================================================
// ENCLOSURE POSITIONS
// ==========================================================

// Centre X position of each animal
float[] animalX = {
  220,
  830,
  1350,
  230,
  780,
  1370
};

// Centre Y position of each animal
float[] animalY = {
  220,
  190,
  250,
  620,
  480,
  610
};

// Width of animal displayed in each enclosure
float[] animalW = {
  220,
  210,
  220,
  230,
  210,
  230
};

// Height of animal displayed in each enclosure
float[] animalH = {
  180,
  170,
  180,
  180,
  170,
  180
};


// ==========================================================
// TARGET
// ==========================================================

// targetSlot tells us WHICH of the six enclosure positions
// contains the animal the player needs to find
int targetSlot = 0;

// Actual animal ID of the target
int targetAnimal = 0;


// ==========================================================
// SCORE AND TIMER
// ==========================================================

int score = 0;

int gameLength = 60;

int startTime;

int timeLeft;

boolean gameOver = false;


// ==========================================================
// FEEDBACK
// ==========================================================

String feedback = "";

int feedbackTime = 0;

// Feedback stays visible for 1 second
int feedbackLength = 1000;


// ==========================================================
// SETUP
// ==========================================================

void setup() {

  // Same ratio as the supplied zoo background
  size(1600, 900);

  // --------------------------------------------------------
  // LOAD ZOO
  // --------------------------------------------------------

  ZooScene = loadImage("ZooScene.png");

  // --------------------------------------------------------
  // CREATE IMAGE ARRAY
  // --------------------------------------------------------

  animalImages = new PImage[19];


  // --------------------------------------------------------
  // LOAD ALL ANIMAL IMAGES
  // --------------------------------------------------------

  animalImages[0] = loadImage("gorilla.png");
  animalImages[1] = loadImage("flamingo.JPEG");
  animalImages[2] = loadImage("peacock.png");
  animalImages[3] = loadImage("crocodile.png");
  animalImages[4] = loadImage("koala.png");
  animalImages[5] = loadImage("parrot.png");
  animalImages[6] = loadImage("snake.png");
  animalImages[7] = loadImage("cheetah.png");
  animalImages[8] = loadImage("meerkat.png");
  animalImages[9] = loadImage("toucan.png");
  animalImages[10] = loadImage("monkey.png");
  animalImages[11] = loadImage("panda.png");
  animalImages[12] = loadImage("owl.png");
  animalImages[13] = loadImage("kangaroo.png");
  animalImages[14] = loadImage("zebra.png");
  animalImages[15] = loadImage("elephant.png");
  animalImages[16] = loadImage("hippo.png");
  animalImages[17] = loadImage("lion.png");
  animalImages[18] = loadImage("turtle.png");
}

// ==========================================================
// DRAW
// ==========================================================

void draw() {

  background(255);

  // --------------------------------------------------------
  // DRAW ZOO BACKGROUND
  // --------------------------------------------------------

  imageMode(CORNER);

  image(ZooScene, 0, 0, width, height);


  // --------------------------------------------------------
  // CALCULATE TIMER
  // --------------------------------------------------------

  timeLeft = gameLength - (millis() - startTime) / 1000;


  if (timeLeft < 0) {
    timeLeft = 0;
  }


  // ========================================================
  // GAME RUNNING
  // ========================================================

  if (timeLeft > 0 && gameOver == false) {


    // ------------------------------------------------------
    // DRAW THE SIX ANIMALS
    // ------------------------------------------------------

    drawAnimals();


    // ------------------------------------------------------
    // DRAW SCORE AND TIMER
    // ------------------------------------------------------

    drawGameInformation();


    // ------------------------------------------------------
    // DRAW TARGET BOX
    // ------------------------------------------------------

    drawTargetBox();


    // ------------------------------------------------------
    // DRAW FEEDBACK
    // ------------------------------------------------------

    drawFeedback();
  }


  // ========================================================
  // GAME OVER
  // ========================================================

  else {

    gameOver = true;

    drawGameOver();
  }
}


// ==========================================================
// DRAW SIX ANIMALS
// ==========================================================

void drawAnimals() {

  imageMode(CENTER);

  for (int i = 0; i < numberOnScreen; i++) {

    int animalNumber = animalsOnScreen[i];

    image(
      animalImages[animalNumber],
      animalX[i],
      animalY[i],
      animalW[i],
      animalH[i]
    );
  }

  imageMode(CORNER);
}


// ==========================================================
// SCORE AND TIMER
// ==========================================================

void drawGameInformation() {

  // ---------------- SCORE ----------------

  fill(255, 245);

  stroke(40);

  strokeWeight(3);

  rect(25, 20, 190, 65, 15);

  fill(30);

  textAlign(CENTER, CENTER);

  textSize(27);

  text("SCORE  " + score, 120, 52);


  // ---------------- TIMER ----------------

  fill(255, 245);

  stroke(40);

  strokeWeight(3);

  rect(width - 215, 20, 190, 65, 15);

  fill(30);

  textSize(27);

  text("TIME  " + timeLeft, width - 120, 52);
}


// ==========================================================
// TARGET BOX
// ==========================================================

void drawTargetBox() {

  float boxX = width/2 - 230;
  float boxY = height - 155;
  float boxW = 460;
  float boxH = 135;


  // --------------------------------------------------------
  // TARGET PANEL
  // --------------------------------------------------------

  fill(255, 244, 207);

  stroke(82, 53, 25);

  strokeWeight(5);

  rect(boxX, boxY, boxW, boxH, 20);


  // --------------------------------------------------------
  // INSTRUCTION
  // --------------------------------------------------------

  fill(45);

  textAlign(CENTER, CENTER);

  textSize(20);

  text(
    "FIND THIS ANIMAL",
    width/2 + 50,
    boxY + 30
  );


  // --------------------------------------------------------
  // TARGET ANIMAL IMAGE
  // --------------------------------------------------------

  imageMode(CENTER);

  image(
    animalImages[targetAnimal],
    width/2 - 135,
    boxY + 72,
    100,
    90
  );

  imageMode(CORNER);


  // --------------------------------------------------------
  // TARGET NAME
  // --------------------------------------------------------

  fill(30);

  textSize(27);

  text(
    animalNames[targetAnimal],
    width/2 + 50,
    boxY + 82
  );
}


// ==========================================================
// FEEDBACK
// ==========================================================

void drawFeedback() {

  // Only show message for a short time
  if (millis() - feedbackTime < feedbackLength) {


    // ------------------------------------------------------
    // ADD BACKGROUND BEHIND FEEDBACK
    // Makes message much easier to see
    // ------------------------------------------------------

    noStroke();

    fill(255, 235);

    rectMode(CENTER);

    rect(
      width/2,
      height/2,
      500,
      120,
      25
    );

    rectMode(CORNER);


    // ------------------------------------------------------
    // TEXT
    // ------------------------------------------------------

    textAlign(CENTER, CENTER);

    textSize(52);


    // WRONG ANSWER
    if (feedback.equals("TRY AGAIN!")) {

      fill(220, 30, 30);

      textFont(createFont("Arial Bold", 52));

      text(
        "TRY AGAIN!",
        width/2,
        height/2
      );
    }


    // CORRECT ANSWER
    else {

      fill(20, 155, 60);

      textFont(createFont("Arial Bold", 52));

      text(
        feedback,
        width/2,
        height/2
      );
    }


    // Return text to normal
    textFont(createFont("Arial", 52));
  }
}


// ==========================================================
// MOUSE PRESSED
// ==========================================================

void mousePressed() {


  // --------------------------------------------------------
  // RESTART IF GAME OVER
  // --------------------------------------------------------

  if (gameOver == true) {

    startGame();

    return;
  }


  // --------------------------------------------------------
  // CHECK EACH OF THE SIX ANIMAL POSITIONS
  // --------------------------------------------------------

  for (int i = 0; i < numberOnScreen; i++) {


    // Work out edges of this animal's clickable area

    float left =
      animalX[i] - animalW[i]/2;

    float right =
      animalX[i] + animalW[i]/2;

    float top =
      animalY[i] - animalH[i]/2;

    float bottom =
      animalY[i] + animalH[i]/2;


    // ------------------------------------------------------
    // WAS THIS ANIMAL CLICKED?
    // ------------------------------------------------------

    if (
      mouseX > left &&
      mouseX < right &&
      mouseY > top &&
      mouseY < bottom
    ) {

      checkAnimal(i);

      return;
    }
  }


  // --------------------------------------------------------
  // PLAYER CLICKED EMPTY SPACE
  // --------------------------------------------------------

  feedback = "TRY AGAIN!";

  feedbackTime = millis();
}


// ==========================================================
// CHECK ANIMAL
// ==========================================================

void checkAnimal(int clickedSlot) {


  // Get ID of clicked animal

  int clickedAnimal =
    animalsOnScreen[clickedSlot];


  // ========================================================
  // CORRECT TARGET
  // ========================================================

  if (clickedAnimal == targetAnimal) {


    // Increase score

    score++;


    // ------------------------------------------------------
    // POSITIVE FEEDBACK
    // ------------------------------------------------------

    // Every second correct answer
    if (score % 2 == 0) {

      feedback = "AMAZING WORK!";
    }

    // First, third, fifth etc.
    else {

      feedback = "NICE!";
    }


    feedbackTime = millis();


    // ------------------------------------------------------
    // REMOVE CORRECT ANIMAL AND REPLACE IT
    // ------------------------------------------------------

    replaceAnimal(clickedSlot);


    // ------------------------------------------------------
    // CHOOSE A NEW TARGET FROM THE SIX ANIMALS
    // ------------------------------------------------------

    chooseNewTarget();
  }


  // ========================================================
  // WRONG TARGET
  // ========================================================

  else {

    feedback = "TRY AGAIN!";

    feedbackTime = millis();
  }
}


// ==========================================================
// GENERATE SIX RANDOM ANIMALS
// ==========================================================

void generateAnimals() {


  // Go through all six enclosure positions

  for (int i = 0; i < numberOnScreen; i++) {


    int newAnimal;

    boolean duplicate;


    // Keep choosing until we find an animal
    // that is not already on screen

    do {

      newAnimal =
        int(random(animalNames.length));

      duplicate = false;


      // Check previous enclosure positions

      for (int j = 0; j < i; j++) {

        if (animalsOnScreen[j] == newAnimal) {

          duplicate = true;
        }
      }

    } while (duplicate == true);


    // Put animal into enclosure

    animalsOnScreen[i] = newAnimal;
  }
}


// ==========================================================
// REPLACE ANIMAL
// ==========================================================

void replaceAnimal(int slotToReplace) {

  int newAnimal;

  boolean alreadyOnScreen;


  // --------------------------------------------------------
  // FIND AN ANIMAL NOT CURRENTLY DISPLAYED
  // --------------------------------------------------------

  do {

    newAnimal =
      int(random(animalNames.length));

    alreadyOnScreen = false;


    // Compare against all six animals

    for (int i = 0; i < numberOnScreen; i++) {

      if (
        i != slotToReplace &&
        animalsOnScreen[i] == newAnimal
      ) {

        alreadyOnScreen = true;
      }
    }


  } while (alreadyOnScreen == true);


  // --------------------------------------------------------
  // REPLACE ONLY THE ANIMAL THAT WAS FOUND
  // --------------------------------------------------------

  animalsOnScreen[slotToReplace] =
    newAnimal;
}


// ==========================================================
// CHOOSE NEW TARGET
// ==========================================================

void chooseNewTarget() {

  int oldTarget = targetAnimal;


  // --------------------------------------------------------
  // RANDOMLY CHOOSE ONE OF THE SIX ENCLOSURES
  // --------------------------------------------------------

  targetSlot =
    int(random(numberOnScreen));


  targetAnimal =
    animalsOnScreen[targetSlot];


  // --------------------------------------------------------
  // AVOID SHOWING SAME TARGET TWICE IN A ROW
  // --------------------------------------------------------

  if (numberOnScreen > 1) {

    while (targetAnimal == oldTarget) {

      targetSlot =
        int(random(numberOnScreen));

      targetAnimal =
        animalsOnScreen[targetSlot];
    }
  }
}


// ==========================================================
// START / RESTART GAME
// ==========================================================

void startGame() {


  // Reset score

  score = 0;


  // Reset feedback

  feedback = "";


  // Reset timer

  startTime = millis();

  timeLeft = gameLength;


  // Game is active

  gameOver = false;


  // --------------------------------------------------------
  // GENERATE NEW RANDOM SIX ANIMALS
  // --------------------------------------------------------

  generateAnimals();


  // --------------------------------------------------------
  // CHOOSE FIRST TARGET
  // --------------------------------------------------------

  targetSlot =
    int(random(numberOnScreen));

  targetAnimal =
    animalsOnScreen[targetSlot];
}


// ==========================================================
// GAME OVER SCREEN
// ==========================================================

void drawGameOver() {


  // --------------------------------------------------------
  // DARK OVERLAY
  // --------------------------------------------------------

  noStroke();

  fill(0, 0, 0, 185);

  rect(0, 0, width, height);


  // --------------------------------------------------------
  // GAME OVER TEXT
  // --------------------------------------------------------

  fill(255);

  textAlign(CENTER, CENTER);

  textFont(createFont("Arial Bold", 52));

  textSize(60);

  text(
    "TIME'S UP!",
    width/2,
    height/2 - 80
  );


  // --------------------------------------------------------
  // FINAL SCORE
  // --------------------------------------------------------

  textFont(createFont("Arial", 52));

  textSize(38);

  text(
    "Final Score: " + score,
    width/2,
    height/2
  );


  // --------------------------------------------------------
  // REPLAY INSTRUCTION
  // --------------------------------------------------------

  textSize(25);

  text(
    "Click anywhere to play again",
    width/2,
    height/2 + 80
  );
}
