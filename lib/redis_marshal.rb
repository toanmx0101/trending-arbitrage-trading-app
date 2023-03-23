# frozen_string_literal: true

require "redis"

$redis = Redis.new

class RedisMarshal
  def self.set key, value
    $redis.set key, Marshal.dump(value)
    value
  end

  # rubocop:disable Security/MarshalLoad
  def self.get key
    from_redis = $redis.get(key)
    return nil if from_redis == "" || !from_redis

    Marshal.load from_redis
  end
  # rubocop:enable Security/MarshalLoad

  def self.fetch key
    from_redis = get(key)
    return from_redis if from_redis

    value = yield
    set(key, value)
  end

  def self.del key
    $redis.del key
  end
end
