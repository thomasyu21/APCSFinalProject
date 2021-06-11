[Project Prototype](https://docs.google.com/document/d/1BOmqk9jqNyd38LQKKHu_99XhL30s65ou2DCkFrU8PQA/edit?usp=sharing) | _<-- Click_

## Group:
- Texan Industries

## Members:
- Anthony Nosaryev, Thomas Yu

## Description:
The TI-∞ is a scientific calculator with two distinct modes. The Normal Mode allows the user to interact with a properly functioning scientific calculator. The other, default mode is called the Annoying Mode. When in the Annoying Mode, the TI-∞ does not operate like a normal calculator, despite having the same user interface. The functions no longer match what is displayed on the buttons. Various buttons have their functions changed entirely, with the rest having their functions shuffled throughout the calculator. 

## Instructions
No additional libraries or compiler flags necessary, simply cd into TI/, start TI.pde and Run
- Things to Note
	- The default mode is Annoying Mode ("Annoy"), click the toggle in the top right to swap to the Normal Mode ("Work") (mode you are in will be white).
	- Annoying Mode features are documented in the prototype (see line 1 of readme).
		- Most important to note: Pressing del or CE in annoying mode has a 30% to close the processing window; do not be alarmed, this is intentional!

## CW Log May 24 2021
- Thomas Yu:
	- Created TI.pde, Calculator.pde and Button.pde.
	- Filled in base `TI` and `Button` method headers and instance variables. 
- Anthony Nosaryev: 
	- Filled in base `Calculator` method headers and instance variables.
	- Made `gamma()` and `factorial()` methods.

## HW Log May 24 2021
- Thomas Yu:
	- Worked on `Calculator()` constructor
	- Instantiated all `Calculator` instance variables except for `ArrayList<Button> buttons` due to lack of `Button` implementation.
	- Implemented `getExpression()` and `getExpressionOld()` methods.
	- Outlined basic UI layout in TI.pde.
- Anthony Nosaryev:
	- Implemented `Button()` constructor, fixed instance variable names.
	- Implemented `getIdentity()` and `setIdentity()` methods, ~~the former of which needs testing~~.
	- Publicised Calculator variable annoying for `Button` class.

## HW Log May 25 2021
- Thomas Yu:
	- Instantiated `ArrayList<Button> buttons` and began implementation of the `buttonClicked()` method.
	- Implemented the display method, but the exact location where the expression should be displayed is subject to change.
- Anthony Nosaryev:
	- Elaborated on UI in default mode, added all button labels, implemented new font, implemented `updateButtons()` for toggles and inverse functions.
	- Modified `buttonClicked()` to be more readable through reliability on `mouseClicked()`.
	- Fixed error of expression showing function cap Strings instead of intended identity Strings.
	- Changed `draw()` functionality to no longer constantly loop due to poor graphics quality.

## CW Log May 26 2021
- Thomas Yu:
	- Converted expression from String to `String[]` helped plan its later conversion to `ArrayList<String>`.
	- Fixed percent (%) symbol in `String[][] buttonArray`.
- Anthony Nosaryev:
	- Implemented new font for on-screen expression.
	- Converted expression from String to ArrayList<String> for easier processing.
	- Began working on `screenExpression()`, a method to display the expression with proper spacing and superscripting.

## HW Log May 26 2021
- Anthony Nosaryev:
	- Finished `screenExpression()`, whose primary purpose is essentially to facilitate powers/exponents.
	- Implemented del button with CE as its inverse for more versatility.
	- Modified `buttonClicked()` to block illegal uses of pow.

## HW Log May 27 2021
- Thomas Yu:
	- Created helper methods `evalHelp()` (to use recursion in eval) and `parenthesesCheck()` (evaluates the parts of the expression enclosed by a set of parentheses).
	- Implemented `parenthesesCheck()`. For now it only works if there are equal amounts of open and closed parentheses. 

## CW Log May 28 2021
- Thomas Yu:
	- Created `expressionFix()` to combine numbers to facilitate calculations.
- Anthony Nosaryev:
	- Began working on `PImages sinful, cosmic and tanned`, began working on modifying background calculations to allow for modification of background.

## HW Log May 28 2021
- Anthony Nosaryev
	- Finished `sinful, cosmic and tanned`, allowed for background modificatio with `make()`.

## HW Log May 31 2021
- Thomas Yu
	- Updated `expressionFix()` to work with decimal points, add multiplication symbols when implied by parentheses, and add an open parenthesis after every function.

## HW Log June 1 2021
- Thomas Yu
	- Fixed `expressionFix()` to not add multiplication symbols between two open or two closed parentheses. 
	- Updated `expressionFix()` to also add extra closed parentheses to balance out the number of open and closed parentheses.
	- Updated both `buttonClicked()` methods to not allow closed parentheses to be added when it directly follows an open parentheses or when it would be an extra.
- Anthony Nosaryev
	- Combined `updateButtons()` functionality into `make()`, thereby significantly cleaning up button creation.
	- Combined `buttonClicked()` methods for processing speed and cleanliness
	- Implemented `scramble()` to shuffle button values in Annoying Mode.

## CW Log June 2 2021
- Thomas Yu
	- Fixed oversights with openParen and closeParen, particularly after deleting parentheses and replacing them.
- Anthony Nosaryev
	- Changed cosmic.jpg to something nicer, made anndef.jpg

## HW Log June 2 2021
- Anthony Nosaryev
	- Reworked TI to display all features relative to the size rather than at specific coordinates.

## HW Log June 3 2021
- Thomas Yu
	- Implemented the `evalHelp()` method.
	- Updated `expressionFix()` to account for negative numbers, Ans, pi, and e.
- Anthony Nosaryev
	- Implemented `ans` and `ansOld` instance variables for history purposes.
	- Created `cut()` method to attempt to alleviate floating point errors with some success.

## HW Log June 4 2021
- Anthony Nosaryev
	- Fixed errors with `ans` and `ansOld` displaying, other general calculator quirks.
	- Moved instance `booleans annoying, rad and inv` (essential calculator statuses) to TI.pde for uiversal access.
	- Simplified `coords()` and `expDebug()` to only the console.

## HW Log June 6 2021
- Thomas Yu
	- Began implementing annoying mode functions (Rad|Deg swap, !, and %).

## CW Log June 7 2021
- Thomas Yu
	- Implemented annoying mode functions for `ln()`, history not saving, and the entire line clearing.
- *Anthony Nosaryev was absent taking an AP test.*

## HW Log June 8 2021
- Thomas Yu
	- Fixed some issues introduced by annoying mode functions to allow calculations to properly occur.
	- Fixed issues with unwanted multiplication symbols being added into the expression.
- Anthony Nosaryev
	- Implemented most of the remaining annoying mode features (! amplification, log/ln backgrounds, % output).
	- Worked on (but ultimately scrapped) normal mode evaluation delay and processing text.

## HW Log June 9 2021
- Thomas Yu
	- Worked on how negative numbers are identified.
	- Made an ( follow E.

## HW Log June 10 2021
- Anthony Nosaryev
	- Created Previous Expression button.
	- Added a highlight to buttons when pressed.
	- Fixed `gamma()` functionality, changed input to float instead of double.
