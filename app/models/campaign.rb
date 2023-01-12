class Campaign < ApplicationRecord
  extend FriendlyId
  include CampaignsHelper

  # use friendly_id
  friendly_id :campaign_name, use: :slugged

  belongs_to :project
  has_one :championship, dependent: :destroy
  has_many :championship_requests, dependent: :destroy

  delegate :comments, to: :project
  delegate :beneficiary, to: :project

  scope :published, -> { where(published: true) }
  scope :for_beneficiary_type, lambda { |beneficiary_type|
    joins(project: [:beneficiary]).where(beneficiaries: { btype: Beneficiary.btypes[beneficiary_type] })
  }
  # update slug
  def should_generate_new_friendly_id?
    campaign_name_changed?
  end

  # helpers
  def has_any_comments?
    comments.any?
  end

  def name_of_beneficiary
    try(:beneficiary).try(:beneficiary_name)
  end

  def first_name_of_patient
    name_of_beneficiary.split(' ')[0] if name_of_beneficiary.present?
  end

  def is_for_patient?
    return true if try(:project).try(:beneficiary).try(:btype) == 'patient'
  end

  def new_donor(params, color_gen)
    donor = Donor.new(
      fullname: params[:rave][:firstname],
      email: params[:rave][:email],
      gender: rand(0..1),
      country: 'Ghana',
      password: params[:rave][:password],
      slug: (params[:rave][:firstname]).downcase.concat(rand.to_s[1..7]).force_encoding('utf-8').parameterize,
      color: color_gen
    )
    # we save the new unregistered donor into our db
    donor.save(validate: false)
    donor
  end

  def is_health_insurance?
    return true if project.category.category_name == 'Health Insurance'
  end

  def equipment_name
    project.ailment_or_equipment
  end

  def ailment_name
    project.ailment_or_equipment
  end

  def total_amount_donated
    @total_amount_donated = project.donations.where(order_status: [nil, '', 'Successful']).sum('amount')
  end

  def cost
    @cost = project.cost
  end

  def still_needed
    cost - total_amount_donated
  end

  def number_of_days_left
    (project.expires_at - Date.today).to_i
  end

  def progress
    if cost > 0.0
      @progress = ((total_amount_donated.to_f / cost.to_f) * 100).round
      [100, @progress].min.to_i
    else
      0.0
    end
  end

  def donors_distinct_count
    @donors = project.donations.where(order_status: [nil, '', 'Successful']).pluck(:donor_id).uniq
    project.donors.where(id: @donors).distinct.count
  end

  def fully_funded?
    return true if still_needed.negative? || still_needed.zero?
  end
end
