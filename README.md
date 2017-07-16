# README

## Purpose

The app provides a simple interface to adding a csv containing links to 2 images per row
and creating and a new image that is a watermarked "concatenation" of the first 2 images.

The output is a csv file containing the URLs for all processed images.

## Notes

* The heavy lifting of performing the image processing is done using background jobs
with the help of Sidekiq.

* The app expects a database (development done using Postgres) and a Redis instance present.
The URL for the Redis endpoint is read through the **REDIS_URL** environment variable
(defaults to localhost:6379 in development).

* The Sidekiq web ui is mounted and can be used to monitor the background jobs handled by
Sidekiq. It is mounted at /sidekiq.

* The download actions, triggers the creation of the CSV file on the fly. The CSV will
contain all processed image links whose jobs have successfully terminated by the time
the action is invoked.

* If an entry on the uploaded csv is invalid, it is ignored and the processing will 
continue with the rest of the csv.

* The pair of input image links is considered unique, and any entries having the same
pair of links will be ignored.

## Further Work

* The app currently creates the CSV from scratch each time the download action is called.
If the amount of images saved grows sufficiently large, this can take a significant amount
of time and resources. A possible solution would be to cache a CSV file and spawn a background
job to create it, when new images are uploaded.

* A tool for viewing already uploaded images could be creating for on the spot reviewing
of uploaded images.

## Usage

### Locally

To run locally:

* Start Sidekiq engine by executing:

```
sidekiq
```

* Start Rails server:

```
rails s
``` 

### Heroku

A Procfile is provided for starting the app on heroku. However some initial configuration
is needed.

To deploy on Heroku:

* Create app:

```
heroku create
```

* Provision Redis:

```
heroku addons:create heroku-redis:hobby-dev
```

* Configure Redis enpoint:

```
heroku config:set REDIS_PROVIDER=REDIS_URL 
```

* Deploy application:

```
git push heroku master
```

* Provision worker dyno:

```
heroku ps:scale worker=1
```

## Testing

RSpec was used for testing. The tests can be run with the following command:

```
rails spec
```