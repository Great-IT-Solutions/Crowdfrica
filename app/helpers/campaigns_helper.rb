module CampaignsHelper
  def you_wanna_say_some_thing
    case beneficiary.btype
    when 'patient'
      " some words of encouragement to #{beneficiary.beneficiary_name.humanize}..."
    when 'health_facility'
      " say something to #{beneficiary.beneficiary_name} ... "
    end
  end

  def facebook_url(campaign)
    "https://www.facebook.com/sharer/sharer.php?u=#{campaign_url(campaign.slug)}"
  end

  def twitter_url(campaign)
    'https://twitter.com/intent/tweet?' \
      "text=#{url_encode("Give now! #{campaign.project.project_name} on")}&" \
      'via=crowdfrica&' \
      "url=#{campaign_url(campaign.slug)}&" \
      'hashtags=startup,healthcare,healthinsurance,Africa'
  end
end
