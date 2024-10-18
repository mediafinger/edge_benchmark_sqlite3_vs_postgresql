require_relative "../config/environment"

require "benchmark"

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

Benchmark.bm do |x|
  x.report('postgres:') { postgres }
  x.report('sqlite:') { sqlite }
end
