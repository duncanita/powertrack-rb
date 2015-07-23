require 'exponential_backoff'

module PowerTrack
  class Retrier
    attr_reader :retries, :max_retries

    # the default number of seconds b/w 2 attempts
    DEFAULT_MIN_INTERVAL = 1.0
    # the default maximum number of seconds to wait b/w 2 attempts
    DEFAULT_MAX_ELAPSED_TIME = 30.0
    # the default interval multiplier
    DEFAULT_INTERVAL_MULTIPLIER = 1.5
    # the default randomize factor
    DEFAULT_RANDOMIZE_FACTOR = 0.25

    DEFAULT_OPTIONS = {
      min_interval: DEFAULT_MIN_INTERVAL,
      max_elapsed_time: DEFAULT_MAX_ELAPSED_TIME,
      multiplier: DEFAULT_INTERVAL_MULTIPLIER,
      randomize_factor: DEFAULT_RANDOMIZE_FACTOR
    }

    def initialize(max_retries, options=nil)
      options = DEFAULT_OPTIONS.merge(options || {})

      @max_retries = max_retries
      @retries = 0
      @continue = true
      @backoff = ExponentialBackoff.new(options[:min_interval], options[:max_elapsed_time])
      @backoff.multiplier = options[:multiplier]
      @backoff.randomize_factor = options[:randomize_factor]
    end

    def reset!
      @retries = 0
      @backoff.clear
    end

    def stop
      @continue = false
    end

    def retry(&block)
      # TODO: manage exceptions
      while @continue && @retries < @max_retries
        res = yield
        if @continue
          @retries += 1
          sleep(@backoff.next_interval)
        end
      end

      res
    end
  end
end
