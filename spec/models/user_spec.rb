require 'spec_helper'

RSpec.describe User, :type => :model do

    subject { described_class.new(name: "Test User", mobile: "1234567890", email: "kashish@metadesignsolutions.co.uk") }

    describe "Validations" do

        it "is valid with valid attributes" do
            expect(subject).to be_valid
        end

        it "is not valid without a title" do
            subject.name = nil
            expect(subject).to_not be_valid
        end

        it "is not valid with a name of length < 3" do
            subject.name = "Te"
            expect(subject).to_not be_valid
        end

        it "is not valid with a name of length > 255" do
            subject.name = "Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test"
            expect(subject).to_not be_valid
        end

        it "is not valid without a mobile" do
            subject.mobile = nil
            expect(subject).to_not be_valid
        end

        it "is not valid with a mobile of length > 10" do
            subject.mobile = "1234567432443"
            expect(subject).to_not be_valid
        end

        it "is not valid without a email" do
            subject.email = nil
            expect(subject).to_not be_valid
        end

        it "is not valid without a name, mobile, email" do
            subject.name = nil
            subject.mobile = nil
            subject.email = nil
            expect(subject).to_not be_valid
        end

    end

end