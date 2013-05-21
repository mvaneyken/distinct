ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do
    
    columns do
      column do
        panel "Installed Base" do
          @statistics = [
            {name: 'Technicians', count: Technician.all.size},
            {name: 'Clients', count: Client.all.size},
            {name: 'Installations', count: Installation.all.size},
            {name: 'Consumption Profiles', count: ConsumptionProfile.all.size},
            {name: 'Ink System', count: InkSystem.all.size},
            {name: 'Printer Functions', count: PrinterFunction.all.size},
            {name: 'Printer Models', count: PrinterModel.all.size}
          ]
          table do
            tr
              th "Name"
              th "Count"
            @statistics.each do |statistic|
              tr
                td statistic[:name]
                td statistic[:count]
            end
          end
        end
      end

      column do
        panel "Quality Control" do
          @statistics = [
            {name: 'Representatives', count: Representative.all.size},
            {name: 'Equipment', count: Equipment.all.size},
            {name: 'Item Masters', count: ItemMaster.all.size},
            {name: 'Item Types', count: ItemType.all.size},
            {name: 'Lots', count: Lot.all.size},
            {name: 'Lot Versions', count: LotVersion.all.size},
            {name: 'Measures',count: Measure.all.size},
            {name: 'Sample', count: Sample.all.size},
            {name: 'Test Suites', count: TestSuite.all.size},
            {name: 'Standards', count: Standard.all.size},
            {name: 'Tolerance Actions', count: ToleranceAction.all.size}
          ]
          table do
            tr
              th "Name"
              th "Count"
            @statistics.each do |statistic|
              tr
                td statistic[:name]
                td statistic[:count]
            end
          end
        end
      end
      
    end
  end # content
end
