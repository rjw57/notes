The nature of research
======================

I'm going to take a brief detour for the moment and consider the nature of research and the scientific method in
general. Despite appearances to the contrary, this isn't to sound as conceited as possible. Rather it is an attempt to
express the *why* of a system like git in terms familiar to those who are not professional software engineers.

The scientific method developed in the 20:sup:`th` century is termed the `hypothetico-deductive model
<http://en.wikipedia.org/wiki/Hypothetico-deductive_model>`_ and was first so-named by `William Whewell
<http://en.wikipedia.org/wiki/William_Whewell>`_ in his 1837 *History of the Inductive Sciences*. This is, by the way,
the same Whewell for whom Whewell's Court in Trinity College, Cambridge is named. Simplified and paraphrased, the
hypothetico-deductive model is the following:

1. Start with some assumed combined state and model for the Universe.

2. Propose a new state and a mechanism for evaluating the likelihood of that state through experiment.

3. Compare the relative likelihoods of the new state and the old state.

4. If the evidence in favour of the new state is compelling, accept it otherwise reject it.

5. Go to step 2.

I've stated the basic form of the hypothetico-deductive model in terms very similar to those used to state the
`Metropolis-Hastings algorithm <http://en.wikipedia.org/wiki/Metropolis_hastings>`_ used to draw samples from some
underlying distribution. I've chosen to do this because I believe there are similarities which can be used to justify
the analogy. In the hypothetico-deductive model we cannot directly draw inference from the underlying rules of the
Universe, we can only evaluate the evidence for or against proposed hypotheses. Similarly, in the Metropolis-Hastings
algorithm, we cannot draw samples directly from a distribution but we can evaluate the likelihood of a sample at any one
point.

We can view a scientific theory's advance much like a train of samples drawn from a Metropolis-Hastings sampler: ideally
we want to reach the 'correct' viewpoint which is independent of any bias in our start point but we can only make
incremental progress.

The timeline of research
------------------------

Having established my analogy, I'm going to use it to discuss different approaches to research in much the same way as
one might discuss differing MCMC sampling algorithms. I assert that the scientific method is itself some form of MCMC
sampling algorithm aiming to generate an optimal state and model (sample) from the Universe itself (the underlying
distribution).

No research, therefore, stands alone and each point along the development of a theorem or algorithm depends on all the
steps leading up to it. If I were to represent stages of a piece of research's development as nodes in a graph, arrange
them with time increasing vertically and draw edges showing direct interdependence then one might end up with a diagram
like the following:

.. tikz::
    :libs: chains, shapes
    
    \begin{scope}[
        very thick,
        node distance=1em,
        every on chain/.style={join,draw,rounded rectangle,text height=1em,text depth=0.2em,font={\sffamily}}
        ]
        \begin{scope}[start chain=master going above]
            \node[on chain] {Starting point};
            \node[on chain] {Failures (perhaps many)};
            \node[on chain] {Working};
            \node[on chain] {Not working};
        \end{scope}
    \end{scope}

Note that the most current node is at the *top*. This makes it hard to read but it appears to be the way people prefer
to write email these days and so I'm capitulating to popular demand.

It is rarely the case that research is so linear. For example, one may want to 'branch' off from this track to refine
something for a paper. It is also rarely the case that there is a one map, one job mapping. Suppose a project wishes to
publish at some point. This is usually at some success point. Ideally, work to advance some research doesn't stop when a
decision is made to publish. Instead you mentally branch off the work:

.. tikz::
    :libs: chains, shapes
    
    \begin{scope}[
        very thick,
        node distance=1em,
        every on chain/.style={join,draw,rounded rectangle,text height=1em,text depth=0.2em,font={\sffamily}}
        ]
        \begin{scope}[start chain=master going above]
            \node[on chain] {Starting point};
            \node[on chain] {Failures (perhaps many)};
            \node[on chain] {Working};
            \begin{scope}[start branch=paper going above]
                \node[on chain, above left=3em and 6em of master-end] {Tidy-up};
            \end{scope}
            \node[on chain] {Not working};
            \node[on chain, above=2em of master-end] {Working};
            \begin{scope}[continue branch=paper going above]
                \node[on chain, above=3em of master/paper-end] {Draft paper};
                \node[on chain] {Submit};
            \end{scope}
        \end{scope}
    \end{scope}

The work on the paper continues in parallel to the main thrust of the research; when writing the paper work from the
branch point is refined (and perhaps corrected) and work proceeds apace on advancing science in the meantime. Notice how
I'm assuming you're still one person. There are no nodes which happen simultaneously. At any one point you are likely to
be working *either* on the paper *or* on the main branch. Suppose the paper work is done. The paper is accepted and,
really, the insights from the paper drafting should be folded into the main 'trunk' of development. There comes a point
in your work where the paper-writing chain merges into the main chain:

.. tikz::
    :libs: chains, shapes
    
    \begin{scope}[
        very thick,
        node distance=1em,
        every on chain/.style={join,draw,rounded rectangle,text height=1em,text depth=0.2em,font={\sffamily}}
        ]
        \begin{scope}[start chain=master going above]
            \node[on chain] {Starting point};
            \node[on chain] {Failures (perhaps many)};
            \node[on chain] {Working};
            \begin{scope}[start branch=paper going above]
                \node[on chain, above left=3em and 6em of master-end] {Tidy-up};
            \end{scope}
            \node[on chain] {Not working};
            \node[on chain, above=2em of master-end] {Working};
            \begin{scope}[continue branch=paper going above]
                \node[on chain, above=3em of master/paper-end] {Draft paper};
                \node[on chain] {Submit};
                \node[on chain] {Accepted};
            \end{scope}
            \node[on chain, join=with master/paper-end, above=9em of master-end] {Merge insights from paper}; %|
            \node[on chain] {Not working};
        \end{scope}
    \end{scope}

All research proceeds like this. There is certainly a strong directionality but there are many short-lived branches or
tributaries away from the main line which are focussed on one area or on completing one task. To extend the MCMC
analogy: the real-world of research is more of a particle filter than a straight application of Metropolis-Hastings.

Obviously one can make the diagrams above as complex and as rich as one desires in an attempt to illustrate real-world
research practises but the conclusions I want you to draw are the following:

* Research rarely proceeds in a straight line from result A to result B.

* There is a degree of directionality but at the metaphorical coal-face there are always many directions one might go.

* The correct direction is not always apparent until well after the fact.

* The topology of research is a *directed acyclic graph* (DAG).

Git as a research tool
----------------------

Git is a piece of software which can help you manage your research as long as it follows the pattern I've laid out
above and it assumes one further thing:

    The entire state of one research project is represented as a single folder (or directory) on disk.

If you are primarily writing MATLAB code, this is more of a reasonable assumption than you might think. There will most
likely be a directory with your datasets in, one with your MATLAB scripts in, one with any toolboxes you use in and one
with any papers related to your research in. If all of these directories are put into a single parent, then you have
satisfied the requirement that git imposes.

.. note::

    This is not entirely the whole story. Git allows you to combine many sub-projects into one single project via it's
    *submodule* facility. Using *submodules*, one could keep the datasets, papers and toolboxes as separate 'shared'
    resources and keep only your custom MATLAB code and links to these submodules as the set of resources managed by
    git.

d
