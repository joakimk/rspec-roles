ROOT = File.expand_path(File.join(File.dirname(__FILE__), "../.."))

Before do
  system("rm -rf #{ROOT}/tmp 2> /dev/null; mkdir #{ROOT}/tmp")
end

Given /^a file named "(.*?)" with:$/ do |file_name, content|
  File.open("#{ROOT}/tmp/#{file_name}", "w") { |f| f.puts(content) }
end

When /^I run "(.*?)"$/ do |command|
  puts `cd #{ROOT}/tmp && #{command}`
end

Then /^the examples should pass$/ do
  pending
end
