# Docraptor Coding Challenge

This Ruby on Rails application takes URLs as URL parameters, convert them to PDF using Docraptor, write them to `/public`, then return metadata as JSON about the PDFs using doc-reader.

App is deployed on Heroku at https://docraptor-challenge.herokuapp.com . Here's a sample URL you can use to test the JSON response `https://docraptor-challenge.herokuapp.com/pdf_metadata?urls[]=http://docraptor.com/examples/invoice.html&urls[]=https://www.nytimes.com&urls[]=https://news.ycombinator.com&urls[]=https://www.seattleweekly.com&urls[]=https://techcrunch.com/2019/06/14/microsoft-makes-getting-started-with-java-and-vs-code-easier`. Be patient though, this is a free tier Heroku dyno and those can take a few seconds to spin up. 

The main app logic lives in `app/services/metadata_processor_service.rb`.

API flow:
1) The URL parameters are parsed from the GET request url
2) URLs are validated with a HEAD request - if one of the links does not return a response, then the server returns a `422` status code.
3) URLs POSTed to Docraptor API using the Docraptor Ruby client library
4) Docraptor responses are written as PDFs to the `/public` folder, 
5) PDF metadata is read by the `doc-reader` gem
6) PDF metadata is sorted by page length and alphabetically by URL
7) PDF metadata is returned as JSON

It might be possible to speed up the API response by providing the Docraptor responses directly to `doc-reader` and not reading or writing them to disk, but this might 
