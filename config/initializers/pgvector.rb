require "pgvector"

ActiveSupport.on_load(:active_record) do
  ActiveRecord::ConnectionAdapters::PostgreSQLAdapter::NATIVE_DATABASE_TYPES[:vector] = { name: "vector" }
end

class Array
  def to_pgvector
    return "[]" if empty?
    "[" + map { |v| v.is_a?(Numeric) ? v.round(6) : 0 }.join(",") + "]"
  end
end

