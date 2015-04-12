require File.expand_path("mailchimp_template/version", __dir__)

class MailchimpTemplate
  def initialize(template)
    @template = template
  end

  def render(merge_tags: {}, regions: {})
    result = @template.dup

    result.gsub! /\*\|(?<tag_name>.+?)\|\*/ do |match|
      case $~[:tag_name]
        #TODO: support dynamic merge tags
      when "CURRENT_YEAR"
        Date.today.year
      else
        merge_tags[$~[:tag_name]]
      end
    end

    return result
  end

  def merge_tags
    @template.scan(/\*\|(?<tag_name>.+?)\|\*/).flatten
  end
end
