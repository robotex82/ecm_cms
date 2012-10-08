require 'spec_helper'
module Ecm
  module Cms
    describe PageController do
      describe "GET respond" do
        it "succeeds" do
          get :respond        
        end
      end
    end
  end
end

