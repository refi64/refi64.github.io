.. title: Implementing a (sort of) generic, (sort of) type-safe array in C
.. slug: implementing-a-sort-of-generic-sort-of-type-safe-arrayin-c
.. date: 2015-11-28 16:48:13 UTC-06:00
.. tags: 
.. link: 
.. description: 
.. type: text

I've been using C for a project I've been working on, and one thing I find
annoying are manually-managed arrays. Ever since watching `Bjarne Stroustrup's
talk on linked lists <https://www.youtube.com/watch?v=YQs6IC-vgmo>`_, I try to
avoid them as much as possible. Therefore, I prefer using a container roughly
equivalent to C++'s vector.

The obvious thing to do here would be to use something like `glib's GArray type
<https://www.youtube.com/watch?v=YQs6IC-vgmo>`_ or `qlibc's qvector type
<http://wolkykim.github.io/qlibc/doc/html/qvector_8c.html>`_. However, both APIs
require using ``sizeof`` and are completely not-type-safe; it's easy to add a char
to an arrayh/vector of ints. This made me wonder: is it possible to implement a
type-safe, generic array type in C?

Now, I mean the C version of type-safe, which basically means that your compiler
has to show either a warning or an error (probably if compiling with ``-Werror``)
when you try to append the wrong type to an array.

.. TEASER_END

*Note that this implementation is not complete!* The most obvious issues are that
you can't pop elements off an array, and it resizes itself with every new addition,
which is (obviously!) slow.

Also, it uses macros. If you're allergic to them...sucks to be you!

The API is basically like:

.. code-block:: c
   
   List(int*) mylist = NULL; // NULL represents the empty list.
   int a=1, b=2;
   list_append(l, &a);
   // We can get the first element of the list with l[0] and the length with list_len:
   printf("%zu %d\n", list_len(l), *l[0]); // Prints 1 1.
   list_append(l, &b);
   printf("%zu %d %d\n", list_len(l), *l[0], *l[1]); // Prints 2 1 2.
   list_free(l);

Note that I used the term ``list``, not ``array``, since I'm a Python nerd.

I really like the fact that indexing a list is just ``list[index]``, not
something like ``get_element(list, index)`` or ``list->array[index]``.

Note that *this only supports lists of pointer types*. Don't try to
use a non-pointer type. It either won't work, or it will work, but only on some
platforms.

The code is available at `GitHub <https://github.com/kirbyfan64/list>`_.

Here's a breakdown of how it works:

Boilerplate
===========

.. code-block:: c

   #ifndef LIST_H
   #define LIST_H
   
   ...
   
   #endif

Yeah, we all know what this is for! Joyous header files.

Inside these header files is some more boilerplate:

.. code-block:: c

   #define list_cat2(a,b) a##b
   #define list_cat(a,b) list_cat2(a,b)
   #define list_var(b) list_cat(list_type_,list_cat(b,__LINE__))

This is just a way of creating anonymous, single-use variables inside a macro in
order to avoid name clashes. Think Lisp's ``gensym``.

The basics
==========

.. code-block:: c

    #define List(t) t*

*Now* the interesting stuff starts! This is just a macro to make uses of the list
type look like generics, so that I can do stuff like ``List(int*)``.

.. code-block:: c
   
   #define list_lenref(l) ((size_t*)l)[-1]

I think I need to explain a moment.

Lists are represented by a pointer to a length of type ``size_t`` and the elements
immediately after, like this:

.. code-block:: c
   
   struct my_list_type {
       size_t length;
       some_type my_array[size_here];
   };

(Except that ``my_array`` can be of any size.) However, the list is a pointer to
the array, after the length. Therefore, ``list_lenref`` (which gets the length of
the list) needs to go BEFORE the given list to get the length.

Next is the definition of ``list_len``:

.. code-block:: c
   
   #define list_len(l) (l?list_lenref(l):0)

This is just a wrapper macro around ``list_lenref`` to support getting the length
of an empty list (``NULL``).

Appending
=========

Now is my personal favorite part: the definition of ``list_append``:

.. code-block:: c

   #define list_append(l,x) do {\
       size_t list_var(len) = list_len(l);\
       l = realloc(l?((void*)l)-sizeof(size_t):NULL,\
                   sizeof(void*)*(list_var(len)+1)+sizeof(size_t))+sizeof(size_t);\
       list_lenref(l) = list_var(len)+1;\
       l[list_lenref(l)-1] = x;\
   } while (0)

This is definitely the biggest macro (and arguably the most important), so I'll
explain it line-by-line:

First, the length of the list is saved in an anonymous variable:

.. code-block:: c

    size_t list_var(len) = list_len(l);\

Next, the list is ``realloc``'d:

.. code-block:: c

    l = realloc(l?((void*)l)-sizeof(size_t):NULL,\
                sizeof(void*)*(list_var(len)+1)+sizeof(size_t))+sizeof(size_t);\

This alone deserves explanation, too! The first argument to ``realloc`` is the
block of memory to be resized. If the list is NULL, then NULL is passed to
``realloc``. Otherwise, the size of the length is subtracted from the pointer to
get the beginning of the allocated memory.

The second argument is the size of the new memory block. This is the size of a
pointer times the number of elements to be in the new list, which is just the old
length plus 1.

A``sizeof(size_t)`` is then added to the result of the call to ``realloc`` to get
a pointer to the elements.

I didn't worry about ``realloc`` returning ``NULL``, since this is just an
example, and, in my use case, I'm calling a wrapper over ``realloc`` that aborts
on out-of-memory errors.

After all that, the length of the list is updated:

.. code-block:: c

   list_lenref(l) = list_var(len)+1;\

If you're wondering why I didn't just use ``++list_lenref(l)``, it's because, if
the list was empty before the append, the length will be uninitialized. Also,
``list_lenref`` is used instead of ``list_len`` because the latter is an rvalue
because it handles empty lists, but we know the list is 

And the new element is assigned:

.. code-block:: c

   l[list_lenref(l)-1] = x;\

All of this is wrapped in a ``do``/``while`` block to avoid `surprising issues
<http://stackoverflow.com/a/154138/2097780>`.

Freeing the list
================

Last of all comes freeing a list:

.. code-block:: c

   #define list_free(l) free(l?(void*)l-sizeof(size_t):NULL)

If the list is empty, then it just tries to free ``NULL``, which does nothing. If
the list is *not* empty, then ``sizeof(size_t)`` is subtracted to get the
beginning of the list, and that is freed.

Closing notes (and problems)
============================

If you're wondering how the heck this is type-safe, consider:

.. code-block:: c
   
   List(int*) l;
   char c=0;
   list_append(l, &c);

If I try to compile this, my compiler (Clang) says::
   
   tst.c:13:5: warning: incompatible pointer types assigning to 'int *' from 'char *' [-Wincompatible-pointer-types]
       list_append(l, &c);
       ^              ~~
   ./list.h:16:25: note: expanded from macro 'list_append'
       l[list_lenref(l)-1] = x;\
                           ^
   1 warning generated.

GCC 4.9 (which is admittedly an old version) gives a slightly less helpful but
still informative warning::
   
   In file included from tst.c:5:0:
   tst.c: In function ‘main’:
   list.h:16:25: warning: assignment from incompatible pointer type
        l[list_lenref(l)-1] = x;\
                            ^
   tst.c:13:5: note: in expansion of macro ‘list_append’
        list_append(l, &c);
        ^

Intel's doesn't show the macro expansion, but it still works::

   tst.c(13): warning #556: a value of type "char *" cannot be assigned to an entity of type "int *"
         list_append(l, &c);
         ^

You can see that the compiler always notices when something isn't right, and
building with ``-Werror`` will prevent this from even compiling.

As for problems with the implementation, there are a few:

- The list is always resized on every append, like I mentioned above. This would
  be a trivial change that I just haven't done yet.

- No popping from a list, which I also mentioned.

- No handling of a ``realloc`` failure. Again, I mentioned this above, too.

- Error messages can be big. Just try something like
  ``list_append(some_nonexistent_variable, 0)`` and you'll see what I mean. That
  gives a whopping 8 errors with Clang. GCC and Intel iare much better here (they
  only show one), but you get the idea!

All in all, I still think this is a cool list implementation!
