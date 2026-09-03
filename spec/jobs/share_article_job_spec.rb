require "rails_helper"

RSpec.describe ShareArticleJob, type: :job do
  let(:user) { create(:user) }
  let(:article) { create(:article, user: user) }

  it "delivers the share invitation email" do
    expect {
      described_class.perform_now(
        article_id: article.id,
        from_user_id: user.id,
        to_email: "friend@example.com"
      )
    }.to change { ActionMailer::Base.deliveries.size }.by(1)

    expect(ActionMailer::Base.deliveries.last.to).to eq(["friend@example.com"])
  end
end
