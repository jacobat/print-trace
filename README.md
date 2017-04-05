print-trace.rb
==============

This is a simple script that will convert a backtrace in Rollbar format into
the corresponding code. It's very hackish and incomplete at this point.

As of now it puts a few heavy requirements on the user (patches are welcome):

1. You must have a file called `trace.txt` in Rollbar format.
2. You must have your gems installed in `/usr/local/lib/ruby/gems/2.3.0/gems/`

Installation
------------

Clone the repos and run it somewhere suitable.

Usage
-----

```sh
$ ruby trace.rb
```

Example input
-------------

This could be the input file `trace.txt`:

```
1
File "/data/hello_world/current/vendor/bundle/ruby/2.3.0/gems/actionpack-5.0.0.1/lib/action_dispatch/http/parameters.rb" line 63 in parse_formatted_parameters
2
File "/data/hello_world/current/vendor/bundle/ruby/2.3.0/gems/actionpack-5.0.0.1/lib/action_dispatch/http/request.rb" line 366 in block in POST
3
File "/data/hello_world/current/vendor/bundle/ruby/2.3.0/gems/rack-2.0.1/lib/rack/request.rb" line 57 in fetch
4
File "/data/hello_world/current/vendor/bundle/ruby/2.3.0/gems/rack-2.0.1/lib/rack/request.rb" line 57 in fetch_header
5
File "/data/hello_world/current/vendor/bundle/ruby/2.3.0/gems/actionpack-5.0.0.1/lib/action_dispatch/http/request.rb" line 365 in POST
6
File "/data/hello_world/current/vendor/bundle/ruby/2.3.0/gems/actionpack-5.0.0.1/lib/action_dispatch/http/parameters.rb" line 35 in parameters
7
File "/data/hello_world/current/vendor/bundle/ruby/2.3.0/gems/actionpack-5.0.0.1/lib/action_dispatch/http/filter_parameters.rb" line 41 in filtered_parameters
8
File "/data/hello_world/current/vendor/bundle/ruby/2.3.0/gems/actionpack-5.0.0.1/lib/action_controller/metal/instrumentation.rb" line 21 in process_action
9
File "/data/hello_world/current/vendor/bundle/ruby/2.3.0/gems/actionpack-5.0.0.1/lib/action_controller/metal/params_wrapper.rb" line 248 in process_action
10
File "/data/hello_world/current/vendor/bundle/ruby/2.3.0/gems/activerecord-5.0.0.1/lib/active_record/railties/controller_runtime.rb" line 18 in process_action
11
File "/data/hello_world/current/vendor/bundle/ruby/2.3.0/gems/actionpack-5.0.0.1/lib/abstract_controller/base.rb" line 126 in process
12
File "/data/hello_world/current/vendor/bundle/ruby/2.3.0/gems/actionview-5.0.0.1/lib/action_view/rendering.rb" line 30 in process
13
File "/data/hello_world/current/vendor/bundle/ruby/2.3.0/gems/actionpack-5.0.0.1/lib/action_controller/metal.rb" line 190 in dispatch
14
File "/data/hello_world/current/vendor/bundle/ruby/2.3.0/gems/actionpack-5.0.0.1/lib/action_controller/metal.rb" line 262 in dispatch
15
File "/data/hello_world/current/vendor/bundle/ruby/2.3.0/gems/actionpack-5.0.0.1/lib/action_dispatch/routing/route_set.rb" line 50 in dispatch
16
File "/data/hello_world/current/vendor/bundle/ruby/2.3.0/gems/actionpack-5.0.0.1/lib/action_dispatch/routing/route_set.rb" line 32 in serve
17
File "/data/hello_world/current/vendor/bundle/ruby/2.3.0/gems/actionpack-5.0.0.1/lib/action_dispatch/journey/router.rb" line 39 in block in serve
18
File "/data/hello_world/current/vendor/bundle/ruby/2.3.0/gems/actionpack-5.0.0.1/lib/action_dispatch/journey/router.rb" line 26 in each
19
File "/data/hello_world/current/vendor/bundle/ruby/2.3.0/gems/actionpack-5.0.0.1/lib/action_dispatch/journey/router.rb" line 26 in serve
20
File "/data/hello_world/current/vendor/bundle/ruby/2.3.0/gems/actionpack-5.0.0.1/lib/action_dispatch/routing/route_set.rb" line 725 in call
21
File "/data/hello_world/current/vendor/bundle/ruby/2.3.0/gems/newrelic_rpm-3.15.2.317/lib/new_relic/agent/instrumentation/middleware_tracing.rb" line 96 in call
22
File "/data/hello_world/current/vendor/bundle/ruby/2.3.0/gems/rack-oauth2-1.3.1/lib/rack/oauth2/server/resource.rb" line 20 in call
23
File "/data/hello_world/current/vendor/bundle/ruby/2.3.0/gems/rack-oauth2-1.3.1/lib/rack/oauth2/server/resource/mac.rb" line 8 in call
24
File "/data/hello_world/current/vendor/bundle/ruby/2.3.0/gems/newrelic_rpm-3.15.2.317/lib/new_relic/agent/instrumentation/middleware_tracing.rb" line 96 in call
25
File "/data/hello_world/current/vendor/bundle/ruby/2.3.0/gems/rack-oauth2-1.3.1/lib/rack/oauth2/server/resource.rb" line 20 in call
26
File "/data/hello_world/current/vendor/bundle/ruby/2.3.0/gems/rack-oauth2-1.3.1/lib/rack/oauth2/server/resource/bearer.rb" line 8 in call
27
File "/data/hello_world/current/vendor/bundle/ruby/2.3.0/gems/newrelic_rpm-3.15.2.317/lib/new_relic/agent/instrumentation/middleware_tracing.rb" line 96 in call
28
```


Example output
--------------

With the above input file the following output might be produced:

```
/usr/local/lib/ruby/gems/2.3.0/gems/actionpack-5.0.0.1/lib/action_dispatch/http/parameters.rb:63

        strategy = parsers.fetch(content_mime_type.symbol) { return yield }

 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
/usr/local/lib/ruby/gems/2.3.0/gems/actionpack-5.0.0.1/lib/action_dispatch/http/request.rb:366
      fetch_header("action_dispatch.request.request_parameters") do
        pr = parse_formatted_parameters(params_parsers) do |params|
          super || {}
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
/usr/local/lib/ruby/gems/2.3.0/gems/rack-2.0.1/lib/rack/request.rb:57
      def fetch_header(name, &block)
        @env.fetch(name, &block)
      end
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
/usr/local/lib/ruby/gems/2.3.0/gems/rack-2.0.1/lib/rack/request.rb:57
      def fetch_header(name, &block)
        @env.fetch(name, &block)
      end
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
/usr/local/lib/ruby/gems/2.3.0/gems/actionpack-5.0.0.1/lib/action_dispatch/http/request.rb:365
    def POST
      fetch_header("action_dispatch.request.request_parameters") do
        pr = parse_formatted_parameters(params_parsers) do |params|
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
/usr/local/lib/ruby/gems/2.3.0/gems/actionpack-5.0.0.1/lib/action_dispatch/http/parameters.rb:35
        params = begin
                   request_parameters.merge(query_parameters)
                 rescue EOFError
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
/usr/local/lib/ruby/gems/2.3.0/gems/actionpack-5.0.0.1/lib/action_dispatch/http/filter_parameters.rb:41
      def filtered_parameters
        @filtered_parameters ||= parameter_filter.filter(parameters)
      end
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
/usr/local/lib/ruby/gems/2.3.0/gems/actionpack-5.0.0.1/lib/action_controller/metal/instrumentation.rb:21
        :action     => self.action_name,
        :params     => request.filtered_parameters,
        :headers    => request.headers,
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
/usr/local/lib/ruby/gems/2.3.0/gems/actionpack-5.0.0.1/lib/action_controller/metal/params_wrapper.rb:248
      end
      super
    end
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
/usr/local/lib/ruby/gems/2.3.0/gems/activerecord-5.0.0.1/lib/active_record/railties/controller_runtime.rb:18
        ActiveRecord::LogSubscriber.reset_runtime
        super
      end
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
/usr/local/lib/ruby/gems/2.3.0/gems/actionpack-5.0.0.1/lib/abstract_controller/base.rb:126

      process_action(action_name, *args)
    end
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
/usr/local/lib/ruby/gems/2.3.0/gems/actionview-5.0.0.1/lib/action_view/rendering.rb:30
      old_config, I18n.config = I18n.config, I18nProxy.new(I18n.config, lookup_context)
      super
    ensure
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
/usr/local/lib/ruby/gems/2.3.0/gems/actionpack-5.0.0.1/lib/action_controller/metal.rb:190
      set_response!(response)
      process(name)
      request.commit_flash
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
/usr/local/lib/ruby/gems/2.3.0/gems/actionpack-5.0.0.1/lib/action_controller/metal.rb:262
      else
        new.dispatch(name, req, res)
      end
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
/usr/local/lib/ruby/gems/2.3.0/gems/actionpack-5.0.0.1/lib/action_dispatch/routing/route_set.rb:50
        def dispatch(controller, action, req, res)
          controller.dispatch(action, req, res)
        end
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
/usr/local/lib/ruby/gems/2.3.0/gems/actionpack-5.0.0.1/lib/action_dispatch/routing/route_set.rb:32
          res        = controller.make_response! req
          dispatch(controller, params[:action], req, res)
        rescue ActionController::RoutingError
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
/usr/local/lib/ruby/gems/2.3.0/gems/actionpack-5.0.0.1/lib/action_dispatch/journey/router.rb:39

          status, headers, body = route.app.serve(req)

 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
/usr/local/lib/ruby/gems/2.3.0/gems/actionpack-5.0.0.1/lib/action_dispatch/journey/router.rb:26
      def serve(req)
        find_routes(req).each do |match, parameters, route|
          set_params  = req.path_parameters
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
/usr/local/lib/ruby/gems/2.3.0/gems/actionpack-5.0.0.1/lib/action_dispatch/journey/router.rb:26
      def serve(req)
        find_routes(req).each do |match, parameters, route|
          set_params  = req.path_parameters
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
/usr/local/lib/ruby/gems/2.3.0/gems/actionpack-5.0.0.1/lib/action_dispatch/routing/route_set.rb:725
        req.path_info = Journey::Router::Utils.normalize_path(req.path_info)
        @router.serve(req)
      end
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
/usr/local/lib/ruby/gems/2.3.0/gems/newrelic_rpm-3.15.2.317/lib/new_relic/agent/instrumentation/middleware_tracing.rb:96

            result = (target == self) ? traced_call(env) : target.call(env)

 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
/usr/local/lib/ruby/gems/2.3.0/gems/rack-oauth2-1.3.1/lib/rack/oauth2/server/resource.rb:20
          end
          @app.call(env)
        rescue Rack::OAuth2::Server::Abstract::Error => e
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
/usr/local/lib/ruby/gems/2.3.0/gems/rack-oauth2-1.3.1/lib/rack/oauth2/server/resource/mac.rb:8
            self.request = Request.new(env)
            super
          end
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
/usr/local/lib/ruby/gems/2.3.0/gems/newrelic_rpm-3.15.2.317/lib/new_relic/agent/instrumentation/middleware_tracing.rb:96

            result = (target == self) ? traced_call(env) : target.call(env)

 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
/usr/local/lib/ruby/gems/2.3.0/gems/rack-oauth2-1.3.1/lib/rack/oauth2/server/resource.rb:20
          end
          @app.call(env)
        rescue Rack::OAuth2::Server::Abstract::Error => e
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
/usr/local/lib/ruby/gems/2.3.0/gems/rack-oauth2-1.3.1/lib/rack/oauth2/server/resource/bearer.rb:8
            self.request = Request.new(env)
            super
          end
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
/usr/local/lib/ruby/gems/2.3.0/gems/newrelic_rpm-3.15.2.317/lib/new_relic/agent/instrumentation/middleware_tracing.rb:96

            result = (target == self) ? traced_call(env) : target.call(env)

 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
```
