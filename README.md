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
- Anthony Nosaryev:
	- Finished screenExpression(), whose primary purpose is essentially to facilitate powers/exponents.
	- Implemented del button with CE as its inverse for more versatility.
	- Modified Calculator method buttonClicked() to block illegal uses of pow.

HW Log May 27 2021
- Thomas Yu:
	- Created helper methods evalHelp (to use recursion in eval) and parenthesesCheck (evaluates the parts of the expression enclosed by a set of parentheses).
	- Implemented parenthesesCheck. For now it only works if there are equal amounts of open and closed parentheses. 

CW Log May 28 2021
- Thomas Yu:
	- Created expressionFix() to combine numbers to facilitate calculations.
- Anthony Nosaryev:
	- Began working on PImages sinful, cosmic and tanned, began working on modifying background calculations to allow for modification of background.

HW Log May 28 2021
- Anthony Nosaryev
	- Finished sinful, cosmic and tanned, allowed for background modificatio with make()

HW Log May 31 2021
- Thomas Yu
	- Updated expressionFix() to work with decimal points, add multiplication symbols when implied by parentheses, and add an open parenthesis after every function.
	
HW Log June 1 2021
- Thomas Yu
	- Fixed expressionFix() to not add multiplication symbols between two open or two closed parentheses. 
	- Updated expressionFix() to also add extra closed parentheses to balance out the number of open and closed parentheses.
	- Updated both buttonClicked methods to not allow closed parentheses to be added when it directly follows an open parentheses or when it would be an extra.
