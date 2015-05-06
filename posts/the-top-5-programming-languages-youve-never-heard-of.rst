.. title: The top 5 programming Languages you've never heard of
.. slug: the-top-5-programming-languages-youve-never-heard-of
.. date: 2015-03-07 18:56:29 UTC-06:00
.. tags: programming, compilers, languages, k, nim, felix, objeck, myrddin
.. link: 
.. description: 
.. type: text

Lately, there's been a large surge in new programming languages as projects such as `Rust <http://www.rust-lang.org/>`_ have been taking the spotlight and showing lots of promise. However, there are some programming languages few have heard of that deserve to be more popular. Here's a brief listing of some of my favorite languages that aren't common sights.

.. TEASER_END

Nim
===

`Nim <http://nim-lang.org/>`_ is more popular than most languages on this list. It recently acquired `corporate backing from 3DICC <http://forum.nim-lang.org/t/870>`_ and is under very active development. Here's a factorial program in Nim:

.. code-block:: nim

   import unsigned, strutils
   
   proc fac(n: int): uint64 =
     if n <= 1:
       return n.uint64
     else:
       return n.uint64() * fac(n-1)
   
   stdout.write "Number: "
   var number = stdin.readLine.parseInt
   
   if number < 0:
     echo "Number must be greater than 0"
     quit QuitFailure
   
   echo fac number

Felix
=====

`Felix <http://felix-lang.org/>`_ is an experimental programming language that covers most problems in a unique way. It's very functional and has great coroutine support, a nice threading system, and a grammar defined in user space (a.k.a. you can extend the grammar inside your own programs). You run your files just like a scripting language::
   
   $ flx my_prog.flx arg1 arg2

Here's a factorial program, this time in Felix:

.. code-block:: felix
   
      // Recursive factorial
   fun fac(n: int) =>
       if n <= 1
       then n.ulong
       else n.ulong * fac(n-1)
   ;
   
   // Read a number from stdin
   print "Number: ";
   var number = cstdin.readln.int;
   
   if number < 0 do
       println "Number must be greater than 0";
       System::exit(1);
   done;
   
   // Print factorial
   println $ fac number;

Myrddin
=======

`Myrddin <http://eigenstate.org/myrddin/>`_ is, to quote the web page, "A toy with delusions of usefulness." Well, it's pretty useful to me. It's my new favorite low-level language (yes, above Rust). Following is yet another factorial program, but this one in, guess what, Myrddin::
   
   use std
   use bio
   
   const fac = {n: int -> uint64
       if n <= 1
           -> n castto (uint64)
       else
           -> (n castto (uint64)) * fac(n-1)
       ;;
   }
   
   const main = {
       var stdin = bio.mkfile(0, bio.Rd)
       std.put("Number: ")
       match bio.readln(stdin)
       | `std.Some s:
           match std.intparse(std.strstrip(s))
           | `std.Some n:
               if n < 0
                   std.put("Number must be greater than 0\n")
                   std.exit(1)
               ;;
               std.put("%l\n", fac(n))
           | `std.None:
               std.put("error parsing integer input\n")
               std.exit(1)
           ;;
       | `std.None:
           std.put("error reading input\n")
           std.exit(1)
       ;;
   }

Notice the explicit error handling.

K
=

`K <http://www.kuro5hin.org/story/2002/11/14/22741/791>`_ (and it's open source counterpart, `Kona <https://github.com/kevinlawler/kona>`_) is a very unique language. Here's a factorial function in K::
   
   fac:{*/1+!x}

If that isn't readable enough, here's another version::
   
   fac:*/1+!:

You can now call it::
   
   fac[4]

K is actually surprisingly readable once you learn it...provided you don't get a nervous breakdown and blow your eyes out in the process. :)

Objeck
======

`Objeck <http://www.objeck.org/>`_ is kind of how Java should've been. Here's a factorial in Objeck (the language has a factorial function built in, but this is a custom one)::
   
   class Factorial {
       function : native : Factorial(n : Int) ~ Int {
           if (n <= 1) {
               return n;
           } else {
               return n * Factorial(n-1);
           };
       }
   
       function : Main(args : String[]) ~ Nil {
           "Number: "->Print();
           number := IO.Console->ReadString()->ToInt();
           if (number < 0) {
               "Number must be greater than 0"->PrintLine();
               Runtime->Exit(1);
           };
           Factorial(number)->PrintLine();
       }
   }

Objeck has no long/unsigned types, so I just used the basic `Int` type.

Final notes
===========

I hope one of the languages here catches your eye. Just note that Myrddin and Felix are still VERY experimental.
