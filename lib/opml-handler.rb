require 'nokogiri'

module OpmlHandler

  class Opml
    attr_reader :title, :content, :outlines_attributes

    def initialize(params={})
      @content = params[:content] || ""
      @outlines_attributes = params[:outlines_attributes] || []
      @title = params[:title] || "no title"
    end

    def outlines
      outlines_attributes.map { |data| OpmlHandler::Outline.new(data) }
    end

    def to_xml
      @content = begin
        builder = Nokogiri::XML::Builder.new(encoding: "UTF-8") do |xml|
          xml.opml(version: "1.0") do
            xml.head { xml.title title }
            xml.body { outlines.map { |outline| outline.to_xml(xml) } }
          end
        end
        builder.to_xml
      end
    end

    def to_hash
      doc = Nokogiri.XML(content)
      @title = doc.xpath("//head//title").children.first.text
      @outlines_attributes = nodes_to_hash(doc.xpath("//body//outline"))
    end

    def nodes_to_hash(nodes)
      [].tap do |outlines_attributes|
        nodes.each do |node|
          outline_attributes = node_to_hash(node)
          if outline_attributes && node.children
            outline_attributes[:children] = nodes_to_hash(node.children)
          end
          outlines_attributes << outline_attributes
        end
      end.compact
    end

    def node_to_hash(node)
      return nil if node.attributes.empty?
      {}.tap do |attributes|
        node.attributes.each do |k, v|
          attributes[k.to_sym] = v.value
        end
      end
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