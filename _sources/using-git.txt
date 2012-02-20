Using ``git`` for your work
===========================

Introduction
------------

This is a talk about why you should be using ``git`` in your research. ``git``
is not a tool which will make your research any *better* but it is a tool which
will let you make mistakes with less catastrophic side-effects.

``git`` belongs to a family of tools known as 'source-control' or
'source-management' systems. This is a rather poor term for it. I prefer to call
it 'the best backup system you will ever use'. With ``git`` automated backups
and restoration become utterly trivial and, best of all, there are free
providers out there who will host private or public ``git`` backups for you.

So with that in mind. Let's look at some of the high-level advantages of
``git``:

You can put-right what once went wrong
``````````````````````````````````````

In the television show *Quantum Leap* the intrepid scientist Dr Samuel Beckett
would travel in time in order to write supposed wrongs which happened to good
people. In the tradition of 20-20 hindsight it was impossible to see at the time
what seemingly innocuous activity would cause the heroine of the week's life to
go wrong but with the help of knowledge from the future, Sam could travel back
and fix the Universe.

``git`` lets you do this with your own research. It provides a safe ground for
you to explore ideas, perform destructive re-factoring or try out some
algorithmic improvement safe in the knowledge that if it ends up not working
out, you can go back to the point where you made the mistake and rectify it.

You can use both lanes
``````````````````````

``git`` allows for multi-tasking. You may be developing one idea and *branch*
off at any point to develop a new direction or new though. You can keep
developing the old branch as well and only merge back when you know which
direction is worth keeping. ``git`` provides sophisticated automated algorithms
for merging branches allowing you to make use of insights gained in all branches
of development.

Backups? No problem
```````````````````

``git`` is a *distributed* system. In this case this word means that no`one
place is special. Your backup is itself a full`featured ``git`` repository just
as the repository on your own disk is. ``git`` provides tools to synchronise
between remote repositories meaning that your backup and your main work space
are just as good as each other. Disaster recovery involves only syncing your
backup back to a fresh checkout.

A searchable database of your code
``````````````````````````````````

``git`` provides a very powerful command known as ``git grep`` which can search
all of your code in an instant for any word or phrase you desire. Moreover it
can search any *version* of your code back in time to see where something was
mentioned or defined first.

There is also a valuable tool known as ``git blame`` which can mark every line
of your code with the exact date and time it was written and give you access to
a message you wrote at the time describing the change.

Getting Started
---------------

I'm going to assume you're using a Unix-alike Operating System. If you're not,
you're already doing it wrong. Just before the OS X and Windows haters get to me
though, I'm going to point out that both the Mac and Windows platforms can be
Unix-like with some effort.

On the Mac, this effort is small: install homebrew_ and then install ``git`` via
the homebrew installation utilities. On Windows this is a little less involved:
install msysgit_ which will install ``git`` for you along with a nice
command-line interface.

.. note:: It is certainly possible to use ``git`` without ever touching the
   command-line. Indeed if you have a good text-editor it may well support
   ``git`` directly. In the absence of editor integration it is far easier to
   interact with ``git`` via the command-line. It is better to describe what you
   want to do with what where rather than to wave your hands around and grunt.

On Linux machines your distribution's package manager will support installing
git. Usually this is via one of the following sets of magic runes:

.. code-block:: console

  $ pacman -Ss git        # ... for Arch Linux
  $ apt-get install git   # ... for Ubuntu or Debian Linux
  $ yum install git       # ... for Red Hat, Fedora or SuSe Linux

.

.. _homebrew: http://mxcl.github.com/homebrew/
.. _msysgit: http://code.google.com/p/msysgit/

.. vim:sw=2:ts=2:sts=2:tw=80:spell:spelllang=en_gb
