#!/bin/sh

DIR="$( cd "$( dirname "$0" )" && pwd )"
$DIR/../manage.py reset_db --router=default
$DIR/../manage.py syncdb --noinput
$DIR/../manage.py loaddata $DIR/../fixtures/auth.json
$DIR/../manage.py loaddata $DIR/../fixtures/resources.json
$DIR/../manage.py loaddata $DIR/../fixtures/profiles.json
$DIR/../manage.py loaddata $DIR/../fixtures/ratings.json
$DIR/../manage.py loaddata $DIR/../fixtures/comments.json