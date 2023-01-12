RSpec.describe Campaign do
  describe 'Associations' do
    it { is_expected.to belong_to(:project) }
  end

  describe '#has_any_comments?' do
    let(:comment) { build_stubbed(:comment) }
    let(:project) { build_stubbed(:project, comments: [comment]) }
    let(:campaign) { build_stubbed(:campaign, project: project) }

    it 'returns boolean whether the attached project has comments' do
      expect(campaign.has_any_comments?).to be_truthy
    end
  end

  describe '#beneficiary' do
    let(:beneficiary) { build_stubbed(:beneficiary) }
    let(:project) { build_stubbed(:project, beneficiary: beneficiary) }
    let(:campaign) { build_stubbed(:campaign, project: project) }

    it 'returns the beneficiary of the attached project' do
      expect(campaign.beneficiary).to eq(beneficiary)
    end
  end

  describe '#name_of_beneficiary' do
    let(:beneficiary) { build_stubbed(:beneficiary) }
    let(:project) { build_stubbed(:project, beneficiary: beneficiary) }
    let(:campaign) { build_stubbed(:campaign, project: project) }

    it 'returns name of the beneficiary' do
      expect(campaign.name_of_beneficiary).to eq(beneficiary.beneficiary_name)
    end
  end

  describe '#first_name_of_patient' do
    let(:beneficiary) { build_stubbed(:beneficiary, beneficiary_name: 'Sarai Whitehead') }
    let(:project) { build_stubbed(:project, beneficiary: beneficiary) }
    let(:campaign) { build_stubbed(:campaign, project: project) }

    it 'returns the first name of the beneficiary' do
      expect(campaign.first_name_of_patient).to eq('Sarai')
    end
  end

  describe '#is_for_patient?' do
    let(:beneficiary) { build_stubbed(:beneficiary, btype: 'patient') }
    let(:project) { build_stubbed(:project, beneficiary: beneficiary) }
    let(:campaign) { build_stubbed(:campaign, project: project) }

    it 'returns boolean whether this campaign is for a patient' do
      expect(campaign.is_for_patient?).to be_truthy
    end
  end

  describe '#is_health_insurance?' do
    let(:category) { build_stubbed(:category, category_name: 'Health Insurance') }
    let(:project) { build_stubbed(:project, category: category) }
    let(:campaign) { build_stubbed(:campaign, project: project) }

    it 'returns boolean whether this campaign\'s category is Health Insurance' do
      expect(campaign.is_health_insurance?).to be_truthy
    end
  end

  describe '#equipment_name & #ailment_name' do
    let(:project) { build_stubbed(:project, ailment_or_equipment: 'Heart Problem') }
    let(:campaign) { build_stubbed(:campaign, project: project) }

    it 'returns the equipment name of the campaign\'s project' do
      expect(campaign.equipment_name).to eq('Heart Problem')
    end

    it 'returns the ailment of the campaign\'s project' do
      expect(campaign.ailment_name).to eq('Heart Problem')
    end
  end

  describe 'Donation related instance Methods' do
    let(:project) { create(:project, cost: 40) }
    let(:donation_1) { create(:donation, project: project, amount: 10) }
    let(:donation_2) { create(:donation, project: project, amount: 10) }
    let(:campaign) { create(:campaign, project: project) }

    describe '#total_amount_donated' do
      it 'returns total amount donated for a campaign' do
        donation_1.reload
        donation_2.reload
        expect(campaign.total_amount_donated).to eq(BigDecimal(20))
      end
    end

    describe '#cost' do
      it 'returns the cost of the campaign\'s project' do
        expect(campaign.cost).to eq(40)
      end
    end

    describe '#still_needed' do
      it 'returns amount still needed for the campaign' do
        donation_1.reload
        donation_2.reload
        expect(campaign.still_needed).to eq(20)
      end
    end

    describe '#progress' do
      it 'returns the campaign donation progress if cost>0' do
        donation_1.reload
        donation_2.reload
        expect(campaign.progress).to eq(50)
      end

      it 'returns 0 if cost<0' do
        project.cost = -20
        donation_1.reload
        donation_2.reload
        expect(campaign.progress).to eq(0)
      end
    end

    describe '#donors_distinct_count' do
      it 'returns the count of distinct donors who donated for the campaign' do
        donation_1.reload
        donation_2.reload
        expect(campaign.donors_distinct_count).to eq(2)
      end
    end

    describe '#fully_funded?' do
      it 'returns boolean whether the campaign is fully funded or not' do
        project.cost = 20
        donation_1.reload
        donation_2.reload
        expect(campaign.fully_funded?).to be_truthy
      end
    end
  end

  describe '#number_of_days_left' do
    let(:project) { create(:project, expires_at: Date.today.next_day(5)) }
    let(:campaign) { create(:campaign, project: project) }

    it 'returns difference between current date and project expiry date' do
      expect(campaign.number_of_days_left).to eq(5)
    end
  end

  describe '.for_beneficiary_type' do
    subject(:results) { Campaign.for_beneficiary_type(:entrepreneur) }

    before do
      create_list(:campaign, 2, :entrepreneur)
      create_list(:campaign, 1, :patient)
    end

    it 'returns 2 campaigns' do
      expect(results.count).to eq(2)
    end

    it 'returns specific type campaigns' do
      expect(results.map(&:beneficiary).map(&:btype).uniq).to eq(['entrepreneur'])
    end
  end

  describe '.published' do
    let!(:published_campaign) { create(:campaign, published: true) }
    let!(:not_published_campaign) { create(:campaign, published: false) }

    it 'returns  published campaigns' do
      expect(Campaign.published).to contain_exactly(published_campaign)
    end
  end
end
