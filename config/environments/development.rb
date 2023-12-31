# frozen_string_literal: true

require 'active_support/core_ext/integer/time'

Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded any time
  # it changes. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable server timing
  config.server_timing = true

  # Enable/disable caching. By default caching is disabled.
  # Run rails dev:cache to toggle caching.
  if Rails.root.join('tmp/caching-dev.txt').exist?
    config.action_controller.perform_caching = true
    config.action_controller.enable_fragment_cache_logging = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  # Store uploaded files on the local file system (see config/storage.yml for options).
  config.active_storage.service = :local

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  config.action_mailer.perform_caching = false

  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise exceptions for disallowed deprecations.
  config.active_support.disallowed_deprecation = :raise

  # Tell Active Support which deprecation messages to disallow.
  config.active_support.disallowed_deprecation_warnings = []

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Highlight code that triggered database queries in logs.
  config.active_record.verbose_query_logs = true

  # Suppress logger output for asset requests.
  config.assets.quiet = true

  # Raises error for missing translations.
  # config.i18n.raise_on_missing_translations = true

  # Annotate rendered view with file names.
  # config.action_view.annotate_rendered_view_with_filenames = true

  # Uncomment if you wish to allow Action Cable access from any origin.
  # config.action_cable.disable_request_forgery_protection = true
  config.good_job.smaller_number_is_higher_priority = true

  config.good_job.enable_cron = true
  config.good_job.cron = {
    # Every 15 minutes, enqueue `ExampleJob.set(priority: -10).perform_later(42, "life", name: "Alice")`
    frequent_task: { # each recurring job must have a unique key
                     cron: "*/10 * * * *", # cron-style scheduling format by fugit gem
                     class: "BlingOrderItemCreatorJob", # name of the job class as a String; must reference an Active Job job class
                     args: [1], # positional arguments to pass to the job; can also be a proc e.g. `-> { [Time.now] }`
                     set: { priority: 2 }, # additional Active Job properties; can also be a lambda/proc e.g. `-> { { priority: [1,2].sample } }`
                     description: "Create Order Items per situation" # optional description that appears in Dashboard
    },
    in_progress_order_items_task: { # each recurring job must have a unique key
                     cron: "*/1 * * * *", # cron-style scheduling format by fugit gem
                     class: "InProgressOrderItemsJob", # name of the job class as a String; must reference an Active Job job class
                     args: [1], # positional arguments to pass to the job; can also be a proc e.g. `-> { [Time.now] }`
                     set: { priority: 1 }, # additional Active Job properties; can also be a lambda/proc e.g. `-> { { priority: [1,2].sample } }`
                     description: "Create Order Items with status in progress" # optional description that appears in Dashboard
    },

    pending_order_items_task: { # each recurring job must have a unique key
                     cron: "*/1 * * * *", # cron-style scheduling format by fugit gem
                     class: "PendingOrderItemsJob", # name of the job class as a String; must reference an Active Job job class
                     args: [1], # positional arguments to pass to the job; can also be a proc e.g. `-> { [Time.now] }`
                     set: { priority: 1 }, # additional Active Job properties; can also be a lambda/proc e.g. `-> { { priority: [1,2].sample } }`
                     description: "Create Order Items with pending status" # optional description that appears in Dashboard
    },

    printed_order_items_task: { # each recurring job must have a unique key
                     cron: "*/1 * * * *", # cron-style scheduling format by fugit gem
                     class: "PrintedOrderItemsJob", # name of the job class as a String; must reference an Active Job job class
                     args: [1], # positional arguments to pass to the job; can also be a proc e.g. `-> { [Time.now] }`
                     set: { priority: 1 }, # additional Active Job properties; can also be a lambda/proc e.g. `-> { { priority: [1,2].sample } }`
                     description: "Create Order Items with printed status" # optional description that appears in Dashboard
    },

    current_done_order_items_task: { # each recurring job must have a unique key
                     cron: "*/1 * * * *", # cron-style scheduling format by fugit gem
                     class: "CurrentDoneBlingOrderItemJob", # name of the job class as a String; must reference an Active Job job class
                     args: [1], # positional arguments to pass to the job; can also be a proc e.g. `-> { [Time.now] }`
                     set: { priority: 1 }, # additional Active Job properties; can also be a lambda/proc e.g. `-> { { priority: [1,2].sample } }`
                     description: "Create Order Items statuses are checked and verified" # optional description that appears in Dashboard
    }
    # etc.
  }
end
