class RefactorFeedKeywordFilterAssoc < ActiveRecord::Migration

  def self.up
    Feed.all.each do |feed|
      keywords = Keyword.find_all_by_feed_id(feed.id)
      feed.keywords << keywords.uniq
      filters = Filter.find_all_by_feed_id(feed.id)
      feed.filters << filters.uniq
    end
    remove_column :keywords, :feed_id
    remove_column :filters, :feed_id
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end

end
