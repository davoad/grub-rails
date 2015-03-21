class RecipeSummaryCell < Cell::ViewModel
  def show
    render
  end

  private

  property :publication
  property :page_number

  def summary
    sprintf("%s%s, Page %s", publication.name, publication.edition ? [' (', publication.edition,')'].join : '', page_number)
  end

  def author
    publication.author
  end

end
