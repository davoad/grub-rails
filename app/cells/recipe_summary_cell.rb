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
        link_to sprintf("%s%s", publication.name, publication.edition ? [' (', publication.edition,')'].join : ''), edit_publication_path(publication)
  end

  def author
    publication.author
  end

  def total_cooking_time
    preparation_time.to_i + cooking_time.to_i
  end
end
