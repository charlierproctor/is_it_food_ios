
require 'highline/import'
require 'colorize'


def do_you_need_this(full_name_of_directory, proj_name)
  if full_name_of_directory == proj_name
    puts "Your project name and resources name are the same."
    exit()
  end
end

def sync(new_name, proj_name)
    search_and_replace = "sed 's/#{new_name}/#{proj_name}/g' #{proj_name}.xcodeproj/project.pbxproj > #{proj_name}.xcodeproj/project2.pbxproj
"
    system(search_and_replace)

    save_file_to_old = "mv #{proj_name}.xcodeproj/project.pbxproj #{proj_name}.xcodeproj/project.pbxproj.old"
    system(save_file_to_old)

    make_new_project_pbxproj = "mv #{proj_name}.xcodeproj/project2.pbxproj #{proj_name}.xcodeproj/project.pbxproj"
    system(make_new_project_pbxproj)

    rename_source_directory = "mv #{new_name} #{proj_name}"
    rename_test_directory = "mv #{new_name}Tests #{proj_name}Tests"
    rename_test_file = "mv #{proj_name}Tests/#{new_name}Tests.m #{proj_name}Tests/#{proj_name}Tests.m "

    system(rename_source_directory)
    system(rename_test_directory)
    system(rename_test_file)

    rename_main_directory = "mv ../#{new_name} ../#{proj_name}"
    system(rename_main_directory)

    puts "Done. Project name synchronised."
    puts "You might want to change the project's scheme too. Go to Manage Scheme."
end

#sound off if something is wrong
def soundoff(xcodeproj_file_arr,tests_dir_array)
  if tests_dir_array.count > 1
    puts "ERROR: there's more than one tests directory"
    exit()
  elsif tests_dir_array.count == 0
    puts "ERROR: cannot find test directory"
    exit()
  end

  if xcodeproj_file_arr.count > 1
    puts "ERROR: there's more than one .xcodeproj file."
    exit()
  elsif xcodeproj_file_arr.count == 0
    puts "ERROR: cannot find xcodeproj file"
    exit()
  end
end

def start()
  xcodeproj_file_arr = Dir.glob('*.xcodeproj')
  tests_dir_array = Dir.glob('*Tests')

  name_of_directory= ""
  proj_name = ""
  new_name = ""

  soundoff(xcodeproj_file_arr,tests_dir_array)

  #DETECT
  full_name_of_directory = tests_dir_array[0]
  name_of_directory = full_name_of_directory[0,full_name_of_directory.length-5]
  proj_name = xcodeproj_file_arr[0].split(".")[0]

  #CHECK
  do_you_need_this(name_of_directory, proj_name)



  puts "WARNING: Close your Xcode before proceeding.".red
  #ASK
  puts ""
  new_name = ask "Press enter to replace: " + "#{name_of_directory}".red + " with " +"#{proj_name}".blue + " (Type q to quit)"

  if new_name.strip == "q"
    puts "Exit."
    exit()
  elsif new_name.strip == ""
    sync(name_of_directory, proj_name)
  else
    data = ask "Change " + "#{proj_name}".blue + " to " + "#{new_name}".blue + " ? (Enter to confirm, q to cancel)"
    if data == ""
      sync(new_name, proj_name)
    else
      puts "Cancel."
      exit()
    end

  end
end


start()
