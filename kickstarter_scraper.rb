# require libraries/modules here
require 'nokogiri'
require 'pry'

  # SELECTING ALL projects using css selector: kickstarter.css("li.project.grid_4")
  # SELECTING a project title:  project.css("h2.bbcard_name strong a").text
  # SELECTING  a project Image Link: project.css("div.project-thumbnail a img").attribute("src").value
  # SELECTING a project Description: project.css("p.bbcard_blurb").text.strip
  # SELECTING a project Location:   project.css(".location-name").text
  # SELECTING percentage funded: project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i

def create_project_hash

  html = File.read("fixtures/kickstarter.html")

  kickstarter = Nokogiri::HTML(html)

  # create a  big hash "projects"  to store all individual projects
  # iterate through kickstater and grab each project details to create a hash 
  # (containing project title, image_link, description, location, percent_funded) 
  # store all individual hashes in projects
  projects = {}
  kickstarter.css("li.project.grid_4").each do |project|
    title = project.css("h2.bbcard_name strong a").text
    projects[title.to_sym] = {
      :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
      :description => project.css("p.bbcard_blurb").text.strip,
      :location => project.css(".location-name").text,
      :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
    }
  end
  projects
  # binding.pry

end
create_project_hash
