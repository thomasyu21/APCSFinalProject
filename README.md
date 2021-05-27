https://docs.google.com/document/d/1BOmqk9jqNyd38LQKKHu_99XhL30s65ou2DCkFrU8PQA/edit?usp=sharing

Group: Texan Industries

Members: Anthony Nosaryev, Thomas Yu
	
The TI-∞ is a scientific calculator with two distinct modes. The Normal Mode allows the user to interact with a properly functioning scientific calculator. The other, default mode is called the Annoying Mode. When in the Annoying Mode, the TI-∞ does not operate like a normal calculator, despite having the same user interface. The functions no longer match what is displayed on the buttons. Various buttons have their functions changed entirely, with the rest having their functions shuffled throughout the calculator. 

CW Log May 24 2021
- Thomas Yu:
	- Created TI.pde, Calculator.pde and Button.pde.
	- Filled in base TI and Button method headers and instance variables. 
- Anthony Nosaryev: 
	- Filled in base Calculator method headers and instance variables.
	- Made gamma() and factorial() methods.

HW Log May 24 2021
- Thomas Yu:
	- Worked on Calculator() constructor
	- Instantiated all Calculator instance variables except for ArrayList<Button> buttons due to lack of Button implementation.
	- Implemented getExpression() and getExpressionOld() methods.
	- Outlined basic UI layout in TI.pde.
- Anthony Nosaryev:
	- Implemented Button() constructor, fixed instance variable names.
	- Implemented getIdentity() and setIdentity() methods, the former of which needs testing.
	- Publicised Calculator variable annoying for Button class.

HW Log May 25 2021
- Thomas Yu:
	- Instantiated ArrayList<Button> buttons and began implementation of the buttonClicked method.
	- Implemented the display method, but the exact location where the expression should be displayed is subject to change.
- Anthony Nosaryev:
	- Elaborated on UI in default mode, added all button labels, implemented new font, implemented updateButtons() for toggles and inverse functions.
	- Modified buttonClicked() to be more readable through reliability on mouseClicked().
	- Fixed error of expression showing function cap Strings instead of intended identity Strings.
	- Changed draw() functionality to no longer constantly loop due to poor graphics quality.

CW Log May 26 2021
- Thomas Yu:
	- Converted expression from String to String[] helped plan its later conversion to ArrayList<String>.
	- Fixed percent (%) symbol in Calculator String[][] buttonArray.
- Anthony Nosaryev:
	- Implemented new font for on-screen expression.
	- Converted expression from String to ArrayList<String> for easier processing.
	- Began working on screenExpression(), a method to display the expression with proper spacing and superscripting.
	
HW Log May 26 2021
- Thomas Yu:
- Anthony Nosaryev:
	- Finished screenExpression(), whose primary purpose is essentially to facilitate powers/exponents.
	- Implemented del button with CE as its inverse for more versatility.
	- Modified Calculator method buttonClicked() to block illegal uses of pow.
