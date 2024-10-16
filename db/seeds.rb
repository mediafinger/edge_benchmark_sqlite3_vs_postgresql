exit unless Rails.env.development?

# clear DB before populating it
#
puts "Removing all records from the primary database"
%w[lite_stuffs comments reactions].each do |table|
  ActiveRecord::Base.connection.execute("DELETE FROM #{table};")
end
#
puts "Removing all records from the secondary database"
%w[pg_stuffs pg_comments pg_reactions].each do |table|
  SecondaryRecord.connection.execute("TRUNCATE TABLE #{table} RESTART IDENTITY CASCADE;")
end

@reactions = %w[👍 👎 🧡 💔 🔥]

# Create entries for the primary / SQLite database
#
# Adapt the max values to test with more or less records
# the batch size is used to insert records in batches, and for the progress bar
# if you chose the batch too large the process will take a lot of memory and might take longer
#
max_stuff = 12_000
max_comments = 12_000
max_reactions = 5 # _000
batch_size = 5
now = Time.current.iso8601.to_s

puts "Creating entries for the primary database"

@lite_stuff_values = []
@lite_comment_values = []
@lite_reaction_values = []

(1..max_stuff).each do |i|
  # LiteStuff.create!(id: i, name: "Lite Stuff #{i}", body: "#{i} stuff in the lite database", active: true)
  @lite_stuff_values << [i, "Lite Stuff #{i}", "#{i} stuff in the lite database", true, now, now]

  (1..max_comments).each do |j|
    comment_id = max_stuff * (i-1) + j
    # com = Comment.create!(id: comment_id, name: "Comment #{comment_id}", body: "Body #{comment_id}", active: true, lite_stuff_id: i)
    @lite_comment_values << [comment_id, "Comment #{comment_id}", "Body #{comment_id}", true, i, now, now]

    (1..max_reactions).each do |k|
      reaction_id = max_stuff * comment_id + k
      # Reaction.create!(id: reaction_id, body: @reactions.sample, comment_id: comment_id)
      @lite_reaction_values << [reaction_id, @reactions.sample, comment_id, now, now]

      if i % batch_size == 0 && j == max_comments && k == max_reactions
        print("#{i} ")

        InsertSqlService.call(database: :primary, table: "lite_stuffs", columns: %w[id name body active created_at updated_at], values: @lite_stuff_values)
        InsertSqlService.call(database: :primary, table: "comments", columns: %w[id name body active lite_stuff_id created_at updated_at], values: @lite_comment_values)
        InsertSqlService.call(database: :primary, table: "reactions", columns: %w[id body comment_id created_at updated_at], values: @lite_reaction_values)

        @lite_stuff_values = []
        @lite_comment_values = []
        @lite_reaction_values = []
      end
    end
  end
end

puts "SQLite done"
puts "Creating entries for the secondary database"

@pg_stuff_values = []
@pg_comment_values = []
@pg_reaction_values = []

# Create entries for the secondary / Postgres database
#
(1..max_stuff).each do |i|
  # PgStuff.create!(id: i, name: "Postgres Stuff #{i}", body: "#{i} stuff in the powerful database", active: true)
  @pg_stuff_values << [i, "Postgres Stuff #{i}", "#{i} stuff in the powerful database", true, now, now]

  (1..max_comments).each do |j|
    comment_id = max_stuff * (i-1) + j
    # com = PgComment.create!(id: comment_id, name: "PgComment #{comment_id}", body: "Body #{comment_id}", active: true, pg_stuff_id: i)
    @pg_comment_values << [comment_id, "Comment #{comment_id}", "Body #{comment_id}", true, i, now, now]

    (1..max_reactions).each do |k|
      reaction_id = max_stuff * comment_id + k
      # PgReaction.create!(id: reaction_id, body: @reactions.sample, pg_comment_id: comment_id)
      @pg_reaction_values << [reaction_id, @reactions.sample, comment_id, now, now]

      if i % batch_size == 0 && j == max_comments && k == max_reactions
        print("#{i} ")

        InsertSqlService.call(database: :secondary, table: "pg_stuffs", columns: %w[id name body active created_at updated_at], values: @pg_stuff_values)
        InsertSqlService.call(database: :secondary, table: "pg_comments", columns: %w[id name body active pg_stuff_id created_at updated_at], values: @pg_comment_values)
        InsertSqlService.call(database: :secondary, table: "pg_reactions", columns: %w[id body pg_comment_id created_at updated_at], values: @pg_reaction_values)

        @pg_stuff_values = []
        @pg_comment_values = []
        @pg_reaction_values = []
      end
    end
  end
end

puts "Postgres done"
