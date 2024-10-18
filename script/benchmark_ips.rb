require_relative "../config/environment"

require "benchmark/ips"

# NOTE: we expect a freshly seeded database with millions of records
#
# Simple benchmark that does N+M queries to compare SQLite and PostgreSQL performance
#
# Adapt the limits to test with more queries
#
@stuff_limit = 200
@comment_limit = 500
@reactions_limit = 3

def sqlite
  LiteStuff.limit(@stuff_limit).each do |stuff|
    stuff.comments.limit(@comment_limit).each do |comment|
      comment.reactions.limit(@reactions_limit).each do |reaction|
        # puts reaction.body
      end
    end
  end
end

def postgres
  PgStuff.limit(@stuff_limit).each do |stuff|
    stuff.pg_comments.limit(@comment_limit).each do |comment|
      comment.pg_reactions.limit(@reactions_limit).each do |reaction|
        # puts reaction.body
      end
    end
  end
end

Benchmark.ips do |x|
  # Configure the number of seconds used during
  # the warmup phase (default 2) and calculation phase (default 5)
  x.config(warmup: 2, time: 5)

  # Typical mode, runs the block as many times as it can
  x.report('postgres:') { postgres }
  x.report('sqlite:') { sqlite }

  # Compare the iterations per second of the various reports!
  x.compare!
end
