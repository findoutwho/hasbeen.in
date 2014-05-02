# Welcome to hasbeen.in, your geek-friendly travel site.

[![Travis Build Status](https://travis-ci.org/bascht/hasbeen.in.png?branch=master)](https://travis-ci.org/bascht/hasbeen.in)

Find out where your fellow geeks have been, add yourself:

* Fork this repo
* Add your traveller file (*)
* Send a pull request

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
submitting it as an issue, use the built-int Rake task:

```shell
RACK_ENV=development bundle exec rake validate:travellers
```

--
