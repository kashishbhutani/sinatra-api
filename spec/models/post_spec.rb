require 'spec_helper'

RSpec.describe Post, :type => :model do

    subject { described_class.new(title: "Testing Post", description: "Testing Description") }

    describe "Validations" do

        it "is valid with valid attributes" do
            expect(subject).to be_valid
        end

        it "is not valid without a title" do
            subject.title = nil
            expect(subject).to_not be_valid
        end

        it "is not valid with a title of length < 5" do
            subject.title = "Test"
            expect(subject).to_not be_valid
        end

        it "is not valid with a title of length > 255" do
            subject.title = "Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test"
            expect(subject).to_not be_valid
        end

        it "is not valid without a description" do
            subject.description = nil
            expect(subject).to_not be_valid
        end

        it "is not valid without a title and description" do
            subject.title = nil
            subject.description = nil
            expect(subject).to_not be_valid
        end

    end

end