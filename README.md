[![Build Status](https://travis-ci.org/mlibrary/swapmeet.svg?branch=master)](https://travis-ci.org/mlibrary/swapmeet)
[![Coverage Status](https://coveralls.io/repos/github/mlibrary/swapmeet/badge.svg?branch=master)](https://coveralls.io/github/mlibrary/swapmeet?branch=master)

# Swapmeet

Swapmeet is a sample application for demonstrating how to build Rails
applications with policies and presenters. It relies on three libraries for
support:

- [Keycard](https://github.com/mlibrary/keycard) for authentication and user/request attributes
- [Checkpoint](https://github.com/mlibrary/checkpoint) for policy-based authorization
- [Vizier](https://github.com/mlibrary/vizier) for policy-aware presenters


## Development

To make it convenient to co-develop Swapmeet and the above libraries, you
should clone those repositories and configure Bundler to use your local copies
rather than caching them itself. This is done with `bundle.config`; for example:

```
bundle config disable_local_branch_check true
bundle config local.keycard ~/dev/keycard`
```

When running `rails server` in development mode, the gems are auto-reloaded, so
changes should apply immediately on new requests.

## License

Swapmeet is licensed under the BSD-3-Clause license. See [LICENSE.md](LICENSE.md).
