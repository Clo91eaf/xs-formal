clear -all

# Analyze source files and property files
analyze -sv12 -f ./filelist.f

set_task_compile_time_limit 100000
set_property_compile_time_limit 100000

# Elaborate design and properties
elaborate

# Set up Clocks and Resets
clock clock
reset reset

# Get design information to check general complexity
get_design_info

# Prove properties
prove -all

report -file report.txt

set failed_properties [get_property_list -include {status {cex unreachable}}]
set length [llength $failed_properties]
if { $length > 0 } {
  puts "There are $length failed properties!"
} else {
  puts "All properties passed!"
}
set failed_num [open failed_num w]
puts $failed_num "$length"
close $failed_num
exit 0
