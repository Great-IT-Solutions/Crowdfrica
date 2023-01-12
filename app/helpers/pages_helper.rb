module PagesHelper
  def campaign_samples(type)
    Campaign
      .published
      .for_beneficiary_type(type)
      .order('RANDOM()')
      .limit(3)
      .to_a
  end

  def menu_active?(options)
    path_starts_with = options.is_a?(Hash) && options.delete(:path_starts_with)
    if path_starts_with
      menu_class(request.path.start_with?(path_starts_with))
    else
      menu_class(current_page?(options))
    end
  end

  private

  def menu_class(highlighted)
    highlighted ? 'active' : ''
  end
end
