.. title: KaTeX
.. slug: katex
.. date: 2015-05-01 10:26:36 UTC-05:00
.. tags: 
.. link: 
.. description: 
.. type: text

.. raw:: html
   
   <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/KaTeX/0.2.0/katex.min.css">
   <script src="//cdnjs.cloudflare.com/ajax/libs/KaTeX/0.2.0/katex.min.js"></script>
   
   <script>
   function renderMath(txt) {
       var out = document.getElementById("mathOutput");
       out.style.color = "black";
       try {
           katex.render(txt.value, out);
       } catch (err) {
           out.innerHTML = err.message;
           out.style.color = "red";
       }
   }
   </script>

A KaTeX demo page. Type in your math, and see it rendered. Or you can get a big, red parse error.

.. raw:: html
   
   <textarea id="input" rows="10" cols="50" oninput="renderMath(this)"></textarea>
   <br>
   <br>
   <div id="mathOutput"></div>
   <br>
   <br>
