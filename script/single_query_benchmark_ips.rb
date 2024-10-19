require_relative "../config/environment"

require "benchmark/ips"

# NOTE: we expect a freshly seeded database with millions of records
#
# Simple benchmark that does many small queries to compare SQLite and PostgreSQL performance in Rails
#
# Adapt the limits to test with more queries
#
@comment_ids = (1..4260000).to_a.sample(2000)

def sqlite
  @comment_ids.each do |comment_id|
    Comment.find(comment_id)
  end
end

def postgres
  @comment_ids.each do |comment_id|
    PgComment.find(comment_id)
  end
end

Benchmark.ips do |x|
  # Configure the number of seconds used during
  # the warmup phase (default 2) and calculation phase (default 5)
  x.config(warmup: 2, time: 5)

  # Typical mode, runs the block as many times as it can
  x.report("sqlite:") { sqlite }
  x.report("postgres:") { postgres }

  # Compare the iterations per second of the various reports!
  x.compare!
end
