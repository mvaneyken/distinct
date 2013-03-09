require 'spec_helper'

describe 'enter lab results' do
  before(:each) do
    create_test_data
    sign_in_as_technician
  end
  describe "start a new lot" do
    before(:each) do
      @item_master = ItemMaster.last
      visit new_lab_lot_path
    end
    it "should show the item masters" do
      page.has_select? "Item master"
      page.should have_content @item_master.code_description
    end
    describe "should record the lot header" do
      before(:each) do
        @original_lot_count = Lot.count
        fill_in "Lot number", with: "#{Lot.count}-001"
        select @item_master.code_description, from: "Item master"
        fill_in "Comments", with: "This is a comment"
        click_button "Add"
      end
      it "should add a record to the database" do
        Lot.count.should eq(@original_lot_count + 1)
      end
      it "should tell us which lot was added" do
        @lot = Lot.last
        page.should have_content "Lot ##{@lot.id} added"
      end
      it "should start a lot version" do
        @lot = Lot.last
        page.should have_content "Lot ##{@lot.id}, version #"
        page.should have_content "Test Suite #{@lot.item_master.test_suite.name}"
      end
      it "should list the test suite's standards" do
        test_count = @item_master.test_suite.test_standards.count
        page.should have_selector("table tbody tr", count: test_count)
      end
      describe "should record the samples" do
        before(:each) do
          @original_sample_count = Sample.count
          @lot = Lot.last
          @lot_version_comments = "a lot version comment"
          @sample_value = "100"
          @sample_comments = "Interesting"
          fill_in "lot_version_comments", with: @lot_version_comments
          fill_in "_lot_version_samples_attributes_0_value", with: @sample_value
          fill_in "_lot_version_samples_attributes_0_comments", with: @sample_comments
          click_button "Update"
        end
        it "should save the lot version's comments" do
          @lot_version = @lot.lot_versions.last
          @lot_version.comments.should eq(@lot_version_comments)
        end
        it "should save the samples in the database" do
          test_standards_count = @lot.item_master.test_suite.test_standards.count
          Sample.count.should eq(@original_sample_count + test_standards_count)
        end
        it "should save the entered results" do
          @lot_version = @lot.lot_versions.last
          @lot_version.samples.first.value.should eq(@sample_value.to_f)
          @lot_version.samples.first.comments.should eq(@sample_comments)
        end
        it "should show the results" do
          @lot_version = @lot.lot_versions.last
          page.should have_content "Lot version ##{@lot_version.version.to_s}"
          page.should have_content @lot_version.comments
        end
        describe "should allow the samples to be updated" do
          before(:each) do
            @lot_version = @lot.lot_versions.last
            @lot = @lot_version.lot
            @sample_count = @lot_version.samples.count
            visit edit_lab_lot_lot_version_path(@lot, @lot_version)
          end
          it "should show the samples" do
            page.should have_selector('table tbody tr', count: @sample_count)
          end
        end
      end
    end
  end
end