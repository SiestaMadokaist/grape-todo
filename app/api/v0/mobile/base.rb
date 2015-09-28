class API::V0::Mobile::Base < Grape::API

  def self.inherited(subclass)
    super
    subclass.instance_eval do
        version(:v0, using: :header, vendor: 'todo_vendor')
        format(:json)
    end
  end

  def self.fdoc_endpoint(endpoint_name)
    endpoint_path = Application.config.root + '/docs/fdoc/' + endpoint_name + '.fdoc'
    @fdocs ||= {}
    @fdocs[endpoint_name] ||= Fdoc::Endpoint.new(endpoint_path)
    Fdoc::MarkdownEndpointPresenter.new(@fdocs[endpoint_name]).to_markdown
  end
end
