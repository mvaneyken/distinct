#!/bin/env ruby
# encoding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

item_types = ItemType.create([
  {name: "Raw Material"},
  {name: "Intermediate"},
  {name: "Finished Aqueous Pigment Piezo"},
  {name: "Finished Aqueous Dye Piezo"}
  ])
  
measures = Measure.create([
  {code: "mPas", name: "Viscosity", description: "milliPascal seconds"},
  {code: "nM/m", name: "Surface Tension", description: "newton meters/square meter"},
  {code: "GU", name: "Gloss", description: "Gloss Units"},
  {code: "mg/L", name: "Dissolved O2", description: "milligrams per liter"},
  {code: "μS/m", name: "Conductivity", description: "microsiemens per meter"},
  {code: "pH", name: "pH", description: "pH"},
  {code: "Kg", name: "Kilogram", description: "SI mass"}
  ])

equipment = Equipment.create([
  {name: "Bubble Tensiometer", manufacturer: "SITA", model: "pro line t15", serial_number: "123"},
  {name: "Conductivity Meter", manufacturer: "D-2 Inc.", model: "JF-1A-HH", serial_number: "456"},
  {name: "Viscometer", manufacturer: "Brookfield", model: "LVDV-II+ Pro", serial_number: "789"},
  {name: "Glossmeter", manufacturer: "GlossMaster", model: "GlossMate", serial_number: "ABC"},
  {name: "O2 Meter", manufacturer: "WTW", model: "Oxi 3205", serial_number: "DEF"},
  {name: "pH Meter", manufacturer: "phMeterCo", model: "paperStrip", serial_number: "001"}
  ])

kg = Measure.find_by_code('Kg')
raw = ItemType.find_by_name("Raw Material")
intermediate = ItemType.find_by_name("Intermediate")
fapp = ItemType.find_by_name("Finished Aqueous Pigment Piezo")
fadp = ItemType.find_by_name("Finished Aqueous Dye Piezo")
item_masters = ItemMaster.create([
  {code: "INT0029", item_type_id: intermediate.id, description: "HD Letdown", measure_id: kg.id},
  {code: "V80PKSP0200", item_type_id: fapp.id, description: "HD Photo Black Bulk", measure_id: kg.id},
  {code: "V80LMSP02010", item_type_id: fapp.id, description: "HD Light Magenta Bulk", measure_id: kg.id},
  {code: "V80GSP02011", item_type_id: fapp.id, description: "HD Green Bulk", measure_id: kg.id},
  {code: "V80OSP02012", item_type_id: fapp.id, description: "HD Orange Bulk", measure_id: kg.id},
  {code: "V80CSP0201", item_type_id: fapp.id, description: "HD Cyan Bulk", measure_id: kg.id},
  {code: "V80VMSP0202", item_type_id: fapp.id, description: "HD Vivid Magenta Bulk", measure_id: kg.id},
  {code: "V80YSP0203", item_type_id: fapp.id, description: "HD Yellow Bulk", measure_id: kg.id},
  {code: "V80LCSP0204", item_type_id: fapp.id, description: "HD Light Cyan Bulk", measure_id: kg.id},
  {code: "V80LVMSP0205", item_type_id: fapp.id, description: "HD Light Vivid Magenta Bulk", measure_id: kg.id},
  {code: "V80LKSP0206", item_type_id: fapp.id, description: "HD Light Black Bulk", measure_id: kg.id},
  {code: "V80MKSP0207", item_type_id: fapp.id, description: "HD Matte Black Bulk", measure_id: kg.id},
  {code: "V80LLKSP0208", item_type_id: fapp.id, description: "HD Light Light Black Bulk", measure_id: kg.id},
  {code: "V80MSP0209", item_type_id: fapp.id, description: "HD Magenta Bulk", measure_id: kg.id},
  {code: "SP0300V", item_type_id: fapp.id, description: "HDF Dye Black", measure_id: kg.id},
  {code: "RMP0016", item_type_id: fadp.id, description: "Cyan Dispersion 450C", measure_id: kg.id},
  {code: "RMR0048", item_type_id: raw.id, description: "Hauthane HD-2120", measure_id: kg.id},
  {code: "RMR0049", item_type_id: raw.id, description: "Ottopol 25-25", measure_id: kg.id},
  {code: "RMW0026", item_type_id: raw.id, description: "DM Water", measure_id: kg.id}   
  ])
  
nmm = Measure.find_by_code("nM/m")
mpas = Measure.find_by_code("mPas")
ph = Measure.find_by_code("pH")
standards = Standard.create([
  {code: "V80PKSP0200", property: "Static Surface Tension", min_tolerance: 27.00, max_tolerance: 30.00, measure_id: nmm.id},
  {code: "V80PKSP0201", property: "Dynamic Surface Tension", min_tolerance: 29.00, max_tolerance: 32.00, measure_id: nmm.id},
  {code: "V80PKSP0202", property: "Viscosity", min_tolerance: 2.90, max_tolerance: 3.60, measure_id: mpas.id},
  {code: "V80PKSP0203", property: "pH", min_tolerance: 8.80, max_tolerance: 9.40, measure_id: ph.id}
  ])

bubble = Equipment.find_by_name("Bubble Tensiometer")
visc = Equipment.find_by_name("Viscometer")
phmeter = Equipment.find_by_name("pH Meter")  
[
  {code: "V80PKSP0200", equipment_id: bubble.id},
  {code: "V80PKSP0201", equipment_id: bubble.id},
  {code: "V80PKSP0202", equipment_id: visc.id},
  {code: "V80PKSP0203", equipment_id: phmeter.id}
  ].each do |junction|
    standard = Standard.find_by_code(junction[:code])
    StandardEquipment.create(standard_id: standard.id, equipment_id: junction[:equipment_id])
  end
