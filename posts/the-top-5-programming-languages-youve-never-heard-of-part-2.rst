.. title: The top 5 programming languages you've never heard of (part 2)
.. slug: the-top-5-programming-languages-youve-never-heard-of-part-2
.. date: 2015-03-08 17:04:17 UTC-05:00
.. tags: programming, compilers, languages, k, nim, felix, objeck, myrddin
.. link: 
.. description: 
.. type: text

Yesterday, I wrote a post about `the top 5 programming languages you've never heard of <http://kirbyfan64.github.io/posts/the-top-5-programming-languages-youve-never-heard-of.html>`_. Well, since it was kind of short (I didn't have too much time to write), I'm going to put a little more info here.

.. TEASER_END

Nim
===

I enjoy coding in `Nim <http://nim-lang.org/>`_ because it's fun. Nim's goal is seemingly to blur the line between compiled and scripting languages, and it's doing a GREAT job. The compiler is self-hosting, but it's not quite the prime example of a well-written Nim program (it was ported from Object Pascal). A better example is `Nimble <https://github.com/nim-lang/nimble>`_: the Nim package manager. Here's a piece of Nimble's source code:

.. code-block:: nim
   
   proc update(options: Options) =
     ## Downloads the package list from the specified URL.
     ##
     ## If the download is successful, the global didUpdatePackages is set to
     ## true. Otherwise an exception is raised on error.
     let url =
       if options.action.typ == actionUpdate and options.action.optionalURL != "":
         options.action.optionalURL
       else:
         defaultPackageURL
     echo("Downloading package list from " & url)
     downloadFile(url, options.getNimbleDir() / "packages.json")
     echo("Done.")

A longer piece:

.. code-block:: nim
   
   proc parseConfig*(): Config =
     result = initConfig()
     var confFile = getConfigDir() / "nimble" / "nimble.ini"
   
     var f = newFileStream(confFile, fmRead)
     if f == nil:
       # Try the old deprecated babel.ini
       confFile = getConfigDir() / "babel" / "babel.ini"
       f = newFileStream(confFile, fmRead)
       if f != nil:
         echo("[Warning] Using deprecated config file at ", confFile)
  
     if f != nil:
       echo("Reading from config file at ", confFile)
       var p: CfgParser
       open(p, f, confFile)
       while true:
         var e = next(p)
         case e.kind
         of cfgEof:
           break
         of cfgSectionStart: discard
         of cfgKeyValuePair, cfgOption:
           case e.key.normalize
           of "nimbledir":
             # Ensure we don't restore the deprecated nimble dir.
             if e.value != getHomeDir() / ".babel":
               result.nimbleDir = e.value
           of "chcp":
             result.chcp = parseBool(e.value)
           else:
             raise newException(NimbleError, "Unable to parse config file:" &
                                     " Unknown key: " & e.key)
         of cfgError:
           raise newException(NimbleError, "Unable to parse config file: " & e.msg)
       close(p)

My personal coding conventions are quite different, but this still captures some of the elegance of Nim.

Note that the compiler is still a work-in-progress, and a new threading model is going to be implemented soon.

Felix
=====

`Felix <http://felix-lang.org/>`_ is unique. It's a mix of C++, ML, and lots of unique ideas. Here's a nice sample from a toy JSON parser I was writing (this is only the lexer part):

.. code-block:: felix
   
   class JSON {
       typedef LineType = int;
   
       union Value =
           | Object of strdict[Value]
           | Array  of list[Value]
           | String of string
           | Number of double
           | True
           | False
           | Null
           | Error of string * LineType
       ;
   
       union Token =
           | TString of string
           | TNumber of double
           | TLBrace // {
           | TRBrace // }
           | TLBrak  // [
           | TRBrak  // ]
           | TColon  // :
           | TTrue   // true
           | TFalse  // false
           | TNull   // null
           | TEOF
           | TError of string * LineType
       ;
   
       instance Str[Token] {
           fun str(t: Token) => match t with
               | TString ?s => "TString \"" + s + "\""
               | TNumber ?n => "TNumber " + n.str
               | TLBrace    => "TLBrace"
               | TRBrace    => "TRBrace"
               | TLBrak     => "TLBrak"
               | TRBrak     => "TRBrak"
               | TColon     => "TColon"
               | TTrue      => "TTrue"
               | TFalse     => "TFalse"
               | TNull      => "TNull"
               | TEOF       => "TEOF"
               | TError (?s, ?i) => "error at line " + i.str + ": " + s
           endmatch;
       }
   
       proc lex(s: string, line: &LineType, outs: oschannel[Token]) = {
           line <- 1;
   
           proc tok(t: Token) => write $ outs, t;
   
           proc err(s: string) = {
               tok $ TError(s, *line);
               return from lex;
           };
   
           var i = 0.size;
   
           while i < s.len do
               while s.[i].isspace do
                   if s.[i] == "\n" do *line++; done;
                   i++;
                   if i >= s.len goto eof;
               done;
   
               // number
               if s.[i].isnumeric or (i+1 < s.len and s.[i] == "-" and
                                        s.[i+1].isnumeric) do
                   d := s.[i to].double;
                   i += d.str.len;
                   tok $ TNumber d;
               // string
               elif s.[i] == "\"" do
                   i++;
                   var st = "";
                   while i < s.len and s.[i] != "\n" and s.[i] != "\"" do
                       st += s.[i];
                       i++;
                   done;
                   if s.[i] != "\"" call err "unterminated string literal";
                   i++;
                   tok $ TString st;
               // literals
               elif s.[i to i+4] == "true" do
                   tok $ TTrue;
                   i += 4.size;
               elif s.[i to i+5] == "false" do
                   tok $ TFalse;
                   i += 5.size;
               elif s.[i to i+4] == "null" do
                   tok $ TNull;
                   i += 4.size;
               // others
               else
                   match s.[i].str with
                       | "{" => tok TLBrace;
                       | "}" => tok TRBrace;
                       | "[" => tok TLBrak;
                       | "]" => tok TRBrak;
                       | ":" => tok TColon;
                       | _   => err "unknown token";
                   endmatch;
   
                   i++;
               done;
           done;
   
           eof:>
           tok TEOF;
       }   
   }


`Here's <http://felix-lang.org/$/usr/local/lib/felix/felix-latest//share/lib/web/json.flx>`_ a link to Felix's own JSON parser, which is written more nicely than mine is...

It illustrates some nice features, such as schannels (coroutines on steroids). `schannels` are like Go's channels, but not concurrent. Felix has another Go-like channel named `fchannels`, which are concurrent.

Felix also has a nice set of utilities (a web server, a literate programming format, an `alpha-quality graphical config tool <https://github.com/felix-lang/felix/blob/master/src/tools/flx_config.fdoc>`_) and a decently-sized standard library.

Cons? Very little documentation. However, the `mailing list <https://groups.google.com/forum/#!forum/felix-language>`_ is very responsive.

Myrddin
=======

`Myrddin <http://eigenstate.org/myrddin/>`_ is essentially how C would probably look if it were designed right now. Some features:

- Type inference
- Pattern matching
- Go-style slices
- C-style memory management

All in a C-style language. I've been toying with writing a kernel in it, and it's been going very well. I have a lot of hope in Myrddin.

A great example is the `libbio <http://git.eigenstate.org/ori/libbio.git/tree/bio.myr>`_ input/output library. Here's a snippet::
   
   /* 
   writes to as much from `src` as possible to a file,
   returning the number of bytes written.
   */
   const write = {f, src
       std.assert(f.mode & Wr != 0, "File is not in write mode")
       /*
       Tack small writes onto the buffer end. Big ones
       flush the buffer and then go right to kernel.
       */
       if src.len < (f.wbuf.len - f.wend)
           std.slcp(f.wbuf[f.wend:f.wend+src.len], src)
           f.wend += src.len
           -> src.len
       else
           flush(f)
           -> writebuf(f.fd, src)
       ;;
   }

However, the compiler generates VERY slow x64 assembly code at the moment...and only x64 assembly code. I'm working on a C backend, though, but it'll be a while until it's finished.

K
=

`K <http://www.kuro5hin.org/story/2002/11/14/22741/791>`_, along with `Kona <https://github.com/kevinlawler/kona>`_ (an open-source K implementation with bad error messages) is special. It's the result of shoving APL into an ASCII-character world.

Here are some of the idioms at the `Kona wiki <https://github.com/kevinlawler/kona/wiki/Idioms>`_::
   
   shuffle:{x@<>(#x)#1 0} / Perfect shuffle
   mean:{(+/x)%#x} / Arithmetic mean
   fac:*/1+!: / Factorial
   fib:{x{x,+/-2#x}/!2} / Fibonacci
   life:{|/(1;x)&3 4=\:+/,/2{-1 0 1!'\:x}/x} / Conway's Game of Life
   sort:{x@<x} / Sort list
   powerset:{x[&:'!2+&#x]} / Powerset

As you can see, K is very concise. A little too concise. However, as an array-processing language, it's great for iterating over large sequences of data, as `kdb+ <http://kx.com/>`_ has shown. It's also very fast and lean (I'm speaking for kdb+, though, not Kona).

If you can't already tell, the main con is that no one that doesn't know K will be able to read your programs without getting a seizure.

Objeck
======

As I said before, `Objeck <http://www.objeck.org/>`_ is kind of like I envisioned Java to be, other than the (painful) lack of generics.

It's pretty expressive and nice to work with::
   
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

It's very Java-esque but nicer to use. The cons would be the fact that *there is no true native compiler*. Sure, there's a "compiler", but it's like the Java compiler: it compiles to a bytecode that's executed by a VM. It Objeck's case, the VM is `obe`. You also have to manually specify that a function is native for it to be compiled to machine code. There also seem to be to unsigned types or operator overloading. Again.

Others
======

Two honorable, discontinued mentions are `ani <https://code.google.com/p/anic/>`_ and `Alore <http://www.alorelang.org/>`_.

Ani is a programming language that would have sported implicit parallelism and very nice speed. Note that I said *would have*. `A working compiler was never fully completed and the maintainer disappeared <https://code.google.com/p/anic/wiki/Tutorial>`_, so this language may never quite see the light of day. The `project mailing list <https://groups.google.com/forum/#!forum/ani-compiler>`_ is still there, though, so there are hopes that someday, someone may indeed restart the project.

Alore was a language based on the ability to freely mix static and dynamic typing. Although it was a great idea, the language itself seemingly never caught on, and it was abandoned in favor of `mypy <http://www.mypy-lang.org>`_, a project with the same basic idea but implemented as a static type checker for Python.

Summary
=======

That's all! As I said before, I hope one of the languages mentioned caught your eye.
