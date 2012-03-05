The meaning of 'random'
=======================

This note addresses a very common misconception about the word 'random'. Or, rather, it discusses two separate concepts
which are often combined into the same word: *randomness* and *uniformly distributed*.

What is the difference? Why should I care? Surely it only matters to pedants and mathematicians. The problem is not one
of being 'right' or 'wrong'. It is one of being able to express yourself to other people: you can't talk about something
if you can't name it.

.. figure:: random/montoya.jpg
    :alt: You keep using that word. I do not think it means what you think it means.
    :align: center

    Ingio Montoya knows best.

A real-world example
--------------------

A podcast which I listen to---I wont name it---recently ran a competition to win a laptop. They proudly proclaimed that
they were going to let the machine itself pick it's new owner. They wrote a program which would electronically pick a
name from a hat and that person would win that laptop. Being an Open Source podcast, they provided the source for their
program. I'm going to re-state their program in terms which are easier to understand. This 'program' only works if there
are no more than 6 people in the competition, but the principle is the same as the real example.

1. Assign each competitor a (unique) number from zero to the number of entrants. The first competitor is '0', the second
   '1', and so on.

2. Throw a six-sided die and write down the result.

3. Divide the number your rolled by the number of competitors and write down the remainder.

4. Give the laptop to the competitor with that number.

As an example, suppose that there are four competitors: 0, 1, 2 and 3. We throw the die and get a 5. The remainder after
dividing 5 by 4 is 1 and so competitor 1 gets the laptop.

Can you see the flaw? Don't worry if not. It's subtle. I'll explain it in a moment but back to the story: I sent the
producers of the podcast a polite note pointing out that the competition was (very, very, very slightly) unfair and
that, if they were my students, they'd have had a frowning face drawn on their work. I got the reply back that it didn't
matter because the result was 'random'.

Yes indeed, it was random but it was unfair. Have you spotted how? Well, let's write down a table of possible die rolls
and the winner of the laptop:

=== ======
Die Winner
=== ======
1   0
2   1
3   2
4   3
5   0
6   1
=== ======

Is this fair? Entrants 0 and 1 have a 2/6 or one in three chance of winning whereas entrants 2 and 3 only have a one in
six chance. If the entrants are allocated a number on a first come first served basis then the competition is biased in
favour of those who entered early.

Uniform distribution
--------------------

So, the competition result was indeed *random* but was it *fair*? No. But no-matter how much I tried to explain, I kept
running up against the brick wall of misunderstanding: I was telling them it wasn't 'random' but it *was* 'random'
because no one could predict the result.

Well, yes. The word 'random' does indeed mean that; a random variable is one whose value cannot be precisely predicted
before you measure it. A person's height is a random variable. Before you measure it, you don't know what a person's
precise height it. You can certainly put bounds on it; if you've not seen them you can reasonably suppose it will be
between 1 and 8 feet.

All heights are not equally likely. For example, you would expect there to be far more men whose height is in the range
5-6 feet than those who are 4-foot something.

When we have a random variable where all values in a range are equally likely we call it *uniformly distributed*. A
(fair) die is uniformly distributed. You would expect the likelihood of rolling a six to be the same as that of rolling
a one.

So, next time you are complaining---or being complained to---about something being 'unfair because it isn't random', ask
yourself if you mean it isn't random or that it isn't uniformly distributed.

Too long; didn't read
---------------------

The conclusion you should take from this note is that 'random' is not the same as 'uniformly distributed':

* A **random** variable is one whose precise value cannot be predicted before your measure it.
* A **uniformly distributed** variable is one whose values are all equally likely.

Other distributions
-------------------

A variable can be random and non-uniformly distributed. Coming back to our example of heights, the height of a person is
indeed random but we expect values to be clustered around some average. We call this pattern of values a *distribution*.
If we take lots of values of a random variable, we call it sampling and each value, which we call a *sample*, is said to
be *drawn* from the underlying distribution.

The rolls from a fair six-sided dice are samples drawn from the uniform distribution of whole numbers between 1 and 6
inclusive. The heights of the human population can be approximated as samples drawn from something called the
`normal distribution <http://en.wikipedia.org/wiki/Normal_distribution>`_.

Epilogue: uniform :math:`\ne` random
------------------------------------

Suppose I give you the following sequence of numbers:

    1, 2, 3, 4, 5, 1, 2, 3, 4, 5, 1, 2, 3, 4, :math:`X`

Can you predict what number should go in place of :math:`X`? I hope it's obvious that :math:`X` is 5. You can predict
these numbers; they are not random. If :math:`X` is 5, however, then there are three of each number. By our definition
above they are uniformly distributed.

Usually, to be fair, a competition result needs to be *both* random *and* uniformly distributed. One rarely suffices on
it's own.
