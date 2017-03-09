# theclearcoder.com [![Build Status](https://travis-ci.org/theclearcoder/theclearcoder.com.svg?branch=master)](https://travis-ci.org/theclearcoder/theclearcoder.com) [![Coverage Status](https://coveralls.io/repos/github/theclearcoder/theclearcoder.com/badge.svg)](https://coveralls.io/github/theclearcoder/theclearcoder.com)

## What is this?

This is the CMS for my personal website.  It's written in [Elixir](http://elixir-lang.org), built with [Phoenix](http://www.phoenixframework.org), and runs on [Heroku](https://www.heroku.com/).

## Why is it here?

I'm really excited about Elixir and Phoenix, so I built my personal site using them.  I also wanted to open source the code so I can share it with others and have a place I can refer to when working on other projects.

*This project was not meant to be forked.  Please use it for learning, reference, or examples.*

## What if I want to run it locally to learn?

1. Download this repo from GitHub.
2. Install PostgreSQL.
3. Install Erlang and Elixir.
4. Run the following steps:

```
mix ecto.create
mix ecto.migrate
mix run priv/repo/seeds.exs
mix phoenix.server
```

Have fun!
