require 'spec_helper'

module Ecm
  module Cms
    describe PageResolver do
      subject { Ecm::Cms::PageResolver.instance }

      describe "#find_templates" do
        before do
          @args = [
            "respond",
            "ecm/cms/page",
            false,
            { :handlers => [:builder, :erb], :locale => [:de], :formats => [:html] }
          ]
        end
        
        it { subject.should respond_to :find_templates }
        it "should return an Array" do
          subject.find_templates(*@args).should be_a(Array)
        end
      end
    end
  end
end
