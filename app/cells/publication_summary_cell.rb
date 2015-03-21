class PublicationSummaryCell < Cell::ViewModel
  def show
    render
  end

  private

  property :name
  property :edition
  property :author

  def summary
    sprintf("%s%s %s", name, edition ? [' (',edition,')'].join : '', author)
  end

end
