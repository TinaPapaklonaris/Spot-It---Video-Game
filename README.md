# Spot-It-Video-Game (Version _6__Spot_It) 
### Note: Version_6__Spot_It is the final version for this prototype. All other files are previous versions
An interactive visual search game developed as part of a university coding project informed by experience supporting students with ADHD. It is designed as an educational prototype to support attention-based learning and sustained attention. 
## Table of Contents
- General Information
- Technologies Used
- Features
- Screenshots
- Setup
- Usage
- Project Status
- Room for Improvement
- Acknowledgements
- Contact
## General Information
### Purpose
Spot It engages players in a fast-paced visual-search game centred on identifying target animals. The player must compare the target shown at the bottom of the screen with six animals positioned around a colourful zoo scene, then click the matching animal before time runs out. The project was designed with school students with ADHD in mind. The central design challenge was to keep players focused on identifying target animals without distractions from inconsistent sprite sizes, unclear instructions, or unreliable feedback.
### How the Game Works
1. Six different animals are randomly chosen from a pool of 22 targets and placed in six fixed enclosure positions.
2. The target panel displays the name and sprite image of one of the six visible animals.
3. The player uses the mouse to select the matching target animal
4. A correct selection increases the score by one, replaces that animal with a different sprite not already on screen, and selects a new visible target.
5. An incorrect selection, or a click outside the six animal enclosures, displays “TRY AGAIN!” without awarding a point.
6. The game ends after 60 seconds, displays the final score and can be restarted by clicking anywhere.
## Technologies Used
- Processing 4.3.1 (Java 17): Main development environment and language used to build and run the game.
- Processing built-in API: Provides drawing, image loading, mouse input, timing and random selection.
- PNG image assets: Supply the zoo background and individually loaded animal sprites.
- Canva AI: Used to generate the illustrated zoo background and cartoon animal assets, but is not required to run the game.
The sketch uses built-in Processing functionality and does not import additional libraries. Python and Pygame were explored during early development but are not required to run this final version.
## Features
- Six zoo animals: Six different animals appear across the illustrated zoo enclosures.
- Varied animal selection: Each round begins with a different selection of animals.
- Find-the-animal challenge: A target panel shows the animal players need to locate.
- Click-to-select gameplay: Players select the animal they believe matches the target.
- Point scoring: Each correct selection earns one point.
- Instant feedback: On-screen messages tell players whether their selection was correct.
- Encouraging streak messages: Consecutive correct answers receive additional positive feedback.
- Animal replacement: Correctly selected animals are replaced with new animals, keeping the search varied.
- Changing targets: A new target appears after each correct selection.
- 60-second countdown: Players race to find as many animals as possible before time runs out.
- Final countdown warning: The timer changes colour during the final 10 seconds.
- End-of-game results: Players can see their final score and start another round.
- Clear zoo layout: Distinct enclosures, proportionally sized animals, and visible score, timer, and target panels support visual clarity.
## Screenshot
<img width="1192" height="699" alt="Screenshot 2026-11-02 at 12 27 08 am" src="https://github.com/user-attachments/assets/be721a98-bffd-404a-bda6-415cb4fc134f" />
Screenshot shows the completed Version 6 zoo layout, with six animals, a score box at the top left, a timer at the top right and the target panel near the bottom centre.
## Setup
### Requirements
- A desktop computer capable of running the Processing application (version 4.3.1).
- Processing in Java mode installed from processing.org/download.
- The Version 6.pde sketch and all 23 required PNG files (one background and 22 animal sprites).
- A mouse or compatible pointing device.
No Python installation, external library or internet connection is required to play after Processing and the image files are installed.
### Launch Instructions
1. Download and install Processing, then select Java mode.
2. Create the Spot_It sketch folder and save the final source as Spot_It.pde inside it.
3. Create a data folder inside Spot_It and add zooScene.png plus all 22 animal PNGs.
4. Open Spot_It.pde in Processing.
4. Click Run (the play/triangle button).
5. The game should open in a 1200 × 675 pixel window and start the 60-second countdown immediately.
## Usage
### Playing Spot It
1. Read the target panel at the bottom of the screen. It shows an animal name and matching image under “SPOT THIS ANIMAL”.
2. Search the six enclosures for the matching animal.
3. Click its enclosure to submit your answer.
4. Check the feedback:
- NICE! means the first answer in a correct-answer streak was successful.
- AMAZING WORK! means two or more consecutive answers were correct.
- TRY AGAIN! means the selected enclosure did not contain the target, or the click was outside the animal regions.
5. Continue searching as each correct selection adds a point, replaces the selected animal and displays a new target.
6. Watch the countdown. The timer turns red during the last 10 seconds.
7. Review your final score when “TIME'S UP!” appears. Click anywhere to begin a new 60-second game.
### Troubleshooting
- Background or animals do not appear: Confirm all PNG files are present in Spot_It/data/ and match the exact filenames listed under Setup.
- Processing cannot open the sketch as expected: Check that the main file is named Spot_It.pde and sits inside a folder named Spot_It.
- An animal appears oversized or overlaps its enclosure: Review the relevant enclosureSlots dimensions. 
- The game starts counting down before you are ready: The timer begins after setup() finishes. To play again, restart from the end screen.
## Project Status
Project is: complete
## Room for Improvement
### Areas of Improvement:
- More precise click detection: Replace rectangular enclosure hitboxes with sprite-aware hit detection, so clicking empty parts of an enclosure does not count as selecting its animal.
- Responsive layout: Adapt the fixed 1200 × 675 coordinates and enclosure positions to different screen sizes.
### To Do:
- A ready screen with a start button so players can begin the countdown when prepared.
- Optional difficulty settings, such as alternative round lengths or animal counts, informed by player feedback.
## Acknowledgments
### Creative Development and Visual Assets
Spot It was developed as a Creative Coding learning project, drawing on experience supporting students with ADHD. Canva AI was used to generate a cohesive collection of illustrated animal assets and the zoo background. The original background was edited to remove embedded animals so that the PNG sprites could be loaded and controlled independently in Processing. 
### Coding references and learning resources
The following resources informed the learning and modification of code concepts; they are not required to run the game:

Baeldung. (n.d.). (2024, January, 8). If-Else Statement in Java. https://www.baeldung.com/java-if-else
Park, J. (2016, January, 20). Images in Processing - a short tutorial. https://www.youtube.com/watch?v=ddtdPO3m1hw
Processing Forum. (n.d.). How to replace an image with another image when mouse is pressed? https://forum.processing.org/two/discussion/25992/how-to-replace-an-image-with-another-image-when-mouse-is-pressed.html
Processing. (n.d.). imageMode(). https://processing.org/reference/imageMode_.html
Processing. (n.d.). millis(). https://processing.org/reference/millis_.html
Processing. (n.d.). random(). https://processing.org/reference/random_.html
Processing. (n.d.). Setup and Draw. https://processing.org/examples/setupdraw.html
Processing. (n.d.). String. https://processing.org/reference/String.html
Processing. (n.d). loadImage(). https://processing.org/reference/loadImage_.html
Reas, C., & Reas, B. (n.d.). Interactivity. Processing. https://processing.org/tutorials/interactivity
Stack Overflow. (n.d.). Score in Processing. https://stackoverflow.com/questions/28180216/score-in-processing
The Coding Train. (2015, July 25). 7.1: Introduction to Functions and Objects - Processing Tutorial. [Video]. YouTube. https://www.youtube.com/watch?v=XCu7JSkgl04
The Coding Train. (2015, July 25). 10.3: An Array of Images - Processing Tutorial. [Video]. Youtube. https://www.youtube.com/watch?v=DPFJROWdkQ8
W3schools. (n.d). Java If ... Else. https://www.w3schools.com/java/java_conditions.asp
## Contact
Project Creator: Tina Papaklonaris
Project: Spot It, Creative Coding 2026







