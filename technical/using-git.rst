Using git for your work
=======================

Introduction
------------

This is a talk about why you should be using git in your research. git is not a tool which will make your
research any *better* but it is a tool which will let you make mistakes with less catastrophic side-effects.

git belongs to a family of tools known as 'source-control' or 'source-management' systems. This is a rather poor
term for it. I prefer to call one of the following:

- The best backup system you will ever use, or
- The safest way to be reckless.

With git automated backups and restoration become utterly trivial and, best
of all, there are free providers out there who will host private or public
git backups for you.

So with that in mind. Let's look at some of the high-level advantages of git:

You can put-right what once went wrong
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In the television show *Quantum Leap* the intrepid scientist Dr Samuel Beckett would travel in time in order to write
supposed wrongs which happened to good people. In the tradition of 20-20 hindsight it was impossible to see at the time
what seemingly innocuous activity would cause the heroine of the week's life to go wrong but with the help of knowledge
from the future, Sam could travel back and fix the Universe.

.. figure:: using-git/sam-beckett.jpg
    :align: center

    The power of git compels Sam Beckett to right wrongs.

Git lets you do this with your own research. It provides a safe ground for you to explore ideas, perform destructive
re-factoring or try out some algorithmic improvement safe in the knowledge that if it ends up not working out, you can
go back to the point where you made the mistake and rectify it.

You can use both lanes
~~~~~~~~~~~~~~~~~~~~~~

Git allows for multi-tasking. You may be developing one idea and *branch* off at any point to develop a new
direction or new though. You can keep developing the old branch as well and only merge back when you know which
direction is worth keeping. Git provides sophisticated automated algorithms for merging branches allowing you to
make use of insights gained in all branches of development.

Backups? No problem
~~~~~~~~~~~~~~~~~~~

Git is a *distributed* system. In this case this word means that no`one place is special. Your backup is itself a
full`featured git repository just as the repository on your own disk is. Git provides tools to synchronise
between remote repositories meaning that your backup and your main work space are just as good as each other. Disaster
recovery involves only syncing your backup back to a fresh checkout.

A searchable database of your code
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Git provides a very powerful command known as :command:`git grep` which can search all of your code in an instant for any
word or phrase you desire. Moreover it can search any *version* of your code back in time to see where something was
mentioned or defined first.

There is also a valuable tool known as :command:`git blame` which can mark every line of your code with the exact date and time
it was written and give you access to a message you wrote at the time describing the change.

Getting Started
---------------

I'm going to assume you're using a Unix-alike Operating System. If you're not, you're already doing it wrong. Just
before the OS X and Windows haters get to me though, I'm going to point out that both the Mac and Windows platforms can
be Unix-like with some effort.

On the Mac, this effort is small: install homebrew_ and then install git via the homebrew installation utilities. On
Windows this is a little less involved: install msysgit_ which will install git for you along with a nice
command-line interface.

.. _homebrew: http://mxcl.github.com/homebrew/
.. _msysgit: http://code.google.com/p/msysgit/

.. note:: It is certainly possible to use git without ever touching the command-line. Indeed if you have a good
    text-editor it may well support git directly. In the absence of editor integration it is far easier to interact
    with git via the command-line. It is better to describe what you want to do with what where rather than to wave
    your hands around and grunt.

On Linux machines your distribution's package manager will support installing git. Usually this is via one of the
following sets of magic runes:

.. code-block:: console

  $ pacman -Ss git        # ... for Arch Linux
  $ apt-get install git   # ... for Ubuntu or Debian Linux
  $ yum install git       # ... for Red Hat, Fedora or SuSe Linux

I'm going to be using the command-line interface to git. This isn't to say there aren't a number of good GUI
interfaces to git, I just personally find them confusing. I'm going to assume you've got to the point where you can
type ``git help`` into some window on your screen and get output like the following:

.. code-block:: console

    $ git help
    usage: git [--version] [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]
               [-p|--paginate|--no-pager] [--no-replace-objects] [--bare]
               [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]
               [-c name=value] [--help]
               <command> [<args>]

    The most commonly used git commands are:
       add        Add file contents to the index
       bisect     Find by binary search the change that introduced a bug
       branch     List, create, or delete branches
       checkout   Checkout a branch or paths to the working tree
       clone      Clone a repository into a new directory
       commit     Record changes to the repository
       diff       Show changes between commits, commit and working tree, etc
       fetch      Download objects and refs from another repository
       grep       Print lines matching a pattern
       init       Create an empty git repository or reinitialize an existing one
       log        Show commit logs
       merge      Join two or more development histories together
       mv         Move or rename a file, a directory, or a symlink
       pull       Fetch from and merge with another repository or a local branch
       push       Update remote refs along with associated objects
       rebase     Forward-port local commits to the updated upstream head
       reset      Reset current HEAD to the specified state
       rm         Remove files from the working tree and from the index
       show       Show various types of objects
       status     Show the working tree status
       tag        Create, list, delete or verify a tag object signed with GPG

    See 'git help <command>' for more information on a specific command.

This is my first point: read the flipping manual. The git documentation is very, very good and can be accessed via
the ``git help`` command. In addition the `git reference manual <http://schacon.github.com/git/git.html>`_ is available
on the Web.

.. figure:: using-git/git-manual.png
    :align: center

    The git website contains a *lot* of documentation.

Basic concepts
--------------

The idea behind git is that it provides three things:

- A database of your research which can be organised by you in (almost) any way you care to,
- Tools allowing you to revert to any previous stage or merge two branches or research into one, and
- A way to easily backup or share your research with people.

We'll ignore the remote aspects of git for the moment and focus on the advantages it can provide you when used on a
single machine.

Setting up a git repository
~~~~~~~~~~~~~~~~~~~~~~~~~~~

A central concept in the git world is that of a *respository*. This is a single folder/directory on your disk which
you tell git to manage on your behalf. Turning a directory into a repository is very easy:

.. code-block:: console

    $ git init

Now you have a full database of everything that happens inside that directory from now on.
