- pool worker removes files (photos) from dropbox photo |pool| and places them
  in |transitory| s3 bucket
- thumb worker takes photos (files) from |transitory| s3 bucket, resizes them
  (thumbs), and places output in permanent bucket
- all (worker) operations are idempotent 

- web server displays fading photo tiles at masonic.io/photos
