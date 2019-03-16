*************************************
README
*************************************

This README is a bit unique in that I'm not really describing how to run or use the program, but rather why I made the 
decisions that I did. That being said there are some things you should know about the program for testing purposes:
	1) I did not include Gemfile to specify dependencies, namely because there is only one: Rspec for running unit tests
	2) My program should be runnable either by passing input from a file like so:
		ruby main.rb < example_input.txt
	   or by piping it to the program (which is really semantically the same as the above example):
	   	cat example_input.txt | ruby main.rb
	   or by passing the file name as an argument
	   	ruby main.rb example_input.txt

That being said, let's move on to the justifications of my decisions. To start off with I won't be covering every line
of code I wrote here in detail. I anticipated that some of the decisions I made about how to write particular functions
might peak your curiosity so I included rationale commentary above those segments. Rather I will discuss at a high level the
following things:
	1) Language Choice
	2) Hierarchial Structure
	3) Architecture/Class Specific responsibilities

You may still have questions after these explanations. If you would like to ask them I would encourage doing so in a follow up
interview.

Hierarchial Structure:
		I chose the hierarchial structure of a gem, because I believe that this code functions much like a gem does. 
	A small piece of software that solves a very specific task. Thus I have a lib/ directory which holds the central module
	DrivingHistoryAnalyzer that requires in all its local dependencies and those dependecies are namespaced in the
	lib/driving_history_analyzer/ folder. There is also a spec/ directory to hold all of the Rspec unit tests for testing 
	the code.
		What you may find somewhat curious is that I chose to separate the main.rb file from the DrivingHistoryAnalyzer.
	This is because a gem is normally not an executable, but rather more like library of code that you can include in 
	your application. I separated the actual task of invoking the module based on input from the command line into the
	main.rb in order to keep these distinctions of duty clear as well as to make unit testing the modules main function
	'analyze' much easier.

Architecture/Class Specific Responsibilities:
		I chose to use objects to represent the data, namely Driver and Trip. This is because I find object/classes
	to be more flexible and maintanable in general than structs. There are multiple justifications for this opinion, but
	one for the sake of argument is that Classes generally have a understood layout across programs with specific methods
	that are commonly overidden to serve a specific pupose i.e. == or to_s.
		I created the AcceptedCommands module to roughly serve the same purpose as an enum; to keep the command constants in a separate location where they can be maintained more easily while also preserving the readability of the code due
	to their specific naming conventions.
		The Parser module was really where I housed most of the logic to actually separate the input data into the
	above mentioned Objects. I left this as a module because really there was no need for it to be instantiated and because
	it mostly stood on its own, providing methods to do work, but didn't have any data housing responsibilities.

