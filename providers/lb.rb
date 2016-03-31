use_inline_resources if defined?(use_inline_resources)

action :create do
  #While there is no way to have an include directive for haproxy
  #configuration file, this provider will only modify attributes !
  listener = []
  listener << "bind #{new_resource.bind}" unless new_resource.bind.nil?
  listener << "balance #{new_resource.balance}" unless new_resource.balance.nil?
  listener << "mode #{new_resource.mode}" unless new_resource.mode.nil?
  listener << "maxconn #{new_resource.maxconn}" unless new_resource.maxconn.nil?
  listener += new_resource.servers.map {|server| "server #{server}" }

  if new_resource.params.is_a? Hash
    listener += new_resource.params.map { |k,v| "#{k} #{v}" }
  else
    listener += new_resource.params
  end

  listener += new_resource.options.map { |option| "option #{option}"}
  listener += new_resource.stats.map { |stats_i| "stats #{stats_i}"}

  node.default['haproxy']['listeners'][new_resource.type][new_resource.name] = listener
end
