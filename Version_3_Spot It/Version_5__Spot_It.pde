// SPOT IT - ZOO ANIMAL SEARCH GAME
// Processing - Java Mode

// IMAGES

PImage zooScene;

// Array containing every animal image
PImage[] animalImages;

// ANIMAL NAMES

String[] animalNames = {

  "GORILLA",      // 0
  "FLAMINGO",     // 1
  "PEACOCK",      // 2
  "CROCODILE",    // 3
  "KOALA",        // 4
  "PARROT",       // 5
  "SNAKE",        // 6
  "CHEETAH",      // 7
  "MEERKAT",      // 8
  "TOUCAN",       // 9
  "MONKEY",       // 10
  "PANDA",        // 11
  "OWL",          // 12
  "KANGAROO",     // 13
  "ZEBRA",        // 14
  "ELEPHANT",     // 15
  "HIPPO",        // 16
  "LION",         // 17
  "TURTLE",       // 18
  "GIRAFFE",      // 19
  "BEAR",         // 20
  "SEAL",         // 21
};

// GAME SETTINGS

int NUMBER_OF_ENCLOSURES = 6;

int score = 0;

int gameLength = 60;

int startTime;

int timeLeft;

boolean gameOver = false;

// ANIMALS CURRENTLY ON SCREEN
//
// Each number represents the animal occupying that enclosure.
//
// Example:
// animalsOnScreen[0] = 5
//
// means enclosure 0 currently contains animal 5, PARROT.
// ==========================================================

int[] animalsOnScreen = new int[NUMBER_OF_ENCLOSURES];

// CURRENT TARGET

int targetAnimal = -1;

// FEEDBACK

String feedback = "";

int feedbackTime = 0;

// Feedback stays visible for this many milliseconds
int feedbackDuration = 1000;

// Number of consecutive correct answers
int correctStreak = 0;


// ENCLOSURE POSITIONS
//
// FORMAT
//
// { centreX, centreY, maximumWidth, maximumHeight }
//
// These coordinates are designed for the 1200 x 675
// version of your supplied zoo background.

float[][] enclosureSlots = {


  // ENCLOSURE 1
  // Top-left enclosure
  {180, 150, 135, 95},


 
  // ENCLOSURE 2
  // Top-centre enclosure

  {655, 140, 145, 95},


  
  // ENCLOSURE 3
  // Top-right enclosure

  {1000, 205, 135, 95},


 
  // ENCLOSURE 4
  // Centre circular enclosure
  
  {600, 345, 120, 90},



  // ENCLOSURE 5
  // Bottom-left grassy enclosure
  
  {205, 480, 140, 95},



  // ENCLOSURE 6
  // Bottom-right rocky enclosure

  {980, 470, 130, 90}
};



// SETUP


void setup() {

  // Smaller game window
  // Same 16:9 ratio as the original background
  size(1200, 675);



  // LOAD BACKGROUND
  

  zooScene = loadImage("zooScene.png");



  // CREATE ANIMAL IMAGE ARRAY


  animalImages = new PImage[animalNames.length];



  // LOAD EVERY ANIMAL


  animalImages[0] = loadImage("gorilla.png");

  animalImages[1] = loadImage("flamingo.png");

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
  
  animalImages[19] = loadImage("giraffe.png");
  
  animalImages[20] = loadImage("bear.png");
  
  animalImages[21] = loadImage("seal.png");



  // RANDOMLY SELECT FIRST SIX ANIMALS


  setupAnimals();


 
  // SELECT FIRST TARGET


  newTarget();


 
  // START TIMER


  startTime = millis();
}



// DRAW
// Runs continuously


void draw() {

  background(255);



  // DRAW ZOO BACKGROUND
  
  imageMode(CORNER);

  image(zooScene, 0, 0, width, height);


 
  // CALCULATE TIME
  

  timeLeft =
    gameLength -
    ((millis() - startTime) / 1000);


  // Prevent negative numbers
  if (timeLeft < 0) {
    timeLeft = 0;
  }



  // GAME RUNNING
 

  if (timeLeft > 0 && gameOver == false) {


   
    // DRAW THE SIX ANIMALS


    drawAnimals();


    
    // DRAW SCORE
  

    drawScore();



    // DRAW TIMER
 

    drawTimer();


   
    // DRAW TARGET
 

    drawTargetBox();


  
    // DRAW FEEDBACK


    drawFeedback();

  }


 
  // GAME OVER
  

  else {

    gameOver = true;

    drawGameOver();
  }
}



// RANDOMLY SELECT SIX DIFFERENT ANIMALS


void setupAnimals() {

  for (int enclosure = 0;
       enclosure < NUMBER_OF_ENCLOSURES;
       enclosure++) {


    int randomAnimal =
      int(random(animalNames.length));


    // Keep generating until we find an animal
    // that is NOT already on screen.
    while (animalAlreadyOnScreen(
           randomAnimal,
           enclosure)) {

      randomAnimal =
        int(random(animalNames.length));
    }


    animalsOnScreen[enclosure] =
      randomAnimal;
  }
}



// CHECK WHETHER AN ANIMAL IS ALREADY VISIBLE


boolean animalAlreadyOnScreen(
  int animal,
  int numberToCheck
) {

  for (int i = 0;
       i < numberToCheck;
       i++) {

    if (animalsOnScreen[i] == animal) {

      return true;
    }
  }

  return false;
}


// CHECK ENTIRE SCREEN FOR AN ANIMAL
// Used when replacing a correctly selected animal.

boolean animalCurrentlyVisible(int animal) {

  for (int i = 0;
       i < NUMBER_OF_ENCLOSURES;
       i++) {

    if (animalsOnScreen[i] == animal) {

      return true;
    }
  }

  return false;
}


// DRAW ALL SIX ANIMALS


void drawAnimals() {

  imageMode(CENTER);


  for (int i = 0;
       i < NUMBER_OF_ENCLOSURES;
       i++) {


    int animalIndex =
      animalsOnScreen[i];


    PImage animalImg =
      animalImages[animalIndex];


    // Safety check
    if (animalImg == null) {
      continue;
    }


   
    // ENCLOSURE POSITION
  

    float x =
      enclosureSlots[i][0];

    float y =
      enclosureSlots[i][1];


    
    // MAXIMUM SPACE AVAILABLE
   

    float maxW =
      enclosureSlots[i][2];

    float maxH =
      enclosureSlots[i][3];


  
    // PRESERVE ORIGINAL ANIMAL PROPORTIONS
    //
    // This prevents animals becoming stretched.


    float scaleX =
      maxW / animalImg.width;

    float scaleY =
      maxH / animalImg.height;


    float animalScale =
      min(scaleX, scaleY);


    float drawW =
      animalImg.width *
      animalScale;


    float drawH =
      animalImg.height *
      animalScale;


    
    // DRAW ANIMAL


    image(
      animalImg,
      x,
      y,
      drawW,
      drawH
    );
  }


  imageMode(CORNER);
}



// SCORE BOX


void drawScore() {

  strokeWeight(2);

  stroke(70);

  fill(255, 245);

  rect(
    20,
    20,
    155,
    55,
    12
  );


  fill(30);

  textAlign(
    CENTER,
    CENTER
  );

  textSize(24);

  text(
    "Score: " + score,
    97,
    47
  );
}



// TIMER BOX


void drawTimer() {

  strokeWeight(2);

  stroke(70);

  fill(255, 245);

  rect(
    width - 175,
    20,
    155,
    55,
    12
  );


  // Timer becomes red during final 10 seconds
  if (timeLeft <= 10) {

    fill(210, 30, 30);

  } else {

    fill(30);
  }


  textAlign(
    CENTER,
    CENTER
  );

  textSize(24);

  text(
    "Time: " + timeLeft,
    width - 97,
    47
  );
}



// TARGET BOX


void drawTargetBox() {


  // TARGET PANEL


  float boxW = 310;

  float boxH = 105;

  float boxX =
    width / 2 - boxW / 2;

  float boxY = 555;


  stroke(
    85,
    55,
    25
  );

  strokeWeight(4);

  fill(
    250,
    232,
    190,
    245
  );


  rect(
    boxX,
    boxY,
    boxW,
    boxH,
    18
  );


  // --------------------------------------------------------
  // INSTRUCTION
  // --------------------------------------------------------

  fill(60);

  textAlign(
    CENTER,
    CENTER
  );

  textSize(16);

  text(
    "SPOT THIS ANIMAL",
    width / 2,
    boxY + 19
  );


  
  // TARGET IMAGE


  PImage targetImage =
    animalImages[targetAnimal];


  if (targetImage != null) {

    float maxW = 70;

    float maxH = 50;


    float scaleX =
      maxW / targetImage.width;

    float scaleY =
      maxH / targetImage.height;


    float targetScale =
      min(scaleX, scaleY);


    float targetW =
      targetImage.width *
      targetScale;


    float targetH =
      targetImage.height *
      targetScale;


    imageMode(CENTER);


    image(
      targetImage,
      width / 2 - 80,
      boxY + 67,
      targetW,
      targetH
    );


    imageMode(CORNER);
  }



  // TARGET NAME


  fill(25);

  textAlign(
    CENTER,
    CENTER
  );

  textSize(22);


  text(
    animalNames[targetAnimal],
    width / 2 + 45,
    boxY + 67
  );
}



// DRAW FEEDBACK


void drawFeedback() {

  // Only show feedback temporarily
  if (
    millis() - feedbackTime
    < feedbackDuration
  ) {


    textAlign(
      CENTER,
      CENTER
    );


    
    // TRY AGAIN
   

    if (
      feedback.equals("TRY AGAIN!")
    ) {

      // White background makes the message
      // readable over the zoo.
      noStroke();

      fill(
        255,
        255,
        255,
        225
      );

      rectMode(CENTER);

      rect(
        width / 2,
        height / 2,
        280,
        80,
        18
      );

      rectMode(CORNER);


      // Bold-looking red text
      fill(
        220,
        30,
        30
      );

      textSize(38);

      text(
        "TRY AGAIN!",
        width / 2,
        height / 2
      );
    }


   
    // NICE


    else if (
      feedback.equals("NICE!")
    ) {

      noStroke();

      fill(
        255,
        255,
        255,
        225
      );

      rectMode(CENTER);

      rect(
        width / 2,
        height / 2,
        220,
        80,
        18
      );

      rectMode(CORNER);


      fill(
        0,
        160,
        70
      );

      textSize(40);

      text(
        "NICE!",
        width / 2,
        height / 2
      );
    }


   
    // AMAZING WORK


    else if (
      feedback.equals(
        "AMAZING WORK!"
      )
    ) {

      noStroke();

      fill(
        255,
        255,
        255,
        230
      );

      rectMode(CENTER);

      rect(
        width / 2,
        height / 2,
        360,
        85,
        18
      );

      rectMode(CORNER);


      fill(
        0,
        145,
        65
      );

      textSize(38);

      text(
        "AMAZING WORK!",
        width / 2,
        height / 2
      );
    }
  }
}



// MOUSE CLICK


void mousePressed() {



  // RESTART GAME


  if (gameOver) {

    restartGame();

    return;
  }



  // CHECK EACH OF THE SIX ENCLOSURES


  for (int i = 0;
       i < NUMBER_OF_ENCLOSURES;
       i++) {


    float centreX =
      enclosureSlots[i][0];

    float centreY =
      enclosureSlots[i][1];


    float clickW =
      enclosureSlots[i][2];

    float clickH =
      enclosureSlots[i][3];



    // DID PLAYER CLICK THIS ANIMAL?
  

    if (
      mouseX >
        centreX - clickW / 2 &&

      mouseX <
        centreX + clickW / 2 &&

      mouseY >
        centreY - clickH / 2 &&

      mouseY <
        centreY + clickH / 2
    ) {

      checkAnimal(i);

      return;
    }
  }


  
  // PLAYER CLICKED EMPTY SPACE


  correctStreak = 0;

  feedback =
    "TRY AGAIN!";

  feedbackTime =
    millis();
}



// CHECK SELECTED ANIMAL


void checkAnimal(
  int enclosureClicked
) {


  int clickedAnimal =
    animalsOnScreen[
      enclosureClicked
    ];



  // CORRECT ANIMAL


  if (
    clickedAnimal ==
    targetAnimal
  ) {


    score++;


    correctStreak++;


 
    // FIRST CORRECT ANSWER
  

    if (
      correctStreak == 1
    ) {

      feedback =
        "NICE!";
    }


  
    // TWO OR MORE CORRECT ANSWERS
 

    else {

      feedback =
        "AMAZING WORK!";
    }


    feedbackTime =
      millis();



    // REMOVE FOUND ANIMAL AND REPLACE IT
 

    replaceAnimal(
      enclosureClicked
    );


  
    // SELECT NEW TARGET


    newTarget();
  }



  // WRONG ANIMAL


  else {

    correctStreak = 0;

    feedback =
      "TRY AGAIN!";

    feedbackTime =
      millis();
  }
}



// REPLACE CORRECTLY FOUND ANIMAL


void replaceAnimal(
  int enclosure
) {


  int oldAnimal =
    animalsOnScreen[
      enclosure
    ];


  int replacement =
    int(
      random(
        animalNames.length
      )
    );



  // KEEP SEARCHING UNTIL WE FIND:
  //
  // 1. An animal not already on screen
  // 2. An animal different from the one just removed


  while (
    animalCurrentlyVisible(
      replacement
    )
    ||
    replacement ==
    oldAnimal
  ) {

    replacement =
      int(
        random(
          animalNames.length
        )
      );
  }


 
  // PUT NEW ANIMAL INTO THE SAME ENCLOSURE


  animalsOnScreen[
    enclosure
  ] = replacement;
}



// SELECT NEW TARGET
//
// IMPORTANT:
// Target is selected ONLY from the six animals
// currently visible.


void newTarget() {


  int oldTarget =
    targetAnimal;


  // Choose one of the six enclosure positions
  int randomEnclosure =
    int(
      random(
        NUMBER_OF_ENCLOSURES
      )
    );


  targetAnimal =
    animalsOnScreen[
      randomEnclosure
    ];



  // AVOID SAME TARGET TWICE IN A ROW

  if (
    NUMBER_OF_ENCLOSURES > 1
  ) {

    while (
      targetAnimal ==
      oldTarget
    ) {

      randomEnclosure =
        int(
          random(
            NUMBER_OF_ENCLOSURES
          )
        );


      targetAnimal =
        animalsOnScreen[
          randomEnclosure
        ];
    }
  }
}



// GAME OVER SCREEN


void drawGameOver() {


  
  // DARK TRANSPARENT OVERLAY


  noStroke();

  fill(
    0,
    0,
    0,
    190
  );

  rect(
    0,
    0,
    width,
    height
  );


 
  // TIME'S UP
  

  fill(255);

  textAlign(
    CENTER,
    CENTER
  );


  textSize(52);

  text(
    "TIME'S UP!",
    width / 2,
    height / 2 - 75
  );



  // FINAL SCORE
 

  textSize(34);

  text(
    "Final Score: " + score,
    width / 2,
    height / 2
  );



  // RESTART INSTRUCTION


  textSize(21);

  text(
    "Click anywhere to play again",
    width / 2,
    height / 2 + 70
  );
}



// RESTART GAME


void restartGame() {


  // Reset score
  score = 0;


  // Reset streak
  correctStreak = 0;


  // Remove feedback
  feedback = "";


  feedbackTime = 0;


  // Reset game state
  gameOver = false;



  // GENERATE SIX NEW RANDOM ANIMALS


  setupAnimals();


  
  // GENERATE NEW TARGET
 

  targetAnimal = -1;

  newTarget();



  // RESTART TIMER

  startTime =
    millis();
}
