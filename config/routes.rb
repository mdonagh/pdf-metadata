Rails.application.routes.draw do
  # URL Array Parameter syntax:
  # http://localhost:3000/pdf_metadata?urls[]=bar&urls[]=qux
  # http://localhost:3000/pdf_metadata?urls[]=http://docraptor.com/examples/invoice.html
  # http://localhost:3000/pdf_metadata?urls[]=http://docraptor.com/examples/invoice.html&urls[]=https://news.ycombinator.com
    get 'pdf_metadata', to: 'pdfs#show_metadata'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
