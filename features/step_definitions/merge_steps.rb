Given /^the following users exist$/ do |table|
  # table is a Cucumber::Ast::Table
  #pending # express the regexp above with the code you wish you had
  User.create table.hashes
end

Given /^the following articles exist$/ do |table|
  # table is a Cucumber::Ast::Table
  #pending # express the regexp above with the code you wish you had
  Article.create table.hashes
end

Given /^the following comments exist$/ do |table|
  # table is a Cucumber::Ast::Table
  #pending # express the regexp above with the code you wish you had
  Comment.create table.hashes
end

Given /^I am logged in as "(.*?)" with pass "(.*?)"$/ do |user, password|
  #pending # express the regexp above with the code you wish you had
  visit '/accounts/login'
  fill_in 'user_login', :with => user
  fill_in 'user_password', :with => password
  click_button 'Login'
  assert page.has_content? 'Login successful'
end

#Given /^I am on the Edit Page of Article with id (\d+)$/ do |arg1|
  #pending # express the regexp above with the code you wish you had
#end

Given /^the articles with ids "(\d+)" and "(\d+)" were merged$/ do |id1, id2|
  #pending # express the regexp above with the code you wish you had
  article = Article.find_by_id(id1)
  article.merge_with(id2)
end

Then /^"(.*?)" should be author of (\d+) articles$/ do |user, count|
  #pending # express the regexp above with the code you wish you had
  assert Article.find_all_by_author(User.find_by_name(user).login).size == Integer(count)
end

