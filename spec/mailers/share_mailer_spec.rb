require "rails_helper"

RSpec.describe ShareMailer, type: :mailer do
  describe "#invitation_to_read" do
    let(:user) { create(:user, email: "alice@example.com") }
    let(:article) { create(:article, user: user, title: "How to Ship", url: "https://example.com/ship") }

    it "sends to the given address with subject and both parts" do
      mail = described_class.invitation_to_read(
        article_id: article.id,
        from_user_id: user.id,
        to_email: "bob@example.com",
        message: "You'll like this."
      )

      expect(mail.to).to eq(["bob@example.com"])
      expect(mail.from).to eq(["readlater@example.com"])
      expect(mail.subject).to include("alice@example.com", "How to Ship")
      expect(mail.body.encoded).to include("https://example.com/ship", "You'll like this.")
    end
  end
end
