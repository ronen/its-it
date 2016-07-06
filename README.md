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

When performing a list comprehension ruby, you can use a block argument:


```ruby
users.map{ |user| user.contact }
```

Or, to avoid needing the block and and extra parameter, you can use the `Symbol#to_proc` shortcut:

```ruby
users.map &:contact
```

But if you want to chain several methods, such as:

```ruby
users.map{ |user| user.contact.last_name.capitalize }
```

The `Symbol#to_proc` shortcut doesn't help much.  At best, if you're willing to accept intermediate arrays, you can do:

```ruby
users.map(&:contact).map(&:last_name).map(&:capitalize)
```

To improve the situation, this gem provides a Kernel method `its`, which lets you get the same shortcut advantages as `Symbol#to_proc` but supports chaining:

```ruby
users.map &its.contact.last_name.capitalize
```

Also, `its` supports arguments and blocks, allowing you to do things like

```ruby
users.map &its.contact.last_name[0,3].capitalize
users.select &its.contact.last_name.length > 10
users.select(&its.addresses.any? { |address| airline.flies_to address.city })
```

As a syntactic sugar, `it` is an alias for `its`, to use with methods that describe actions rather than posessives. For example:

```ruby
items.map &it.to_s.capitalize
```

### Hash comprehensions

When used with hash comprehensions, the `|key, val|` pair of arguments are presented to `its` as a tuple that can be accessed array-like via `[0]` or `[1]` and/or struct-like via `#key` and `#value` methods.  E.g.

```ruby
{dogs: 1, cats: 2, goats:3}.select &its.key =~ /^c/ # => {cats: 2}
{dogs: 1, cats: 2, goats:3}.select &its.value.even? # => {cats: 2}
{dogs: 1, cats: 2, goats:3}.select &its[1].even? # => {cats: 2}
```

## Case statements

`its` and `it` similarly extend Ruby's `case` mechanism to support testing
arbitrary methods, minimizing the need to create temporary variables.  That is, instead of:

```ruby
maxlen = arrays.map(&size).max
case
when maxlen > 10000 then "too big"
when maxlen < 10    then "too small"
else                     "okay"
end
```

You can use `it`:

```ruby
case arrays.map(&size).max
when it > 1000 then "too big"
when it < 10   then "too small"
else                "okay"
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

The `it` method creates an instance of the `ItsIt::It` class, which uses `method_missing` to capture and queue up all
methods and their arguments except for `:to_proc` and `:===` (and
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

Tested on MRI ruby 1.9.3, 2.1.9, 2.2.5, and 2.3.1

(MRI ruby 1.8.7 was supported up through version 1.1.1)

## History

Release Notes

* 1.2.1 Don't leak all of ItsIt into main, just ItsIt::Kernel.  Thanks to [klg](https://github.com/kjg)
* 1.2.0 Add support for Hash comprehensions; drop support for ruby 1.8.7
* 1.1.1 Remove dependency on BlankSlate

This gem is orignally based on Jay Philips'
[methodphitamine](https://github.com/jicksta/methodphitamine) gem. It has been
updated to be compatible with ruby 1.9 and gemspec, added case statement
support, renamed its-it, and installed on [rubygems.org](http://rubygems.org).
 Unlike methodphitamine, this gem includes only `its` and `it`, not the
"maybe" monad.

