class ChampionshipMailer < ApplicationMailer
  default from: 'hello@crowdfrica.org'

  def request_received(championship_request)
    @championship_request = championship_request
    mail to: @championship_request.champion.email, subject: 'Crowdfrica | We have received your request to become a Champion'
  end

  def request_accepted(championship)
    @championship = championship
    mail to: @championship.champion.email, subject: 'Crowdfrica | We have approved your request to become a Champion'
  end
end
