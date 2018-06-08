These scripts exercise rgw to try to induce a race condition that
existed at one time in the ceph code base. The directory structure is
assumed to be something like:

top-level:
  ceph: ceph repo
    build: cmake build directory
  rgw-w-race-test: this repo

Once you've built ceph, go to the build directory and run:

  ../../rgw-w-race-test/gen-bucket-index-error

The test will stop when it detets the race condition, as an object
that should have been deleted will remain in the test bucket. The test
will keep running as long as the race has not been detected.
