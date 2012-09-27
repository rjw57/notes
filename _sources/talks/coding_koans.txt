Coding Koans: Best and Worst Practice in Software Engineering
=============================================================

Links
-----

* Slides [:download:`LibreOffice <coding_koans/slides.odp>`] [:download:`PDF <coding_koans/slides.pdf>`]

Errata
------

* The 'earth, air, fire, water and heart' slide contains one element repeated and one element omitted.

Introduction
------------

**SLIDE: TITLE**

This talk is a little different from other talks that you've seen over the past few days. Instead of giving you an
overview of a specific system or specific practice I'm going to talk about some handy 'rules of thumb' I've collected
during my time as a software developer. I've tailored these to some common mistakes I've seen in academic projects. If
this entire talk is boring to you and if you think you know everything in it, that's great. You're in the minority in my
experience.

**SLIDE: AN APOLOGY**

Firstly, an apology. This was originally a one hour talk which I cut down to half an hour to write the abstract. Then I
found out the talks were 15 minutes after I submitted the abstract.

**SLIDE: HYPOCRITE**

**SLIDE: CLOCK**

And a disclaimer. I'm a hypocrite. I don't always do what I claim is best practice. I'm human. Fortunately the talk on
my actual work was on Monday and so you've all forgotten it by now.

I'm assuming the audience for this talk ave written real programs used by real users.

**SLIDE: PICTURES/WORDS**

This talk will have pictures up there and words down here.

A koan is a little 'nugget of wisdom' in Zen Buddhism. It could be called a saying or a proverb. I chose the word 'koan'
only because it alliterates with 'coding' thus preserving the great Anglo Saxon oral tradition.

**SLIDE: CONTEXT/WISDOM**

If we extend the zen metaphor a little, I'm the round-stomached master and you're the neophytes. Context is up there,
wisdom comes from down here. In reality, distraction is up there and noise is down there. It's the morning after the
conference dinner so something light should be good for you guys!

**SLIDE: DISTRACTION/NOISE**

If you've had too much to drink last night, there'll be some distraction and noise.

**SLIDE: ABOUT ME**

I'm supposed to be listened to at all by you people, I should probably tell you a bit about myself.

the moment I'm collaborating with some people here at Harwell on an IT infrastructure and suite of software for
single molecule imaging and analysis.

**SLIDE: GEOMERICS**

a previous life, however, I was a professional software engineer. I was chief product developer at a company called
Geomerics which developed middleware for the games industry.

I'm responsible for Battlefield 3 looking so pretty while you run around killing people.

In maths:

**SLIDE**

    picture = render( model( death ) )

A picture is formed by rendering a model which represents the abstract concept of death.

**SLIDE**

I'm also a founder of and product inventor for PneumaCare who develop passive medical monitoring systems using computer
vision.

**SLIDE**

    life = interpretation( vision( picture ) )

A picture is interpreted via computer vision into a model which is interpreted in a manner which preserves life.

They may seem different things but of course we're mathematicians and we realise the power of the inverse:

**SLIDE**

    ( model^-1 ( render^-1( picture ) ) )^-1 = interpretation( vision( picture ) )

**SLIDE: THINGS I LOVE TOO MUCH**

In industry I was in charge of software quality engineering: something I'm quite unreasonably excited by.

**SLIDE: MONK**

Although the title of the talk talks about Zen, philosophy, etc and makes it seem like I'm trying to be some sort of of
OCD, geeky monk.

**SLIDE: PHB**

I'm probably more of a PHB.

I could give you one piece of advice for the future it would be this: use source control. The long-term benefits to
maintainability of source control is well known. The rest of my advice has no more basis in fact than my own meandering
experience. I shall dispense this advice now.

lazy
-------

**SLIDE: BE LAZY**

**SLIDE: MAD DOG**

Develop an aesthetic which used to be called the 'UNIX way'. In essence any task can be broken into two costs: the
upfront cost and the per-incidence cost. The lazy way is to make the per-incidence cost as close to zero as possible,
even if it makes the upfront cost large in terms of effort.

**SLIDE: WINDOWS v UNIX**

For example here we are developing a piece of single molecule tracking software for use in our pipeline called Biggles.
The Biggles software suite consists of several modules including a test-data simulation module. Test-data is generated
each build (if the simulation software changes) and is compared with an expected SHA-1 hash as part of the test
suite.

This has the following advantages:

* New-users have data to play with immediately;
* Can regression-test simulator;
* Test-data is plotted as part of build system too;
* Makes checkout smaller;
* Forces repeatability

Took more effort: needed to refactor PRNG to allow seed specification and sort out build system to auto-detect Python
version and to allow simulator to be driven from configuration files. Worth it because now that functionality makes
making standard dataset easy: consists of simulation parameters, git commit ID and SHA-1 of output.

Steal
-----

**SLIDE: STEAL**

Your time is precious. Steal the work of others. To first order, you will *never* need to write another database, file
format, text-based metadata format, message passing interface, network protocols, data catalogues, archival formats,
query languages, data processing languages and user identification and authentication systems.

has been evidenced by the vast number of projects based on the Eclipse RCP here, stealing is good.

Drink the Kool Aid (and spit it out)
------------------------------------

**SLIDE: DRINK THIS MUCH EVERY DAY**

Your institution will have opinionated people in it. I'm sure we can all think of at least one person. I know that I'm
that person in my lab. See what Kool-Aid they're drinking, be it eclipse, Python, Java, numpy, OpenMPI, ZeroMQ, etc..
Find five reasons to love it. Find five reasons to hate it. Drink their Kool-Aid but don't worry about spitting it out
if it tastes bad.

Earlier this week there was a talk about how to choose a data catalogue. I don't know if one of the criteria was 'I'll
have what she's having' but it should've been. Our system here has currently a, to put it charitably, interesting data
cataloguing and dataset management system which grew organically from a single microscope, a Windows Network share and
LabView. We're migrating over to ICAT (we have drunk the STFC's Kool-Aid). Obviously ICAT is better than what we have
but also using it makes a large number of things Not Our Problem.

Work, rest and play
-------------------

**SLIDE: MARS**

The Metropolis Hastings algorithm is a Monte Carlo sampling algorithm which can be used to optimise tricky problems by
exploring the search space in a statistically guided manner. In essence you start from one position, propose a new
position and accept that proposal according to a 'goodness ratio' between them. In the Metropolis Hastings algorithm,
the usual rule of thumb is that the acceptance rate should be around 25% - or only 1 in 4 proposals are accepted.

You will not be effective unless you explore the problem domain you're working on. Spend 80% of your time working:
writing software. Spend 10% of your time resting: watch videos on YouTube. There are 30 new software engineering relatev
videos uploaded to YouTube every day and that's not just idle fact, that's cold hard speculation. There are masses of
fascinating talks on databases, new bits of software, new libraries. The Google Tech Talk channel alone is full of good
stuff to file away in your brain for future reference. Another good resource is the PyCon conference talks. They're also
YouTube.

Spend the last 10% of your time playing. This corresponds to the proposal moves in the MH algorithm. It may or may not
useful but it will give you some broad domain knowledge you'll be able to call on in future.

I have 'Friday afternoon projects' which I reserve for this sort of thing. I'll play with some technique or a bit of
software to get a feel for it. Maybe I'll implement a little toy project. Some things I've first encountered through
Friday afternoon projects which I've gone on to use 'professionally': Machine learning algorithms, the RANSAC data
filter, matplotlib, CouchDB, PostGIS, Monte Carlo Metropolis-Hastings optimisation, GPU acceleration.

Here's an example of a 10% project. Being at a University one has access to a large number of useful digital resources.
girlfriend is a landscape archaeologist. And, by the way, data analysis looks like dark magic to archaeologists. She
was doing some work on a digital elevation model covering the ground between Avebury and Stonehenge and trying to use
road planning software to work out where neolithic people would've walked.

**SLIDE: AVEBURY**

Avebury is a neolithic standing circle of stones which is a few miles away from the far more famous Stonehenge.

**SLIDE: STONEHENGE**

I thought Stonehenge appropriate by the way since of course some people think it to be one of the earliest colaborative
Science computer systems. Being four and a half thousand years old, I think the one thing we can say with confidence is
that it ran FORTRAN.

The road planning software would only give a single shortest path route between Avebury and Stonehenge. And, of course,
neolithic man didn't have road planning software. So, to get myself familiar with the MH algorithm which had been on my
list of 'to learn' for a while, I simulated generations of neolithic people setting out across country, proposing a
modification to the route and coming back to report to the village. I then plotted a heat map showing the posterior
probability density of a neolithic man on their way from Avebury to Stonehenge being in a particular position.

**SLIDE: HEAT MAP**

This is the result. [WAX LYRICAL]

**SLIDE: REST ANTI-PATTERNS**

While I'm on the subject of Rest BTW. Read this article. I've heard a lot of people claim to ave REST APIs the past few
days. In my experience, not all REST APIs are created equal.

Good Engineers call on Captain Planet
-------------------------------------

**SLIDE: CAPTAIN PLANET**

What was Captain Planet? Hero. Gonna bring pollution down to zero.

**SLIDE: PLANETEERS**

Had five planeteers representing the five major races of Earth: black, white, asian, native American and ginger. Had
magic rings representing...

**SLIDE: EARTH, AIR, WIND, FIRE, HEART**

... the five elements of Earth, Air, Wind, Fire and Heart. It was only by combining their powers that Captain Planet
would appear.

**SLIDE: CALL ON CAPTAIN PLANET**

The moral message being that everyone has different strengths and weaknesses and that amazing things can be done when
people work together. In this case, there are lots of developers on your team and they need to be kept on the same page.

**SLIDE: GERRIT AND JENKINS**

For the Biggles project we use code-review via Gerrit. This leverages the power of git. [CHAT ON GERRIT]

Jenkins is a continuous integration system. [TALK ABOUT JENKINS]

**SLIDE: BAD CHECKIN - MISSING FILE**

**SLIDE: JENKINS - TEST SUITES**

**SLIDE: USE CODE REVIEW**

**SLIDE: MAKE JENKINS A REVIEWER**

commit can be made where the test suite does not pass. Was going to do a demo, but no time.

Make it easy to play with
-------------------------

Deep-dive ICAT. Our dataset management system is switching over to ICAT (see the Drinking Kool-Aid example).

**SLIDES**

* Here is web-page - how do I install ICAT?
* Instruction! - Oh, no.
* Tester? Yeah I want to play with it. Oh.
* Documentation. OK first section, what is ICAT, how do I install itm how do I get started? No.
* Installation off documentation page. Something about databases.
* Finally download it, run, wants DB. Configure sqlite database. Needs populating. Some scripts in the Source Control.
  Oh, Oracle.

**SLIDE: GERRIT AND JENKINS INSTALL**

Why can't ICAT be as easy to set up as this:

Gerrit
~~~~~~

.. code::

    $ java -jar gerrit.jar init <dir>
    $ <dir>/bin/run.sh

Jenkins
~~~~~~~

.. code::

    $ java -jar jenkins.jar

The End
-------

**SLIDE: FINISHED RANT**

That's it. I'm done.

.. vim:sw=4:sts=4:tw=120
