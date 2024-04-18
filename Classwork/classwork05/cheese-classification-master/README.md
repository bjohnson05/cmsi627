This fork reimplements the original program logic generalizing portions of the code and adding additional functionality.

	CLIPS> (load cheese.clp)
	+%%%%%!!!!**+********+*+****$$$
	TRUE
	CLIPS> (reset)
	CLIPS> (run)

	Welcome to the Cheese Classification System which allows
	you to discover cheeses through a series of questions.

	You may enter skip in response to a question to
	skip that question or stop to end the program.

	What type of cheese is it? (semi-soft soft semi-hard hard blue) hard
	How would you describe the texture of the cheese? (crumbly springy firm creamy smooth) skip
	What is the most common use of the cheese? (table-cheese bread cooking pasta salad melting dip dessert dressing pizza cheesecake) dip

	Your last choice eliminated all remaining cheeses.
	You can list the remaining cheeses, skip this question,
	choose a different answer for the last question, or stop.

	Choose an option:  (list skip choose stop) choose
	What is the most common use of the cheese? (table-cheese bread cooking pasta salad melting dip dessert dressing pizza cheesecake) pasta

	The cheese matching your choices is 

	   Name: parmesan
	   Milk Source: cow
	   Type: hard
	   Country: Italy
	   Texture: crumbly
	   Color: white
	   Flavor: strong
	   Aroma: strong
	   Common Usage: pasta

	CLIPS> 

Readme from the original repository:

cheese-classification
=====================

An Expert System designed to classify a variety of cheeses. Implemented in CLIPS

======================================================
  University of the West Indies St Augustine

  COMP 3850 Assignment 2
  812003287 – Jherez Taylor
  812002149 – Dillon Bhola
  811003468 – Aaron Yuk Low

  Cheese Selection

  wichCheese: The Cheese Expert system.
  This system returns the name and details of a cheese to drink with a meal.
======================================================

Implementation Details
======================================================

The system tries to classify cheese based on the criteria that the developers (the Experts in this scenario) selected in
order to guide the user towards identifying a particular cheese.

The classification types that were chosen are as follows:

Cheese Type
Texture
Colour
Flavour
Aroma
Common food pairings

These areas were selected as cheese classification is not a field that experts agree on but these characteristics are the ones most commonly reference. It was determined that these characteristics would yield the best results for identification. In addition to these characteristics, the country of origin and the milk source were included in order to provide additional information to the user upon identification. There are 30 varieties of cheese included in th system. They are as follows:

Gouda
Cheddar
Brie
Parmesan
Mozzarella
Feta
Asiago
Mascarpone
Muenster
Montery Jack
Ricotta
Cottage Cheese
Gorgonzola
Cream Cheese
Danish Blue
Jarlsberg
Provolone
Cantal
Roquefort
Fromage Blanc
Stilton
Explorateur
Reblochon
Castigliano
Caciotta al Tartufo
Innes Button
Brunost
Sapsago
Calcagno
Manchego

The system uses Forward Chaining to derive the results. The user is prompted with a series of questions for each characteristic to determine
the cheese in question. On system start the facts are loaded into the system, this becomes the Knowledge Base. As the questions supplied by
the system are answered, facts that do not meet the characteristic are removed from the Knowledge Base. This is repeated until a solution is found.
Upon identification of a solution the user is given the full details of the cheese in question (the fact of the cheese). If no solution is found
the user is notified of this and the process is terminated.

Usage
======================================================

To use the Expert System, you will need at least CLIPS version 6.3. Use the navigation window to load the file "wichCheese.clp"
Upon loading the file type the command " (reset) " with the brackets or hit "ctrl + E" followed by " (run) " or "ctrl + R".
Answer the questions while keeping the accepted responses in mind. These accepted responses are displayed alongside each question.
In order to reuse the system simply reset and run once again.


Sources
======================================================

Data on the cheese varieties in the system was pulled from www.cheese.com and http://chefsblade.monster.com/training/articles/980-how-to-classify-cheese?page=1.
