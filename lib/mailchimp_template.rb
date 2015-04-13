require File.expand_path("mailchimp_template/version", __dir__)

class MailchimpTemplate
  def initialize(template)
    @template = template
  end

  def render(merge_tags: {}, regions: {})
    result = @template.dup

    result.gsub! /\*\|(?<tag_name>.+?)\|\*/ do |match|
      case $~[:tag_name]
      when /^IF:(?<cond>.+)/, /^IFNOT:(?<cond>.+)/, /^ELSEIF:(?<cond>.+)/, "ELSE:", "END:IF"
        #TODO: handle conditional merge tags
        match
      when "MC:TOC"
        #TODO: generate TOC of h1 and h2 tags
        match
      when "MC:TOC_TEXT"
        #TODO: generate TOC of h1 and h2 tags, render as text
        match
      when /^DATE:(?<format>.+)/
        #TODO: render with PHP date format (nontrivial, requires a custom parser)
        match
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
