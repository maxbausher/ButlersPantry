Rails.application.routes.draw do

  #
  get "/eventful" => 'ajax#eventful'  # do you not want /enventful/:keyword??? or are we sening as data? Im a confused old man
  #
  get "/amazon" => 'ajax#amazon'

  get "/etsy" => "ajax#etsy"

  get "/jquery" => "ajax#jquery"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
