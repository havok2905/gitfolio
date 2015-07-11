# Builds a profile hash from a series of related models
class ProfileViewModel
  class << self
    def build(args)
      profile   = args[:profile]
      languages = args[:languages]
      whitelist = args[:whitelist]

      {
        name:      profile.full_name,
        nickname:  profile.nickname,
        position:  profile.position,
        tagline:   profile.tagline,
        email:     profile.email,
        languages: languages,
        whitelist: whitelist
      }
    end
  end
end
