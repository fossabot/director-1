[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Frios%2Fdirector.svg?type=shield)](https://app.fossa.com/projects/git%2Bgithub.com%2Frios%2Fdirector?ref=badge_shield)

========
Director
========

.. contents:: Table of Contents


Introduction
============

This README describes how to download and build the Director source code
and how to satisfy 3rd party dependencies.

Background
----------

The Director is a robotics interface and visualization framework.

It includes applications for working with `Drake <http://drake.mit.edu>`_,
and includes the primary user interface used by Team MIT in the DARPA Robotics Challenge.

`Team MIT DRC day-1 visualization <https://www.youtube.com/watch?v=em69XtIEEAg>`_

The Director is a collection of C++ and Python libraries and applications.  Many components from
this repository are usable out-of-the-box, but some require additional components from
the greater MIT DRC codebase.

System Requirements
-------------------

As of this writing, the software is tested on Ubuntu 14.04 and 16.04, and MacOSX 10.11.
The build should work on Microsoft Windows with MSVC but it is not continuously tested.
In theory it can run on any platform where VTK and Qt are supported.


Download Instructions
=====================

Install Git
-----------

The source code is stored in a Git repository. To download the
source code you may need to first install Git on your system.
On Mac, we recommend using Homebrew.  On Windows, download the
official git package from https://git-scm.com

Download the source code
------------------------

Download the repository with the ``git clone`` command:

::

    git clone https://github.com/RobotLocomotion/director.git


Dependencies
============


Required Dependencies
---------------------

The required 3rd party dependencies are:

  - Qt4 or Qt5 (Qt 4.8.7 recommended)
  - VTK 6.2+ (VTK 7.1.1 recommended)
  - Python 2.7 and NumPy

Additionally, you will need CMake 2.8 or greater to configure the source code.

The dependencies can be installed on Mac using `Homebrew <http://brew.sh/>`_:

::

    brew tap patmarion/director && brew tap-pin patmarion/director
    brew install cmake glib libyaml numpy python scipy vtk7
    pip2 install lxml PyYAML

The dependencies can be installed on Ubuntu using apt-get:

::

    sudo apt-get install build-essential cmake libglib2.0-dev libqt4-dev \
      libx11-dev libxext-dev libxt-dev python-dev python-lxml python-numpy \
      python-scipy python-yaml

On Ubuntu the build does not require VTK to be installed.  A compatible version
of VTK will be downloaded (precompiled binaries) at build time.


Building
========

Compiling
---------

::

    make superbuild

This is an alias for:

::

    mkdir build && cd build
    cmake ../distro/superbuild
    make


Documentation
=============

A preliminary Online Help for the Director (currently in preparation) can be found `here <https://openhumanoids.github.io/director/>`_.


Citing
======

If you wish to cite the director, please use:

::

    @misc{director,
      author = "Pat Marion",
      title = "Director: A robotics interface and visualization framework",
      year = 2015,
      url = "http://github.com/RobotLocomotion/director"
    }


## License
[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Frios%2Fdirector.svg?type=large)](https://app.fossa.com/projects/git%2Bgithub.com%2Frios%2Fdirector?ref=badge_large)