require "rails_helper"

RSpec.describe WeeklyDigestMailer, type: :mailer do
  describe "#send_digest" do
    let(:user) { create(:user, email: "alice@example.com") }

    it "includes articles saved in the last week and skips older ones" do
      recent = create(:article, user: user, title: "This week", created_at: 2.days.ago)
      create(:article, user: user, title: "Old news", created_at: 2.weeks.ago)

      mail = described_class.send_digest(user_id: user.id)

      expect(mail.to).to eq(["alice@example.com"])
      expect(mail.subject).to include("1")
      expect(mail.body.encoded).to include("This week", recent.url)
      expect(mail.body.encoded).not_to include("Old news")
    end

    it "sends an 'empty week' message when there are no recent articles" do
      mail = described_class.send_digest(user_id: user.id)
      expect(mail.body.encoded).to include("didn't save anything this week")
    end
  end
end
