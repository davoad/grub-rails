class PublicationSummaryCell < Cell::ViewModel
  def show
    render
  end

  private

  property :name
  property :edition

  def summary
    sprintf("%s%s", name, edition ? [' (',edition,')'].join : '')
  end

end
