class Page < SitePrism::Page
  def self.visit(hash = nil)
    self.new.tap do |page|
      hash.present? ? page.load(hash) : page.load
    end
  end

  def reload
    visit current_url
  end
end
