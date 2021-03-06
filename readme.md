AppGen: Menu
===
## How to
To start webapp
```
$ bundle install
$ bundle exec shotgun
```

Then visit...
http://localhost:9393/

#Production
  * http://appgen.me (via appgen.herokuapp.com, mirrored at bigappgen.herokuapp.com)
  * To browse apps: /browse/a
  * Standalone apps: /a
  * NYC Open Data Portal Audit: /audit


## Important details

### App name
As we develop AppGen, existing apps will randomly change. That is fine; it
reflects the improvements on the apps. However, the name of the app should
should not change very much. This is because each app will be associated with
a particular domain name that we're going to tell people about.

In order to keep the name consistent, we are setting the random seed inside of
`FakeApp.getRandomName`. **Don't change this**. In fact, you should probably.
avoid changing anything about this method.

## Things to randomize

* Identity
  * ~~App name (from a startup name generator)~~
  * ~~App text (from the TED talk generator)~~
  * App logo (from a logo generator)
  * Url file extension (php, asp, cgi)
  * ~~Server header~~
* Chrome
  * ~~Font size of title~~
  * ~~Typeface~~
  * Background texture
  * ~~Colors~~
  * Footer stickiness
  * ~~Tile server~~
  * ~~Button curviness~~
  * ~~Map size~~

I propose these routes

    /
    /a -> Display titles, screenshots, &c. of a few apps with links to the apps.
    /a/:seed -> An app
    /a/:seed/map -> An app's map page
    /a/:seed/contact -> An app's contact page
    /a/:seed/styles.css -> And so on

