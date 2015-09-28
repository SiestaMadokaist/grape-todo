class API::V0::Web::Base < Grape::API

  def self.inherited(subclass)
    super
    subclass.instance_eval do
      # include( API::Errors )
      # include( Sembako::Constants )
      # include( API::Entities )
      version 'v0', :using => :header, :vendor => 'todo'
      format :json
    end
  end

  def self.fdoc_endpoint(endpoint_name)
    endpoint_path = Application.config.root + '/docs/fdoc/' + endpoint_name + '.fdoc'
    @fdocs ||= {}
    @fdocs[endpoint_name] ||= Fdoc::Endpoint.new(endpoint_path)
    Fdoc::MarkdownEndpointPresenter.new(@fdocs[endpoint_name]).to_markdown
  end
end
