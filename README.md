EKShakeAnimation
==========

EKShakeAnimation is a litte class for displaying "shaky animations" (yeah, right?). It is inspired by failing to log in on my Mac. The class is made for the [Cappuccino](http://www.cappuccino.org) framework.

It includes the awesome LPViewAnimation class by [Ludwig Pettersson](http://github.com/luddep) but don't try to run the ShakeAnimation with CSS, it fails.

Click here to see a [DEMO](http://elias.klughammer.com/EKShakeAnimation/)


## Installation

Simply import the file in your application's AppController or any other class:

	@import "EKShakeAnimation.j"


## Usage

Usage is simple. Just fire it up and feed it with any view you want:

	var animation = [[EKShakeAnimation alloc] initWithView:someCoolView];
