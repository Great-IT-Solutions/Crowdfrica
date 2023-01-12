class Exrate < ApplicationRecord
  def self.convert_amount(amount, country_code)
    rate = Exrate.first
    return amount if rate.blank?

    case country_code
    when 'GH' then (amount * rate.rate).round(2)
    when 'NG' then (amount * rate.ngn_rate).round(2)
    when 'KE' then (amount * rate.kes_rate).round(2)
    when 'US' then amount.round(2)
    else
      amount.round(2)
    end
  end

  def self.convert_to_usd(ghs_amount)
    rate = Exrate.first
    return ghs_amount if rate.blank?

    (ghs_amount / rate.rate).round(2)
  end
end
