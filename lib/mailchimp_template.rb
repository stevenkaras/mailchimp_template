require File.expand_path("mailchimp_template/version", __dir__)

require "nokogiri"

class MailchimpTemplate
  def initialize(template)
    @template = template
  end

  def render(options = {})
    merge_tags = options.delete(:merge_tags)
    regions = options.delete(:regions)
    result = @template
    result = render_regions(result, regions)
    return render_merge_tags(result, merge_tags)
  end

  def merge_tags
    @template.scan(/\*\|(?<tag_name>.+?)\|\*/).flatten
  end

  def render_regions(template, regions = {})
    html = Nokogiri::HTML::DocumentFragment.parse(template)
    html.css("*").select { |n| n.attr("mc:edit") }.each do |editable_region|
      editable_region.children = Nokogiri::HTML::DocumentFragment.parse(regions[editable_region.attr("mc:edit")])
      editable_region.remove_attribute("mc:edit")
    end
    result = html.to_s
  end

  def render_merge_tags(template, merge_tags = {})
    # | is %7C when escaped by Nokogiri
    template.gsub! /\*(?:\||%7C)(?<tag_name>.+?)(?:\||%7C)\*/ do |match|
      tag_name = $~[:tag_name]
      case tag_name
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
        merge_tags[tag_name] || match
      end
    end
  end
end
