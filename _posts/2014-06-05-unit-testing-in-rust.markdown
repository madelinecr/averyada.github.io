---
date: 2014-06-05
layout: post
title: Unit Testing in Rust
---

[Rust][rustlang] is a new open source systems programming language which
guarantees memory safety and supports concurrency without data races. It's not
actually an official Mozilla project, but rather something to come out of the
Mozilla community. It's a compiled, minimal runtime language that manages to
feel like C++ and Ruby at the same time. The current "stable" release is 0.10,
and many things are in flux currently as developers work hard to push towards
the 1.0 release.

I've just been scratching the surface of the features of Rust, but I was very
intrigued by the built in unit testing framework and how it integrates with Rust
code.

Your unit tests can live within the same file as your actual code. I'm not sure
whether this is Rust best practice or not, the standard idioms for Rust code are
still being worked out too. If functions are marked with a `#[test]` identifier,
it tells the rust compiler that the function is a unit test. Here's an example.

    fn three_divides(num: int) -> bool {
      num % 3 == 0
    }

    fn main() {
      for num in range(1, 10) {
        if three_divides(num) { println("Three divides " + num.to_str()) }
        else { println("Three doesn't divide " + num.to_str()) }
      }
    }

    #[test]
    fn test_three_doesnt_divide() {
      assert!(!three_divides(2));
    }

    #[test]
    fn test_three_divides() {
      assert!(three_divides(3));
    }

To run your application, it's pretty straightforward. Invoke the rust
compiler, `rustc` with your source code and it'll hopefully output a binary.
Run that binary and watch as your code runs. The test functions were ignored,
their symbols never even added to your executable.

    λ ~/ rustc divide.rs
    λ ~/ ./divide 
    Three doesn't divide 1
    Three doesn't divide 2
    Three divides 3
    Three doesn't divide 4
    Three doesn't divide 5
    Three divides 6
    Three doesn't divide 7
    Three doesn't divide 8
    Three divides 9

When it's time to run your tests, compile your application again but this time
pass the `--test` flag to `rustc`. It will remove your main function, instead
compiling your application with a test runner that automatically knows to run
all your functions marked with `#[test]`. Note that `assert!` calls a function
which returns a boolean, and if `assert!` receives `true` it passes the unit
test. Obviously the reverse will fail the test.

    λ ~/ rustc --test divide.rs
    λ ~/ ./divide 

    running 2 tests
    test test_three_divides ... ok
    test test_three_doesnt_divide ... ok

    test result: ok. 2 passed; 0 failed; 0 ignored; 0 measured

Having this kind of unit testing support baked right into the language is really
nice, and I couldn't stop thinking about how convenient this kind of testing is.
It lowers the barrier to writing tests and removes a lot of headache about
setting up a testing framework or environment.

[rustlang]: http://www.rust-lang.org/
