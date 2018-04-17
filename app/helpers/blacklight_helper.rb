module BlacklightHelper
  include Blacklight::BlacklightHelperBehavior

  include FrontpageHelper

  def locale_picker(locale)
    paths = {
        '/nl/collections' => '/nl/collecties',
        '/en/collecties' => '/en/collections',
        '/nl/how-to-use' => '/nl/handleiding',
        '/en/handleiding' => '/en/how-to-use',
        '/nl/open-data' => '/nl/open-gegevens',
        '/en/open-gegevens' => '/en/open-data',
        '/nl/open-source' => '/nl/open-bron',
        '/en/open-bron' => '/en/open-source',
        '/nl/contact-en' => '/nl/contact-nl',
        '/en/contact-nl' => '/en/contact-en',
        '/nl/legal-notification' => '/nl/juridische-kennisgeving',
        '/en/juridische-kennisgeving' => '/en/legal-notification'
    }

    url = url_for(locale: locale)
    unless paths[url].nil?
        translated = paths[url]
        "#{translated}"
    else
        "#{url}"
    end
  end

  def render_image(document=@document, options ={})
    unless document.nil?
        representation_pid = document.fetch(:representation_pid)
        image_tag("#{representation_pid}")
    end
  end

  def render_technical_details(document=@document, options = {})
    return if document.nil?    
    @technical_details = []

    @technical_details << {
    	format: "Permalink",
    	url: solr_document_url(@document),
    	link: true
    }

    @technical_details << {
    	format: "Work PURL",
    	url: document.fetch(:work_pid),
    	link: false
    }

    @technical_details << {
    	format: "Data PURL",
    	url: document.fetch(:data_pid),
    	link: true
    }

    @technical_details << {
        format: "JSON",
        url: polymorphic_url(url_for_document(@document), format: 'json', only_path: false),
    	link: true
    }

    @technical_details << {
        format: "LIDO XML",
        url: polymorphic_url(url_for_document(@document), format: 'xml', only_path: false),
    	link: true
    }

    render partial: "catalog/technical_detail", collection: @technical_details
  end
end
