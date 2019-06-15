Rails.application.routes.draw do
  # URL Array Parameter syntax:
  # http://localhost:3000/pdf_metadata?urls[]=bar&urls[]=qux
  # http://localhost:3000/pdf_metadata?urls[]=http://docraptor.com/examples/invoice.html
  # http://localhost:3000/pdf_metadata?urls[]=http://docraptor.com/examples/invoice.html&urls[]=https://news.ycombinator.com
  # http://localhost:3000/pdf_metadata?urls[]=http://docraptor.com/examples/invoice.html&urls[]=https://news.ycombinator.com&urls[]=https://ycombinator.com/fake_url
  # http://localhost:3000/pdf_metadata?urls[]=http://docraptor.com/examples/invoice.html&urls[]=https://www.nytimes.com&urls[]=https://news.ycombinator.com&urls[]=https://www.seattleweekly.com&urls[]=https://techcrunch.com/2019/06/14/microsoft-makes-getting-started-with-java-and-vs-code-easier
    get 'pdf_metadata', to: 'pdfs#show_metadata'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
