class InsertSqlService
  class << self
    def call(database:, table:, columns:, values:)
      new.call(database:, table:, columns:, values:)
    end
  end

  # values has to be an array of arrays
  def call(database:, table:, columns:, values:)
    # values_for_insert = values.map { |v| "(#{v.join(', ')})" }.join(", ")
    values_for_insert = values.map { |v| "`#{v}`" }.join(", ").gsub("[", "(").gsub("]", ")").gsub("`", "").gsub('"', "'")

    ExecuteSqlService.call(database:, sql: "INSERT INTO #{table} (#{columns.join(', ')}) VALUES #{values_for_insert};")
  end
end
