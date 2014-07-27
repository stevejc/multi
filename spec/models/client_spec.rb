require 'spec_helper'

describe Client do
  it "is valid with a name and account" do
    user = User.create(email: "me@example.com", password: "pw", password_confirmation: "pw")
    account = Account.create(name: "PPITwo", owner_id: user.id)
    client = account.clients.new(name: "TestClient")
    expect(client).to be_valid
  end
  
  it "is invalid without a name" do
    expect(Client.new(name: nil)).to have(1).errors_on(:name)
  end
  it "is invalid without an account" do
    expect(Client.new(name: "TestClient", account: nil)).to have(1).errors_on(:account)
  end
end