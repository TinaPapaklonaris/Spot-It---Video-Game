// Spot It - Zoo Animal Search Game
// Processing - Java


// References - The following resources informed my understanding and application of coding concepts and functions throughout the development of Spot It. Code has been modified from:
// Baeldung. (n.d.). (2024, January, 8). If-Else Statement in Java. https://www.baeldung.com/java-if-else
// Park, J. (2016, January, 20). Images in Processing - a short tutorial. https://www.youtube.com/watch?v=ddtdPO3m1hw
// Processing Forum. (n.d.). How to replace an image with another image when mouse is pressed? https://forum.processing.org/two/discussion/25992/how-to-replace-an-image-with-another-image-when-mouse-is-pressed.html
// Processing. (n.d.). imageMode(). https://processing.org/reference/imageMode_.html
// Processing. (n.d.). millis(). https://processing.org/reference/millis_.html
// Processing. (n.d.). random(). https://processing.org/reference/random_.html
// Processing. (n.d.). Setup and Draw. https://processing.org/examples/setupdraw.html
// Processing. (n.d.). String. https://processing.org/reference/String.html
// Processing. (n.d). loadImage(). https://processing.org/reference/loadImage_.html
// Reas, C., & Reas, B. (n.d.). Interactivity. Processing. https://processing.org/tutorials/interactivity
// Stack Overflow. (n.d.). Score in Processing. https://stackoverflow.com/questions/28180216/score-in-processing
// The Coding Train. (2015, July 25). 7.1: Introduction to Functions and Objects - Processing Tutorial. [Video]. YouTube. https://www.youtube.com/watch?v=XCu7JSkgl04
// The Coding Train. (2015, July 25). 10.3: An Array of Images - Processing Tutorial. [Video]. Youtube. https://www.youtube.com/watch?v=DPFJROWdkQ8
// W3schools. (n.d). Java If ... Else. https://www.w3schools.com/java/java_conditions.asp



// Images 

PImage zooScene;
PImage[] animalImages;

// Animal Names
// Order matching image loading order

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
  "SEAL"          // 21
};


// Game Settings

int NUMBER_OF_ENCLOSURES = 6;

int score = 0;

int gameLength = 60;

int startTime;

int timeLeft;

boolean gameOver = false;


// Animals currently on screen

int[] animalsOnScreen =
  new int[NUMBER_OF_ENCLOSURES];

// Current target

int targetAnimal = -1;

// Feedback

String feedback = "";

int feedbackTime = 0;

int feedbackDuration = 1000;

int correctStreak = 0;

// Enclosure Positions
//
// Format
//
// { centreX, centreY, maximumWidth, maximumHeight }
//
// The X and Y values represent the CENTRE of the animal.

float[][] enclosureSlots = {

  // 0 - Top left enclosure
  // Large grass enclosure on left
  {
    185,    // centre X
    165,    // centre Y
    205,    // maximum animal width
    145     // maximum animal height
  },

  // 1 - Top centre enclosure
  // Oval grass enclosure behind the pathway
  {
    680,
    145,
    220,
    135
  },

  // 2 - Top right enclosure
  // Grass enclosure underneath trees
  {
    1015,
    220,
    195,
    140
  },

  // 3 - Centre enclosure
  // Circular island containing trees / stumps
  {
    600,
    350,
    175,
    130
  },

  // 4 - Bottom left enclosure
  // Large grass enclosure
  {
    215,
    485,
    210,
    145
  },

  // 5 - Bottom right enclosure
  // Rocky / water enclosure
  {
    995,
    465,
    190,
    140
  }
};

// Setup

void setup() {

  // Same 16:9 ratio as zoo background
  size(1200, 675);
  
// Load background

  zooScene =
    loadImage("zooScene.png");
    
// Creating animal array

  animalImages =
    new PImage[animalNames.length];
    
// Loading animal png files from sketch folder

  animalImages[0] =
    loadImage("gorilla.png");

  animalImages[1] =
    loadImage("flamingo.png");

  animalImages[2] =
    loadImage("peacock.png");

  animalImages[3] =
    loadImage("crocodile.png");

  animalImages[4] =
    loadImage("koala.png");

  animalImages[5] =
    loadImage("parrot.png");

  animalImages[6] =
    loadImage("snake.png");

  animalImages[7] =
    loadImage("cheetah.png");

  animalImages[8] =
    loadImage("meerkat.png");

  animalImages[9] =
    loadImage("toucan.png");

  animalImages[10] =
    loadImage("monkey.png");

  animalImages[11] =
    loadImage("panda.png");

  animalImages[12] =
    loadImage("owl.png");

  animalImages[13] =
    loadImage("kangaroo.png");

  animalImages[14] =
    loadImage("zebra.png");

  animalImages[15] =
    loadImage("elephant.png");

  animalImages[16] =
    loadImage("hippo.png");

  animalImages[17] =
    loadImage("lion.png");

  animalImages[18] =
    loadImage("turtle.png");
    
  animalImages[19] =
    loadImage("giraffe.png");
    
  animalImages[20] =
    loadImage("bear.png");
    
  animalImages[21] =
    loadImage("seal.png");

  setupAnimals();
  
  // Select first target

  newTarget();
  
  // Start timer

  startTime = millis();
}

// Draw

void draw() {

  background(255);

  // Draw zoo scene

  imageMode(CORNER);

  image(
    zooScene,
    0,
    0,
    width,
    height
  );

// Calculate timer

  timeLeft =
    gameLength -
    ((millis() - startTime) / 1000);

// Game running

  if (timeLeft < 0) {

    timeLeft = 0;
  }

  if (
    timeLeft > 0 &&
    gameOver == false
  ) {

    drawAnimals();

    drawScore();

    drawTimer();

    drawTargetBox();

    drawFeedback();

  }


// Game over

  else {

    gameOver = true;

    drawGameOver();
  }
}

// Randomising animal selection

void setupAnimals() {

  for (
    int enclosure = 0;
    enclosure < NUMBER_OF_ENCLOSURES;
    enclosure++
  ) {

    int randomAnimal =
      int(
        random(
          animalNames.length
        )
      );


    // Prevent duplicate animals
    while (
      animalAlreadyOnScreen(
        randomAnimal,
        enclosure
      )
    ) {

      randomAnimal =
        int(
          random(
            animalNames.length
          )
        );
    }


    animalsOnScreen[enclosure] =
      randomAnimal;
  }
}

// Checking for duplicates during inital setup

boolean animalAlreadyOnScreen(
  int animal,
  int numberToCheck
) {

  for (
    int i = 0;
    i < numberToCheck;
    i++
  ) {

    if (
      animalsOnScreen[i] ==
      animal
    ) {

      return true;
    }
  }

  return false;
}

// Check whether an animal is currently visible

boolean animalCurrentlyVisible(
  int animal
) {

  for (
    int i = 0;
    i < NUMBER_OF_ENCLOSURES;
    i++
  ) {

    if (
      animalsOnScreen[i] ==
      animal
    ) {

      return true;
    }
  }

  return false;
}

// Draw animal sprites

void drawAnimals() {

  imageMode(CENTER);


  for (
    int i = 0;
    i < NUMBER_OF_ENCLOSURES;
    i++
  ) {

    // Find which animal belongs in this enclosure

    int animalIndex =
      animalsOnScreen[i];


    PImage animalImg =
      animalImages[animalIndex];


    if (animalImg == null) {

      continue;
    }

    // Centre position of enclosure

    float centreX =
      enclosureSlots[i][0];

    float centreY =
      enclosureSlots[i][1];

    // Available enclosure size
    
    float maxW =
      enclosureSlots[i][2];

    float maxH =
      enclosureSlots[i][3];

    // Calculate proportional scale

    float widthScale =
      maxW /
      animalImg.width;


    float heightScale =
      maxH /
      animalImg.height;


    // Use smaller value so sprite remains inside enclosure
    float animalScale =
      min(
        widthScale,
        heightScale
      );
      
    // Enlarging scale  
    animalScale *= 1.08;
    
    // Sprite dimensions
    float drawW =
      animalImg.width *
      animalScale;


    float drawH =
      animalImg.height *
      animalScale;
      
    // Draw sprite directly from its centre
    
    image(
      animalImg,
      centreX,
      centreY,
      drawW,
      drawH
    );
  }


  imageMode(CORNER);
}

// Draw score

void drawScore() {

  strokeWeight(2);

  stroke(60);

  fill(
    255,
    255,
    255,
    245
  );


  rect(
    20,
    20,
    155,
    55,
    12
  );


  fill(25);


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

// Draw timer

void drawTimer() {

  strokeWeight(2);

  stroke(60);


  fill(
    255,
    255,
    255,
    245
  );


  rect(
    width - 175,
    20,
    155,
    55,
    12
  );


  // Red timer when 10 seconds remain
  if (
    timeLeft <= 10
  ) {

    fill(
      210,
      30,
      30
    );

  } else {

    fill(25);
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
// Draw target box

void drawTargetBox() {

  // Target box position

  float boxW = 310;

  float boxH = 100;

  float boxX =
    width / 2 -
    boxW / 2;

  float boxY = 560;
  
  // Target panel
  
  stroke(
    85,
    55,
    25
  );

  strokeWeight(4);

  // Instruction
  
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

  fill(50);


  textAlign(
    CENTER,
    CENTER
  );


  textSize(16);


  text(
    "SPOT THIS ANIMAL",
    width / 2,
    boxY + 18
  );
  
  // Target image
  
  PImage targetImage =
    animalImages[
      targetAnimal
    ];


  if (
    targetImage != null
  ) {

    float targetMaxW = 75;

    float targetMaxH = 55;


    float targetScaleX =
      targetMaxW /
      targetImage.width;


    float targetScaleY =
      targetMaxH /
      targetImage.height;


    float targetScale =
      min(
        targetScaleX,
        targetScaleY
      );


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
      boxY + 65,
      targetW,
      targetH
    );


    imageMode(CORNER);
  }


  // Taregt name 
  fill(20);


  textAlign(
    CENTER,
    CENTER
  );


  textSize(22);


  text(
    animalNames[
      targetAnimal
    ],
    width / 2 + 45,
    boxY + 65
  );
}

// Draw feedback 

void drawFeedback() {


  // Only show message temporarily
  if (
    millis() -
    feedbackTime <
    feedbackDuration
  ) {


    textAlign(
      CENTER,
      CENTER
    );

    // Wrong answer

    if (
      feedback.equals(
        "TRY AGAIN!"
      )
    ) {


      // White panel behind message
      rectMode(CENTER);

      noStroke();


      fill(
        255,
        255,
        255,
        235
      );


      rect(
        width / 2,
        height / 2,
        300,
        90,
        20
      );


      rectMode(CORNER);


      // Red message
      fill(
        220,
        25,
        25
      );


      textSize(40);


      text(
        "TRY AGAIN!",
        width / 2,
        height / 2
      );
    }

    // First correct answer

    else if (
      feedback.equals(
        "NICE!"
      )
    ) {


      rectMode(CENTER);

      noStroke();


      fill(
        255,
        255,
        255,
        235
      );


      rect(
        width / 2,
        height / 2,
        230,
        90,
        20
      );


      rectMode(CORNER);


      fill(
        0,
        160,
        70
      );


      textSize(42);


      text(
        "NICE!",
        width / 2,
        height / 2
      );
    }

    // Two of more correct answers

    else if (
      feedback.equals(
        "AMAZING WORK!"
      )
    ) {


      rectMode(CENTER);

      noStroke();


      fill(
        255,
        255,
        255,
        235
      );


      rect(
        width / 2,
        height / 2,
        390,
        90,
        20
      );


      rectMode(CORNER);


      fill(
        0,
        150,
        65
      );


      textSize(40);


      text(
        "AMAZING WORK!",
        width / 2,
        height / 2
      );
    }
  }
}


// Mouse click

void mousePressed() {

  
  // Restart game
  
  if (
    gameOver
  ) {

    restartGame();

    return;
  }

  // Check all six animals

  for (
    int i = 0;
    i < NUMBER_OF_ENCLOSURES;
    i++
  ) {


    float centreX =
      enclosureSlots[i][0];


    float centreY =
      enclosureSlots[i][1];


    float clickW =
      enclosureSlots[i][2];


    float clickH =
      enclosureSlots[i][3];

    // Check if click is inside animal area

    if (

      mouseX >
      centreX -
      clickW / 2

      &&

      mouseX <
      centreX +
      clickW / 2

      &&

      mouseY >
      centreY -
      clickH / 2

      &&

      mouseY <
      centreY +
      clickH / 2

    ) {


      checkAnimal(i);

      return;
    }
  }

  // If clicked empty area or incorrect target
  
  correctStreak = 0;


  feedback =
    "TRY AGAIN!";


  feedbackTime =
    millis();
}

// Check selected animal

void checkAnimal(
  int enclosureClicked
) {


  int clickedAnimal =
    animalsOnScreen[
      enclosureClicked
    ];
    
// Correct target selected

  if (
    clickedAnimal ==
    targetAnimal
  ) {

    // Increase score
    score++;

    // Increase correct streak
    correctStreak++;


    // First correct target
    
    if (
      correctStreak == 1
    ) {

      feedback =
        "NICE!";

    }

    // Second or more consective correct targets

    else {

      feedback =
        "AMAZING WORK!";
    }


    feedbackTime =
      millis();

    // Remove correctly selected aniaml and replace it 

    replaceAnimal(
      enclosureClicked
    );
    
    // Generate new target
    
    newTarget();
  }
  
  // Incorrect target selected
  
  else {


    correctStreak = 0;


    feedback =
      "TRY AGAIN!";


    feedbackTime =
      millis();
  }
}

// Replace found animal

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

  // Find an animal that:
  // 1. Is not already visible
  // 2. Is not the animal just removed

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

  // Insert new animal into same enclosure

  animalsOnScreen[
    enclosure
  ] =
    replacement;
}

// Choose new target

void newTarget() {

  // Choose one of six visible enclosures
  
  int oldTarget =
    targetAnimal;

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

  // Prevent same target twice

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


// Game over screen
void drawGameOver() {

  // Dark overlay

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

  // Game over text

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

  // Final score

  textSize(34);


  text(
    "Final Score: " + score,
    width / 2,
    height / 2
  );


  // Restart

  textSize(21);


  text(
    "Click anywhere to play again",
    width / 2,
    height / 2 + 70
  );
}


// Restart game

void restartGame() {

  // Reset score

  score = 0;

  // Reset streak

  correctStreak = 0;

  // Reset feedback

  feedback = "";


  feedbackTime = 0;

  // Reset game state

  gameOver = false;

  // Generate six new random animals 

  setupAnimals();

  // Generate new target

  targetAnimal = -1;


  newTarget();

  // Restart 60 second timer

  startTime =
    millis();
}
