
haproxy_lb 'stats' do
  bind ':8000'
  mode 'http'
  stats ['enable', 'uri /stats']
end
