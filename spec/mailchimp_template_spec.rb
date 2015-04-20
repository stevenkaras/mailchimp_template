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

end
