# CrawlingOnTrees
<div _ngcontent-bkf-c211="" id="programming-exercise-instructions-content" class="guided-tour instructions__content__markdown markdown-preview"><h3 id="crawlingontrees">Crawling on Trees</h3>
<p>Once again, consider binary trees, which we define as:</p>
<pre class="ocaml language-ocaml"><code class="hljs ocaml language-ocaml"><span class="hljs-keyword">type</span> tree = <span class="hljs-type">Empty</span> | <span class="hljs-type">Node</span> <span class="hljs-keyword">of</span> <span class="hljs-built_in">int</span> * tree * tree
</code></pre>
<p>In this assignment you are supposed to implement a crawler that walks along binary trees
and performs different operations. At any time, the crawler “sits” on a particular node
of the tree (this includes the <code>Empty</code>-leaf). In the following we refer to this node as the
current node. Furthermore, the crawler uses a stack to store trees. Initially, the crawler is
positioned at the input tree’s root and is then instructed using the commands</p>
<pre class="ocaml language-ocaml"><code class="hljs ocaml language-ocaml"><span class="hljs-keyword">type</span> command = <span class="hljs-type">Left</span> | <span class="hljs-type">Right</span> | <span class="hljs-type">Up</span> | <span class="hljs-type">New</span> <span class="hljs-keyword">of</span> <span class="hljs-built_in">int</span> | <span class="hljs-type">Delete</span> | <span class="hljs-type">Push</span> | <span class="hljs-type">Pop</span>
</code></pre>
<p>with the following meaning:</p>
<ul>
<li><code>Left</code> moves the crawler to the current node’s left child.</li>
<li><code>Right</code> moves the crawler to the current node’s right child.</li>
<li><code>Up</code> moves the crawler up to the current node’s parent node.</li>
<li><code>New x</code> replaces the current node (including all children) with a new node with value
x.</li>
<li><code>Delete</code> removes the current node (including all children) leaving behind an Empty-
leaf.</li>
<li><code>Push</code> pushes the subtree rooted at the current node onto the stack. The tree stays
unchanged.</li>
<li><code>Pop</code> replaces the subtree rooted at the current node with the topmost tree of the
stack. The tree is then popped from the stack.</li>
</ul>
<ol>
<li><div class="pe-task-3 d-flex"><jhi-programming-exercise-instructions-task-status _nghost-bkf-c209="" class="ng-star-inserted"><div _ngcontent-bkf-c209="" class="guided-tour">
    <!---->
    <!---->
    <fa-icon _ngcontent-bkf-c209="" size="lg" class="ng-fa-icon test-icon text-secondary ng-star-inserted"><svg role="img" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="circle-question" class="svg-inline--fa fa-circle-question fa-lg" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><path fill="currentColor" d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zM169.8 165.3c7.9-22.3 29.1-37.3 52.8-37.3h58.3c34.9 0 63.1 28.3 63.1 63.1c0 22.6-12.1 43.5-31.7 54.8L280 264.4c-.2 13-10.9 23.6-24 23.6c-13.3 0-24-10.7-24-24V250.5c0-8.6 4.6-16.5 12.1-20.8l44.3-25.4c4.7-2.7 7.6-7.7 7.6-13.1c0-8.4-6.8-15.1-15.1-15.1H222.6c-3.4 0-6.4 2.1-7.5 5.3l-.4 1.2c-4.4 12.5-18.2 19-30.6 14.6s-19-18.2-14.6-30.6l.4-1.2zM224 352a32 32 0 1 1 64 0 32 32 0 1 1 -64 0z"></path></svg></fa-icon><!---->
    <span _ngcontent-bkf-c209="" class="task-name ng-star-inserted">crawl</span><!---->
    <span _ngcontent-bkf-c209="" class="guided-tour test-status--linked text-secondary ng-star-inserted">0 of 1 tests passing</span><!---->
    
    <!---->
</div>
</jhi-programming-exercise-instructions-task-status></div>Implement a function <code>crawl : command list -&gt; tree -&gt; tree</code> that executes a list of
crawler commands on the given tree.</li>
</ol>
<p>You may assume that the list of commands is always valid, so there is no <code>Left</code> or <code>Right</code> when the crawler is already at a leaf, no <code>Up</code> when it is
on the root and no <code>Pop</code> when the stack is empty.</p>
<p><em>Hint: The tricky part is to get the <code>Up</code> command right. If you do not manage to implement
this correctly, leave it out and you will still get some points if the rest is correct.</em></p>
<p><em>Note: This is not a team exercise, you must submit your individual solution.</em>  </p>
<p><strong>Tests</strong></p>
<pre><code class="hljs">let t_l = <span class="hljs-keyword">Node</span> <span class="hljs-title">(2</span>, <span class="hljs-keyword">Node</span> <span class="hljs-title">(1</span>, Empty, Empty), <span class="hljs-keyword">Node</span> <span class="hljs-title">(3</span>, Empty, Empty))
let t_r = <span class="hljs-keyword">Node</span> <span class="hljs-title">(6</span>, <span class="hljs-keyword">Node</span> <span class="hljs-title">(5</span>, Empty, Empty), <span class="hljs-keyword">Node</span> <span class="hljs-title">(7</span>, Empty, Empty))
let tree = <span class="hljs-keyword">Node</span> <span class="hljs-title">(4</span>, t_l , t_r)
</code></pre>
<p>example 1</p>
<pre><code class="hljs"><span class="hljs-variable">utop</span> <span class="hljs-type">#</span> 
<span class="hljs-variable">crawl</span> <span class="hljs-punctuation">[</span><span class="hljs-built_in">Left</span><span class="hljs-operator">;</span> <span class="hljs-built_in">Right</span><span class="hljs-operator">;</span> <span class="hljs-built_in">Up</span><span class="hljs-operator">;</span> <span class="hljs-built_in">Left</span><span class="hljs-operator">;</span> <span class="hljs-built_in">Up</span><span class="hljs-operator">;</span> <span class="hljs-built_in">Up</span><span class="hljs-operator">;</span> <span class="hljs-variable">New</span> <span class="hljs-number">3</span><span class="hljs-punctuation">]</span> <span class="hljs-variable">tree</span><span class="hljs-operator">;;</span>
<span class="hljs-operator">-</span> <span class="hljs-operator">:</span> <span class="hljs-variable">tree</span> <span class="hljs-operator">=</span> <span class="hljs-variable">Node</span> <span class="hljs-punctuation">(</span><span class="hljs-number">3</span><span class="hljs-operator">,</span> <span class="hljs-built_in">Empty</span><span class="hljs-operator">,</span> <span class="hljs-built_in">Empty</span><span class="hljs-punctuation">)</span>
</code></pre>
<p>example 2</p>
<pre><code class="hljs">utop <span class="hljs-comment"># </span>
crawl [Left; Push; Right; Pop] tree;;
- : tree = <span class="hljs-keyword">Node</span> <span class="hljs-title">(4</span>,
 <span class="hljs-keyword">Node</span> <span class="hljs-title">(2</span>, <span class="hljs-keyword">Node</span> <span class="hljs-title">(1</span>, Empty, Empty),  
 <span class="hljs-keyword">Node</span> <span class="hljs-title">(2</span>, <span class="hljs-keyword">Node</span> <span class="hljs-title">(1</span>, Empty, Empty), <span class="hljs-keyword">Node</span> <span class="hljs-title">(3</span>, Empty, Empty))), 
 <span class="hljs-keyword">Node</span> <span class="hljs-title">(6</span>, <span class="hljs-keyword">Node</span> <span class="hljs-title">(5</span>, Empty, Empty), <span class="hljs-keyword">Node</span> <span class="hljs-title">(7</span>, Empty, Empty)))
</code></pre>
<p></p><details>
<summary>Sample Solution</summary><p></p>
<p><a rel="noopener noreferrer" href="https://bitbucket.ase.in.tum.de/projects/FPV21W06H04/repos/fpv21w06h04-solution/browse/src/assignment.ml">https://bitbucket.ase.in.tum.de/projects/FPV21W06H04/repos/fpv21w06h04-solution/browse/src/assignment.ml</a>
</p></details><p></p></div>
