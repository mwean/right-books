class HomePage < SitePrism::Page
  set_url '/'
  set_url_matcher(//)

  section :new_releases, NewReleasesSection, '[data-new-releases]'
  section :categories, CategoriesSection, '[data-categories]'
  section :navbar, NavbarSection, '.primary-header .nav'
end
