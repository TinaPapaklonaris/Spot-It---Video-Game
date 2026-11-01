// ==========================================================
// SPOT IT - ZOO ANIMAL SEARCH GAME
// Processing - Java Mode
// ==========================================================

// -------------------- IMAGES --------------------

PImage zooScene;

// Animal target images shown in the target box
PImage elephantIcon;
PImage zebraIcon;
PImage giraffeIcon;
PImage lionIcon;

// -------------------- GAME VARIABLES --------------------

// Names of all animals
String[] animals = {
  "ELEPHANT",
  "ZEBRA",
  "GIRAFFE",
  "LION"
};

// Target currently being searched for
int targetAnimal = 0;

// Player score
int score = 0;

// Game timer
int gameLength = 60;       // 60 second game
int startTime;
int timeLeft;

// Feedback message
String feedback = "";

// Controls how long feedback stays on screen
int feedbackTime = 0;

// Has the game finished?
boolean gameOver = false;


// ==========================================================
// SETUP
// ==========================================================

void setup() {

  size(1200, 850);

  // Load zoo background
  zooScene = loadImage("zooScene.png");

  // Load animal icons
  elephantIcon = loadImage("elephant.png");
  zebraIcon = loadImage("zebra.png");
  giraffeIcon = loadImage("giraffe.png");
  lionIcon = loadImage("lion.png");

  // Start timer
  startTime = millis();

  // Select the first target
  newTarget();
}


// ==========================================================
// DRAW
// Runs continuously
// ==========================================================

void draw() {

  background(255);

  // Draw zoo scene
  image(zooScene, 0, 0, width, 700);

  // Calculate countdown
  timeLeft = gameLength - (millis() - startTime) / 1000;


  // --------------------------------------------------------
  // GAME IS RUNNING
  // --------------------------------------------------------

  if (timeLeft > 0) {

    // Draw score
    fill(255);
    stroke(0);
    rect(20, 20, 170, 55, 10);

    fill(0);
    textSize(24);
    textAlign(LEFT, CENTER);
    text("Score: " + score, 35, 47);


    // Draw timer
    fill(255);
    stroke(0);
    rect(1000, 20, 170, 55, 10);

    fill(0);
    textSize(24);
    text("Time: " + timeLeft, 1020, 47);


    // Draw target panel
    drawTargetBox();


    // Draw feedback
    if (millis() - feedbackTime < 800) {

      textAlign(CENTER, CENTER);
      textSize(30);

      if (feedback.equals("CORRECT!")) {
        fill(0, 170, 70);
      } else {
        fill(220, 50, 50);
      }

      text(feedback, width/2, 80);
    }

  }


  // --------------------------------------------------------
  // GAME OVER
  // --------------------------------------------------------

  else {

    gameOver = true;

    // Dark overlay
    fill(0, 0, 0, 180);
    rect(0, 0, width, height);

    fill(255);

    textAlign(CENTER, CENTER);

    textSize(50);
    text("TIME'S UP!", width/2, height/2 - 70);

    textSize(32);
    text("Final Score: " + score, width/2, height/2);

    textSize(22);
    text("Click to play again", width/2, height/2 + 70);
  }
}


// ==========================================================
// TARGET BOX
// ==========================================================

void drawTargetBox() {

  // Box at bottom of screen
  fill(245, 225, 180);
  stroke(80, 50, 20);
  strokeWeight(5);

  rect(400, 710, 400, 120, 20);


  // Instruction
  fill(60);
  textAlign(CENTER);
  textSize(18);

  text("FIND THIS ANIMAL", 600, 738);


  // Show animal name
  textSize(25);
  fill(0);

  text(animals[targetAnimal], 600, 805);


  // Show correct animal icon
  PImage targetImage = getAnimalImage(targetAnimal);

  if (targetImage != null) {

    imageMode(CENTER);

    image(targetImage, 500, 775, 65, 65);

    imageMode(CORNER);
  }
}


// ==========================================================
// MOUSE CLICK
// ==========================================================

void mousePressed() {

  // If game is over, clicking restarts it
  if (gameOver == true) {

    restartGame();
    return;
  }


  // --------------------------------------------------------
  // ELEPHANT
  // --------------------------------------------------------

  else if (mouseX > 330 && mouseX < 600 &&
      mouseY > 170 && mouseY < 370) {

    checkAnimal(0);
  }


  // --------------------------------------------------------
  // ZEBRA
  // --------------------------------------------------------

  else if (mouseX > 70 && mouseX < 230 &&
           mouseY > 440 && mouseY < 620) {

    checkAnimal(1);
  }


  // --------------------------------------------------------
  // GIRAFFE
  // --------------------------------------------------------

  else if (mouseX > 680 && mouseX < 790 &&
           mouseY > 40 && mouseY < 250) {

    checkAnimal(2);
  }


  // --------------------------------------------------------
  // LION
  // --------------------------------------------------------

  else if (mouseX > 910 && mouseX < 1120 &&
           mouseY > 70 && mouseY < 220) {

    checkAnimal(3);
  }

  // --------------------------------------------------------
  // WRONG AREA
  // --------------------------------------------------------

  else {

    feedback = "TRY AGAIN!";
    feedbackTime = millis();
  }
}


// ==========================================================
// CHECK SELECTED ANIMAL
// ==========================================================

void checkAnimal(int clickedAnimal) {

  // Is this the current target?
  if (clickedAnimal == targetAnimal) {

    // Correct animal
    score++;

    feedback = "CORRECT!";
    feedbackTime = millis();

    // Select another target
    newTarget();

  } else {

    // Wrong animal
    feedback = "TRY AGAIN!";
    feedbackTime = millis();
  }
}


// ==========================================================
// CHOOSE A NEW TARGET
// ==========================================================

void newTarget() {

  int oldTarget = targetAnimal;

  // Randomly choose another animal
  targetAnimal = int(random(animals.length));

  // Prevent the same animal appearing twice in a row
  while (targetAnimal == oldTarget) {

    targetAnimal = int(random(animals.length));
  }
}


// ==========================================================
// RETURN CORRECT TARGET IMAGE
// ==========================================================

PImage getAnimalImage(int animalNumber) {

  if (animalNumber == 0) {
    return elephantIcon;
  }

  if (animalNumber == 1) {
    return zebraIcon;
  }

  if (animalNumber == 2) {
    return giraffeIcon;
  }

  if (animalNumber == 3) {
    return lionIcon;
  }

  return null;
}


// ==========================================================
// RESTART GAME
// ==========================================================

void restartGame() {

  score = 0;

  startTime = millis();

  gameOver = false;

  feedback = "";

  newTarget();
}
