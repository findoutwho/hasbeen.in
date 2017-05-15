# Welcome to hasbeen.in, your geek-friendly travel site.

[![Travis Build Status](https://travis-ci.org/findoutwho/hasbeen.in.png?branch=master)](https://travis-ci.org/findoutwho/hasbeen.in)

Find out where your fellow geeks have been, add yourself:

* Fork this repo
* Add your traveller file (*)
* Send a pull request

### Testing locally

Install all required Gems and start up Padrino:

``` bash
$ bundle install
Using rake 10.1.1
[…]
Using thin 1.6.1
Bundle complete! 15 Gemfile dependencies, 46 gems now installed.
Use `bundle show [gemname]` to see where a bundled gem is installed.

$
```

Using [nip.io](http://nip.io) you should reach hasbeen.in at:
[www.hasbeen.in.127.0.0.1.nip.io](http://www.hasbeen.in.127.0.0.1.nip.io:3000/).

### Traveller Profiles

(*) You'll find the profiles in `config/travellers`. The
filename will be your subdomain name, so `bascht.yaml` will
be available at [bascht.hasbeen.in](http://bascht.hasbeen.in).
Should a place be ambiguous, add a hash with the display
name as key and a long name as a value for a city.

    name: "Bascht"
    profile:
      web: "http://bascht.com"
      twitter: "bascht"
      gravatar: "8656dc5476c819d4dcbd932a5744122a"
      current_hometown: "München, Deutschland"
    hasbeen:
      cities:
        - "Leipzig"
        - "Hamburg"
        - "Oelsnitz"
        - "Cologne"
        - {"Amerika": "Amerika, Penig, Deutschland"}
    […]

#### Validating your files

If you want to validate your pull request before actually
submitting it as an issue, use the built-in Rake task:

```shell
RACK_ENV=development bundle exec rake validate:travellers
```

--
