module ApplicationHelper
  def paginate(collection, params= {})
    will_paginate collection, params.merge(:renderer => RemoteLinkPaginationHelper::LinkRenderer)
  end

  def meta_tag(tag, text)
    content_for :"meta_#{tag}", text
  end

  def yield_meta_tag(tag, default_text = '')
    content_for?(:"meta_#{tag}") ? content_for(:"meta_#{tag}") : default_text
  end

  def color_gen
    ('#' + SecureRandom.hex(3)).to_s
  end

  def rate
    if @rate = Exrate.first
      @rate.rate
    else
      0
    end
  end

  def ngn_rate
    if @rate = Exrate.first
      @rate.ngn_rate
    else
      0
    end
  end

  def kes_rate
    if @rate = Exrate.first
      @rate.kes_rate
    else
      0
    end
  end

  def page_title(page_title = '')
    base = 'Crowdfrica'
    page_title.empty? ? base : base + ' | ' + page_title.titleize
  end
end
