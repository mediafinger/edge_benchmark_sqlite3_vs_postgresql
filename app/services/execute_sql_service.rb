class ExecuteSqlService
  class << self
    def call(database:, sql:)
      new.call(database:, sql:)
    end
  end

  def call(database:, sql:)
    log(sql)

    @connection = ActiveRecord::Base.establish_connection(send(database)).connection
    @connection.exec_query(sql)
  ensure
    @connection.close
  end

  private

  def log(sql)
    Rails.logger.info("ExecuteSqlService called with: #{sql}")
  end

  def primary
    {
      adapter: "sqlite3",
      encoding: "unicode",
      database: "storage/development.sqlite3"
    }
  end

  def secondary
    {
      adapter: "postgresql",
      encoding: "unicode",
      database: "edge_development_secondary"
    }
  end
end
