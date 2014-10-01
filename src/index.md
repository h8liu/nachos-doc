# CSE 120 Nachos Project Guide

## Nachos

Nachos is an instructional operating system for undergraduate OS classes. It is a challenging system to learn, but is also as rewarding as it is challenging.

Nachos may seem complex (because it is) and confusing at first, but after using the system for a while you will become familiar and comfortable with it. There are also some advantages with using such a well-established project. First, it has been thoroughly debugged and is therefore relatively stable. Second, there is extensive documentation describing the Nachos system. Both of these points should make it easier for you to learn and use Nachos.

There are two versions of Nachos in current use, Nachos 3.4 and Nachos 4.0. They both have the same functionality. Nachos 4.0 is an updated version of 3.4, has been more widely ported, and is perhaps better architected from a software engineering point of view. However, most of the detailed guides describing the Nachos system refer to Nachos 3.4. Because of this reason, we will be using Nachos 3.4.

## Projects

Tom Anderson originally developed Nachos for a semester-long course at U.C. Berkeley that involved five projects. When he moved to the University of Washington, he adapted the original Nachos project outline to a quarter-long course involving three projects:

1. Threads
2. Multiprogramming
3. Virtual Memory

It is this outline that we will be following for our projects this quarter.

## Documentation

There are many resouces for using and learning the Nachos system. Essential are the original Nachos paper and the Nachos Road Map by Thomas Narten, but you will probably find it useful to browse the other resources as well (such as the Working With Nachos pages at Duke University).

- [The Nachos Paper](./pdf/nachos.pdf)
- [The C++ Tutorial](./pdf/c++.pdf)
- [Nachos Road Map](http://www.cs.duke.edu/~narten/110/nachos/main/main.html) [ [PDF](./pdf/narten.pdf) ]
- [Guide To Reading The Nachos Source](http://people.cs.uchicago.edu/~odonnell/OData/Courses/CS230/NACHOS/reading-code.html)
- [The Nachos Home Page](http://homes.cs.washington.edu/~tom/nachos/)
- [Nachos System Call Interface](./syscall.html) (a good reference to
    the core classes and their interfaces in the nachos implementation
    distributions.)

<!-- - [Nachos Internals] -->
<!-- TODO: need to update these links -->
<!-- Working With Nachos (notes on various practical aspects of using Nachos) -->
<!-- Working With Your Team (suggestions on team management) -->

The platform we will officially support is Linux/x86 on the machines in the CSE B230-B270 labs. We have customized the generic Nachos distribution for the CSE 120 class, so you should use the version of Nachos that we make available (i.e., do not download from other sites on the Web). The Nachos distribution file can be found on [github](https://github.com/h8liu/nachos). 

To compile the code and have a test run, do the following:

```
$ git clone https://github.com/h8liu/nachos.git
$ cd nachos/code
$ make
$ cd threads
$ ./nachos
```

It will create and populate the directory `nachos`.

## Using Nachos on other systems

Nachos has been developed to run on almost any operating system, but it requires the installation of a MIPS cross-compiler (so that you can compile C code that you write into MIPS executables independently of the architecture that you run the compiler on). We have installed a MIPS cross-compiler on the uAPE systems for class use, so on the class machines you do not have to worry about it.

You are welcome (and encouraged) to download Nachos to any system that you want. However, we cannot make any guarantees that it will compile on your system, although we can try to help if you run into difficulties.
Tools

## Git

Git is the default version control system we will use in CSE 120, and
[here](http://git-scm.com/doc) is an excellent reference manual online.

<!-- Eclipse: In the Spring 2008 course, which used the Java version of Nachos, Hamed Fard wrote a tutorial on how to use Eclipse with Subversion and ieng6. Parts of it likely have to be updated (e.g., references to the repositories), and I don't know how well Eclipse is going to work with the C++ version of Nachos, but if you are motivated you can give Hamed's tutorial a try. If you produce something that works for our version of Nachos and you do not mind sharing with the class, then let me know and I'll post it. -->

## Assistance

The Nachos projects are aggressive, complex, and time-consuming. Nachos may seem overwhelming at first, but the projects are not impossible. If your group is spending many hours stuck on a single problem, then you should seek assistance. Be sure and read the various support documents. Come to office hours. And use the class discussion board to share problems and tips.

## Cheating

Cheating is not an acceptable method for completing your projects. The consequences of cheating will correspond to the severity (e.g., failure of the assignment, failure of the course). The [academic honesty guidelines](http://cseweb.ucsd.edu/~elkan/honesty.html) outlined by Charles Elkan for CSE 130 apply to this course.

I urge you to resist any temptation to cheat, both on the projects as well as the homeworks and exams, no matter how desperate the situation may seem. If you are in circumstances that you feel compel you to cheat, come to me first before you do so.
