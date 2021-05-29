require "rails_helper"

describe ApplicationHelper, :type => :helper do
    describe "#format_date" do
      it "returns the correct date format" do
        expect(helper.format_date('Wed, 04 Apr 2018 23:51:08 +0000')).to eq("Wed, 04 Apr 2018 23:51:08")
        expect(helper.format_date('asfda')).to eq("Wrong Date format")
      end
    end
end