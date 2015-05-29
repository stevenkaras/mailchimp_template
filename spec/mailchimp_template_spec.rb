require File.expand_path('spec_helper', __dir__)

describe MailchimpTemplate do
  it 'has a version number' do
    expect(MailchimpTemplate::VERSION).not_to be nil
  end

  it 'should render merge tags' do
    result = MailchimpTemplate.new(nil).render_merge_tags("hello, *|MERGE|*", {"MERGE" => "world"})
    expect(result).to eq "hello, world"
  end

  it 'should render regions' do
    result = MailchimpTemplate.new(nil).render_regions("hello, <div mc:edit= 'body'>lorem ipsum</div>", {"body" => "world"})
    expect(result).to eq "hello, <div>world</div>"
  end

  it "should render merge tags that get clobbered by nokogiri" do
    result = MailchimpTemplate.new(nil).render_merge_tags('<img src="*%7CIMG_SOURCE%7C*">', {"IMG_SOURCE" => "http://example.com/image.png"})
    expect(result).to eq '<img src="http://example.com/image.png">'
  end

end
