# Preview all emails at http://localhost:3000/rails/mailers/championship_mailer
class ChampionshipMailerPreview < ActionMailer::Preview
  def request_received
    request = ChampionshipRequest.first
    ChampionshipMailer.request_received(request)
  end

  def request_accepted
    championship = Championship.first
    ChampionshipMailer.request_accepted(championship)
  end
end
