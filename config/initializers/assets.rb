# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
#home
Rails.application.config.assets.precompile += %w(portfolio.js)
Rails.application.config.assets.precompile += %w(home.css)

# dashboard
Rails.application.config.assets.precompile += %w(dashboard.css)
Rails.application.config.assets.precompile += %w(dashboard.js)
Rails.application.config.assets.precompile += %w(date.js)
Rails.application.config.assets.precompile += %w(login.js)
Rails.application.config.assets.precompile += %w(register_courses.js)
Rails.application.config.assets.precompile += %w(members/exams.js)
Rails.application.config.assets.precompile += %w(ckeditor/filebrowser/images/gal_del.png)
Rails.application.config.assets.precompile += %w(teachers/user_register_courses.js)
Rails.application.config.assets.precompile += %w(members/registered_courses.js)
