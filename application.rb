require File.expand_path('../environment', __FILE__)

module API
    module Entities
    end
    module V0
        module Web
        end
        module Mobile
        end
    end
    module V1
        module Web
        end
        module Mobile
        end
    end
end

dirs = [
    "#{File.dirname(__FILE__)}/helper",
    "#{File.dirname(__FILE__)}/app/entities/helper/*.rb",
    "#{File.dirname(__FILE__)}/app/entities/*.rb",
    "#{File.dirname(__FILE__)}/app/models/helper/*.rb",
    "#{File.dirname(__FILE__)}/app/models/*.rb",
    "#{File.dirname(__FILE__)}/app/api/helper/**/**/base.rb",
    "#{File.dirname(__FILE__)}/app/api/**/**.rb",
]
dirs.each{|s| Dir[s].each{|f| require f} }

class API::Root < Grape::API
    format(:json)

    namespace(:v0) do
        namespace(:mobile) do
            mount API::V0::Mobile::Todo
        end
        namespace(:web) do
            mount API::V0::Web::Todo
        end
    end
    namespace(:v1) do
        namespace(:mobile) do
        end
        namespace(:web) do
        end
    end


    add_swagger_documentation(
        hide_format: true,
        api_version: "v0",
        mount_path: "/api/docs"
    )
end

ApplicationServer = Rack::Builder.new do
    use Rack::Static, urls: [
        %r{.+swagger-ui/dist/.+},
        %r{.+swagger.json},
        %r{.*isml.html},
        %r{.*jquery.js}
    ], root: "public", index: 'index.html'


    map "/" do
        run API::Root
    end

end
