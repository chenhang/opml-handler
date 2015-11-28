require 'nokogiri'

module OpmlHandler

  class Opml
    attr_reader :title

    def initialize(outline_data=[], title='')
      @outline_data = outline_data
      @title = title
    end

    def outlines
      @outline_data.map { |data| OpmlHandler::Outline.new(data) }
    end

    def to_xml
      builder = Nokogiri::XML::Builder.new(encoding: "UTF-8") do |xml|
        xml.opml(version: "1.0") do
          xml.head { xml.title title }
          xml.body { outlines.map { |outline| outline.to_xml(xml) } }
        end
      end
      builder.to_xml
    end
  end

  class Outline
    attr_reader :attributes, :children

    def initialize(attributes={})
      children = attributes.delete(:children) || []
      @children = children.map { |child| Outline.new child }
      @attributes = attributes
    end

    def to_xml xml
      xml.outline(attributes) { children.map { |child| child.to_xml(xml) } }
    end
  end

end
