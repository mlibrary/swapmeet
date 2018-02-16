# frozen_string_literal: true

# These are fakes for testing presenter configs.
# They're set up here, rather than individual tests because of the funny
# business of const_get, auto reloading, and redefining constants with Struct.
# A require makes sure that these are available to both the reloading and
# caching configs without throwing warnings.

class FakeType; end
FakePresenter = Struct.new(:policy, :view)
FakePolicy = Struct.new(:user, :object)

class OtherFakeType; end
OtherFakePresenter = Struct.new(:policy, :view)
OtherFakePolicy = Struct.new(:user, :object)
