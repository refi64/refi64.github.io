.. title: Functional programming isn't the answer to all problems (and neither is OOP)
.. slug: functional-programming-isnt-the-answer-to-all-problems-and-neither-is-oop
.. date: 2015-05-17 16:59:00 UTC-05:00
.. tags: 
.. link: 
.. description: 
.. type: text

I like functional programming. Being a big fan of Python and C++, it took a while to get used to functional languages like Haskell and Felix (my personal favorite FP language). I started out with *Learn You a Haskell for Great Good!* and then started toying with OCaml and Felix. I stuck with Felix and ditched OCaml because I just didn't like it.

However, it isn't the solution to the world's issues. People used to think OOP was the solution to everything. They started shoving every freaking thing on earth in a class and adding useless methods. Then they realized that Java sucked. Now, everyone seems to think that FP is going to take over the world. I disagree. Why?

.. TEASER_END

Certain programs are easier to extend with OOP
==============================================

I *love* Norman Ramsey's Stack Overflow answers because they're from a functional programming advocate who knows that it's not the solution to all issues. Take his answer to `Functional programming vs Object Oriented programming <http://stackoverflow.com/a/2079678/2097780>`_. Basically, OOP languages are good when the operations on things stay the same, and you just add new things. Functional languages are good when the things stay the same and you're constantly adding new operations.

It has bitten me several times in functional languages before when I forgot to update a pattern match someone to make up for a new field in my algebraic data type. Same thing for OOP: I've had problems when adding new algorithms/transformations on OOP objects and end up forgetting something somewhere, only to get a 200-template error message about instantiating some ABC somewhere (C++) or a ``NotImplementedError`` (Python). Neither paradigm solves both issues.

IMO, build systems are good with OOP. You tend to add support for, say, extra C++ compilers more than you add a new compilation command (how many different ways to do the same thing are there?).

It can be hard to predict performance
=====================================

This is more an issue with lazy languages (e.g. Haskell) and tracing JITs (like PyPy) than strict languages (like C++, Felix, and ML).

Basically, it's hard to predict how a program will perform. This innocent function:

.. code-block:: haskell
   
   f = foldl1 (+)

will explode if given a list too long; the stack will be exhausted. Or it will just take forever. You need to use ``foldl1'`` in that case, which is strict.

In imperative programming, this isn't even a problem:

.. code-block:: c++
   
   std::vector<int> v(10000000, 1);
   std::cout << std::accumulate(v.begin(), v.end(), 0, std::plus<int>{}) << std::endl;

I had this code in all:

Haskell:

.. code-block:: haskell
   
   f = foldl1 (+)
   
   main = print . f $ replicate 10000000 1

.. note:: I know about ``sum``, but using it distracts from the point of this whole post.

C++:

.. code-block:: c++

   #include <functional>
   #include <algorithm>
   #include <iostream>

   using namespace std;

   int main() {
       vector<int> v(10000000, 1);
       cout << accumulate(v.begin(), v.end(), 0, plus<int>()) << endl;
   }

The Haskell version gives a stack overflow after 1.7 seconds. Changing ``foldl1`` to ``foldl1'`` fixes it, but it still takes 0.184s. C++ version? 0.022s.

Now, I'm not saying that Haskell is slow; it can actually be quite fast. I'm just saying that it can be hard to predict performance, where your stack will explode, or where you can blow threw several gigs of RAM.

It's worth saying again that this is only really bad for lazy languages, so Felix and OCaml shouldn't suffer from it as badly. Rust also doesn't suffer from it; the program I wrote took 0.04s.

It's not magic
==============

I keep saying it: it's not going to make everyone happy, create world peace, make Windows actually work, and make you 6 meals a day. I like FP for certain situations. Haskell is fun (and makes you feel smart!), Felix is just awesome, and Rust is neat.

Same thing goes for OOP. I'm not going to try to tackle those issues because 20k blog posts already have.

I'm not bashing FP; I'm just saying it isn't perfect. Everyone loves it right now. In 20 years, someone's going to find something wrong. Then everyone's going to hate it and start using `concatenative programming <http://evincarofautumn.blogspot.com/2012/02/why-concatenative-programming-matters.html>`_. Until everyone realizes it sucks and starts using the true source of happiness: `tape-based programming <http://en.wikipedia.org/wiki/Brainfuck>`_.

What about mixing them?
=======================

This is hard. In the end, one is always going to be better supported than the other.

For instance, you can write FP-like programs in Python. But Python has a rich object system, not a pattern-matching system. Therefore, Python seems to lean towards OOP. Same thing for C++.

Felix has objects, but they end up compiling down to closures. In reality, Felix leans towards FP.

Scala ends up leaning towards OOP, if not just because most of the Java libraries you'll end up using from Scala use classes.

Some languages that claim that they use FP, like K, seem to be more procedural in nature, too.

Again, there's no perfect answer. If programming was a solved problem, I'm not sure what would happen, because we haven't reached that point, and we probably never will.

Also, I'm not saying that moving forward like this is bad. Imagine what would happen if we were still writing everything in COBOL and Fortran!

But it's just not all cut out. Trying to mix them perfectly doesn't work out, either...

`IT'S NO USE!!!! <https://youtu.be/kCHVW65YLJs?t=36s>`_

**EDIT:** Apparently, this post is very controversial:

.. image:: https://dl-web.dropbox.com/get/contr_web.png?_subject_uid=200677686&w=AABUq-WzkWaCgzQmcibavrxBqBnnqHFlvPwDBDMTDnVEZQ&dl=1

:/
