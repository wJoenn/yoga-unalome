Rails.application.configure do
  # preserve_job_records (boolean) keeps job records in your database even after jobs are completed. (Default: true)
  # config.good_job.preserve_job_records = true

  # retry_on_unhandled_error (boolean) causes jobs to be re-queued and retried if they raise an instance of
  # StandardError. Be advised this may lead to jobs being repeated infinitely (see below for more on retries).
  # Instances of Exception, like SIGINT, will always be retried, regardless of this attribute’s value. (Default: false)
  # config.good_job.retry_on_unhandled_error = false

  # on_thread_error (proc, lambda, or callable) will be called when there is an Exception. It can be useful for logging
  # errors to bug tracking services, like Sentry or Airbrake.
  # config.good_job.on_thread_error = -> (exception) { Sentry.capture_exception(exception) }

  # execution_mode (symbol) specifies how and where jobs should be executed. You can also set this with the environment
  # variable GOOD_JOB_EXECUTION_MODE. It can be any one of:
  #   :inline executes jobs immediately in whatever process queued them (usually the web server process). This should
  #    only be used in test and development environments.
  #   :external causes the adapter to enqueue jobs, but not execute them. When using this option (the default for
  #    production environments), you’ll need to use the command-line tool to actually execute your jobs.
  #   :async (or :async_server) executes jobs in separate threads within the Rails web server process (bundle exec rails
  #    server). It can be more economical for small workloads because you don’t need a separate machine or environment
  #    for running your jobs, but if your web server is under heavy load or your jobs require a lot of resources, you
  #    should choose :external instead. When not in the Rails web server, jobs will execute in :external mode to ensure
  #    jobs are not executed within rails console, rails db:migrate, rails assets:prepare, etc.
  #   :async_all executes jobs in separate threads in any Rails process.
  # By default, GoodJob configures the following execution modes per environment:
  # config/environments/development.rb
  # config.active_job.queue_adapter = :good_job
  # config.good_job.execution_mode = :async
  # config/environments/test.rb
  # config.active_job.queue_adapter = :good_job
  # config.good_job.execution_mode = :inline
  # config/environments/production.rb
  # config.active_job.queue_adapter = :good_job
  # config.good_job.execution_mode = :external
  config.good_job.execution_mode = :async

  # queues (string) sets queues or pools to execute jobs. You can also set this with the environment variable
  # GOOD_JOB_QUEUES.
  # config.good_job.queues = '*'

  # max_threads (integer) sets the default number of threads per pool to use for working jobs. You can also set this
  # with the environment variable GOOD_JOB_MAX_THREADS.
  # config.good_job.max_threads = 5

  # poll_interval (integer) sets the number of seconds between polls for jobs when execution_mode is set to :async. You
  # can also set this with the environment variable GOOD_JOB_POLL_INTERVAL. A poll interval of -1 disables polling
  # completely.
  # config.good_job.poll_interval = 30 # seconds

  # max_cache (integer) sets the maximum number of scheduled jobs that will be stored in memory to reduce execution
  # latency when also polling for scheduled jobs. Caching 10,000 scheduled jobs uses approximately 20MB of memory. You
  # can also set this with the environment variable GOOD_JOB_MAX_CACHE.
  # config.good_job.max_cache = 10_000


  # shutdown_timeout (integer) number of seconds to wait for jobs to finish when shutting down before stopping the
  # thread. Defaults to forever: -1. You can also set this with the environment variable GOOD_JOB_SHUTDOWN_TIMEOUT.
  # config.good_job.shutdown_timeout = 25 # seconds

  # enable_cron (boolean) whether to run cron process. Defaults to false. You can also set this with the environment
  # variable GOOD_JOB_ENABLE_CRON.
  # config.good_job.enable_cron = true

  # cron (hash) cron configuration. Defaults to {}. You can also set this as a JSON string with the environment variable
  # GOOD_JOB_CRON
  # config.good_job.cron = { example: { cron: '0 * * * *', class: 'ExampleJob'  } }

  # enable_listen_notify (boolean) whether to enqueue and read jobs with Postgres LISTEN/NOTIFY. Defaults to true. You
  # can also set this with the environment variable GOOD_JOB_ENABLE_LISTEN_NOTIFY.
  # config.good_job.enable_listen_notify = true

  # cleanup_discarded_jobs (boolean) whether to destroy discarded jobs when cleaning up preserved jobs using the $
  # good_job cleanup_preserved_jobs CLI command or calling GoodJob.cleanup_preserved_jobs. Defaults to true. Can also be
  # set with the environment variable GOOD_JOB_CLEANUP_DISCARDED_JOBS. This configuration is only used when
  # {GoodJob.preserve_job_records} is true.
  # config.good_job.cleanup_discarded_jobs = true

  # cleanup_preserved_jobs_before_seconds_ago (integer) number of seconds to preserve jobs when using the $ good_job
  # cleanup_preserved_jobs CLI command or calling GoodJob.cleanup_preserved_jobs. Defaults to 1209600 (14 days). Can
  # also be set with the environment variable GOOD_JOB_CLEANUP_PRESERVED_JOBS_BEFORE_SECONDS_AGO. This configuration is
  # only used when {GoodJob.preserve_job_records} is true.
  # config.good_job.cleanup_preserved_jobs_before_seconds_ago = 1209600

  # cleanup_interval_jobs (integer) Number of jobs a Scheduler will execute before cleaning up preserved jobs. Defaults
  # to 1000. Disable with false. Can also be set with the environment variable GOOD_JOB_CLEANUP_INTERVAL_JOBS and
  # disabled with 0).
  # config.good_job.cleanup_interval_job = 1000

  # cleanup_interval_seconds (integer) Number of seconds a Scheduler will wait before cleaning up preserved jobs.
  # Defaults to 600 (10 minutes). Disable with false. Can also be set with the environment variable
  # GOOD_JOB_CLEANUP_INTERVAL_SECONDS and disabled with 0).
  # config.good_job.cleanup_interval_seconds = 600

  # inline_execution_respects_schedule (boolean) Opt-in to future behavior of inline execution respecting scheduled
  # jobs. Defaults to false.
  # config.good_job.inline_execution_respects_schedule = false

  # logger (Rails Logger) lets you set a custom logger for GoodJob. It should be an instance of a Rails Logger
  #(Default: Rails.logger).
  # config.good_job.logger = Rails.logger
end
