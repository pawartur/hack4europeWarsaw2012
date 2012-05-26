# This is my README

## API Examples

### Posting comment

POST (new comment) -> http://192.168.99.52:8000/api/v1/comment/
POST (new comment) -> http://127.0.0.1:8000/api/v1/comment/

{"profile": "/api/v1/profile/john/", "venue": "/api/v1/venue/csw/", "comment": "New comment."}

### Posting comment

POST (new rating) -> http://192.168.99.52:8000/api/v1/rating/
POST (new rating) -> http://127.0.0.1:8000/api/v1/rating/

{"profile": "/api/v1/profile/mary/", "venue": "/api/v1/venue/mn/", "rating": 5}

### Getting comments about given venue

GET -> http://192.168.99.52:8000/api/v1/venue/csw/comments/?format=json
GET -> http://127.0.0.1:8000/api/v1/venue/csw/comments/?format=json

### Getting resources of given venue

GET -> http://192.168.99.52:8000/api/v1/venue/mn/resources/?format=json
GET -> http://127.0.0.1:8000/api/v1/venue/mn/resources/?format=json