# Contributing

## Release Checklist

To build and ship a new version of this gem, you need to follow these steps:

1. Update changelog.
2. Change version in `lib/capistrano/wearerequired/version.rb`.
3. Build new gem using `gem build capistrano-wearerequired.gemspec`.
4. Publish gem using `gem push capistrano-wearerequired-<version>.gem`, e.g. `gem push capistrano-wearerequired-1.3.0.gem`.
5. Tag latest commit with `v<version>`, e,g. `v1.3.0`.
6. Merge `master` branch into `stable`
