class PgComment < SecondaryRecord
  belongs_to :pg_stuff

  has_many :pg_reactions
end
