class HomePage < SitePrism::Page
  set_url '/'
  set_url_matcher(//)

  section :new_releases, NewReleasesSection, '[data-new-releases]'
end
