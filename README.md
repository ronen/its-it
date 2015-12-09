# its-it


## Overview

This gem defines kernel methods `its` and `it` that queue and defer method
calls. This is handy for list comprehension and case statements.

[![Gem Version](https://badge.fury.io/rb/its-it.png)](http://badge.fury.io/rb/its-it)
[![Build Status](https://secure.travis-ci.org/ronen/its-it.png)](http://travis-ci.org/ronen/its-it)
[![Dependency Status](https://gemnasium.com/ronen/its-it.png)](https://gemnasium.com/ronen/its-it)

## List Comprehension

`its` and `it` extend the Symbol#to_proc idiom to support chaining multiple
methods.

The pure Ruby way to chain methods when iterating through a list would be:

```ruby
users.map{|user| user.contact}.map{|contact| contact.last_name}.map{|name| name.capitalize}
```

Using `Symbol#to_proc`, this becomes simpler (at the cost of generating intermediate arrays):

```ruby
users.map(&:contact).map(&:last_name).map(&:capitalize)
```

And using `its`, this becomes becomes simpler still:

```ruby
users.map(&its.contact.last_name.capitalize)
```

Note that `its` captures arguments and blocks, allowing you to do things like

```ruby
users.map(&its.contact.last_name[0,3].capitalize)
```

or

```ruby
users.select(&its.addresses.any? { |address| airline.flies_to address.city })
```


`it` is an alias for `its`, to use with methods that describe actions rather
than posessives. For example:

```ruby
items.map(&it.to_s.capitalize)
```

## Case statements

`its` and `it` likewise extend Ruby's `case` statement to support testing
arbitrary methods, minimizing the need to create temporary variables and use
`if-elsif` constructs.

In pure Ruby, doing comparisons on computed values would be done something
like this:

```ruby
maxlen = arrays.map(&size).max
if maxlen > 10000
    "too big"
elsif maxlen < 10
    "too small"
else
    "okay"
end
```

But using `it` this becomes:

```ruby
case arrays.map(&size).max
when it > 1000
    "too big"
when it < 10
    "too small"
else
    "okay"
end
```

Of course method chanining can be used here too:

```ruby
case users.first
when its.name == "Gimme Cookie" then ...
when its.name.length > 10 then ...
else ...
end
```

## Under the hood

The `ItsIt::It` class uses `method_missing` to capture and queue up all
methods and their arguments, with the exception of `:to_proc` and `:===` (and
also excepting `:respond_to? :to_proc` and `:respond_to? :===`).

`:to_proc` returns a proc that will evaluate the method queue on a given
argument.  `:===` takes an argument and evaluates that proc, returning the
result.

## Installation

Install as usual from http://rubygems.org via

```bash
$ gem install "its-it"
```

or in a Gemfile

```ruby
gem "its-it"
```

## Compatibility

Tested on MRI ruby 1.8.7, 1.9.3, 2.0.0 and 2.2.3

## History

Release Notes

*   1.1.1 Remove dependency on BlankSlate

This gem is orignally based on Jay Philips'
[methodphitamine](https://github.com/jicksta/methodphitamine) gem. It has been
updated to be compatible with ruby 1.9 and gemspec, added case statement
support, renamed its-it, and installed on [rubygems.org](http://rubygems.org).
 Unlike methodphitamine, this gem includes only `its` and `it`, not the
"maybe" monad.

