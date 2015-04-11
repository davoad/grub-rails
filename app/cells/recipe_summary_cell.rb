class RecipeSummaryCell < Cell::ViewModel
  def show
    render
  end

  private

  property :publication
  property :page_number
  property :preparation_time
  property :cooking_time

  def publication_link
    edition =  publication.edition ? [' (', publication.edition, ')'].join : ''
    link_text = format('%s%s', publication.name, edition)
    link_to link_text, edit_publication_path(publication)
  end

  def author
    publication.author
  end

  def total_cooking_time
    preparation_time.to_i + cooking_time.to_i
  end
end
