# its-it


## Overview

This gem defines kernel methods `its` and `it` that queue and defer method
calls. This is handy for list enumeration and case statements.

[<img src="https://secure.travis-ci.org/ronen/its-it.png"/>](http://travis-ci.org/ronen/its-it)[<img src="https://gemnasium.com/ronen/its-it.png" alt="Dependency Status" />](https://gemnasium.com/ronen/its-it)

## List Enumeration

`its` and `it` extend the Symbol#to_proc idiom to support chaining multiple
methods.

The pure Ruby way to chain methods when enumerating a list would be:

    users.collect{|user| user.contact}.collect{|contact| contact.last_name}.collect{|name| name.capitalize}

Using `Symbol#to_proc`, this becomes simpler:

    users.collect(&:contact).collect(&:last_name).collect(&:capitalize)

And using `its`, this becomes becomes simpler still:

    users.collect(&its.contact.last_name.capitalize)

Note that `its` captures arguments and blocks, allowing constructs like this,
which will select users whose names include any non-hyphenated word that's
more than 10 letters long:
    users.select(&its.name.split(/ /).reject{|word| word =~ /-/}.collect(&:length).max > 10)

`it` is an alias for `its`, to use with methods that describe actions rather
than posessives. For example:

    items.collect(&it.to_s.capitalize)

## Case statements

`its` and `it` likewise extend Ruby's `case` statement to support testing
arbitrary methods, minimizing the need to create temporary variables and use
`if-elsif` constructs.

In pure Ruby, doing comparisons on computed values would be done something
like this:

    maxlen = arrays.collect(&size).max
    if maxlen > 10000
        "too big"
    elsif maxlen < 10
        "too small"
    else
        "okay"
    end

But using `it` this becomes:

    case arrays.collect(&size).max
    when it > 1000
        "too big"
    when it < 10
        "too small"
    else
        "okay"
    end

Of course method chanining can be used here too:

    case users.first
    when its.name == "Gimme Cookie" then ...
    when its.name.length > 10 then ...
    else ...
    end

## Under the hood

The `ItsIt::It` class uses `method_missing` to capture and queue up all
methods and their arguments, with the exception of `:to_proc` and `:===` (and
also excepting `:respond_to? :to_proc` and `:respond_to? :===`).

`:to_proc` returns a proc that will evaluate the method queue on a given
argument.  `:===` takes an argument and evaluates that proc, returning the
result.

## Installation

Install from http://rubygems.org via

    $ gem install "its-it"

or in a Gemfile

    gem "its-it"

## Compatibility

Works with MRI ruby 1.8.7, 1.9.3, 2.0.0

## History

This gem is orignally based on Jay Philips'
[methodphitamine](https://github.com/jicksta/methodphitamine) gem. It has been
updated to be compatible with ruby 1.9 and gemspec, added case statement
support, renamed its-it, and installed on [rubygems.org](http://rubygems.org).
 Unlike methodphitamine, this gem includes only `its` and `it`, not the
"maybe" monad.

Release Notes
*   1.1.1 Remove dependency on BlankSlate

