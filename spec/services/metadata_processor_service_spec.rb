require 'rails_helper'

RSpec.describe MetadataProcessorService do
  it 'Can save metadata from a PDF' do
    reader = PDF::Reader.new(Rails.root.join('spec', 'fixtures', 'files', 'example.pdf'))
    metadata_processor_service = MetadataProcessorService.new
    metadata_processor_service.send(:save_metadata,
                                        'http://docraptor.com/examples/invoice.html',
                                        reader)
    expect(metadata_processor_service.instance_variable_get(:@pdf_metadata)[0]['url']).to eq('http://docraptor.com/examples/invoice.html')
  end


it 'sorts metadata by page length, then alphabetically by URL' do
  pdf_metadata = [{'url'=>'https://nytimes.com', 'pdf_version'=>1.5, 'info'=>{:Producer=>'Prince 12.4 (www.princexml.com)', :Keywords=>'Hong Kong, Civil Unrest' }, 'metadata'=>nil, 'page_count'=>3},
                  {'url'=>'https://news.ycombinator.com', 'pdf_version'=>1.5, 'info'=>{:Producer=>'Prince 12.4 (www.princexml.com)', :Title=>'Hacker News'}, 'metadata'=>nil, 'page_count'=>2},
                  {'url'=>'http://docraptor.com/examples/invoice.html', 'pdf_version'=>1.5, 'info'=>{:Producer=>'Prince 12.4 (www.princexml.com)', :Title=>'Your New Project for Our Best Client'}, 'metadata'=>nil, 'page_count'=>1},
                  {'url'=>'https://techcrunch.com/2019/06/14/microsoft-makes-getting-started-with-java-and-vs-code-easier', 'pdf_version'=>1.5, 'info'=>{:Producer=>'Prince 12.4 (www.princexml.com)', :Creator=>'WordPress 5.2.1', :Title=>'Microsoft makes getting started with Java and VS Code easier – TechCrunch'}, 'metadata'=>nil, 'page_count'=>3}]
  metadata_processor_service = MetadataProcessorService.new
  metadata_processor_service.instance_variable_set(:@pdf_metadata, pdf_metadata)
  metadata_processor_service.send(:sort_metadata)
  sorted_metadata = metadata_processor_service.instance_variable_get(:@pdf_metadata)
  expect(sorted_metadata.last['url']).to eq('https://techcrunch.com/2019/06/14/microsoft-makes-getting-started-with-java-and-vs-code-easier')
  expect(sorted_metadata.first['url']).to eq('http://docraptor.com/examples/invoice.html')
end





end