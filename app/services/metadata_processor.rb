class MetadataProcessor
  attr_reader :pdf_metadata
  def initialize(doc_urls)
    @doc_urls = doc_urls
    @pdf_metadata = []
    @folder_name = Time
                     .now
                     .to_i
                     .to_s
    Dir.mkdir(Rails.root.join('public', @folder_name))
    create_pdfs
    collect_metadata
    sort_response
  end

  def sort_response
    @pdf_metadata.sort_by! { |metadata| [metadata['page_count'], metadata['url']] }
  end

  def create_pdfs
    @doc_urls.each do |doc_url|
    docraptor_response = $docraptor.create_doc(
      test:             true,
      document_url:     doc_url,
      name:             "docraptor-ruby.pdf",
      document_type:    "pdf",
      javascript:       true
    )
    save_pdf(doc_url, docraptor_response)
    end
  end

  def save_pdf(doc_url, docraptor_response)
    filename = "#{@doc_urls.index(doc_url)}.pdf"
    File.open(Rails.root.join('public', @folder_name, filename), 'wb') do |file|
      file.write(docraptor_response)
    end
  end

  def collect_metadata
    @doc_urls.each do |url|
      read_pdf(url)
    end
  end

  def read_pdf(url)
    filename = "#{@doc_urls.index(url)}.pdf"
    result = {}
    result['url'] = url
    reader = PDF::Reader.new(Rails.root.join('public', @folder_name, filename))
    result['pdf_version'] = reader.pdf_version
    result['info'] = reader.info
    result['metadata'] = reader.metadata
    result['page_count'] = reader.page_count
    @pdf_metadata.push(result)
  end
end