require 'firebase'
firebase = Firebase::Client.new('https://vivochatbot.firebaseio.com')
response = firebase.push("todos", { :name => 'Pick the milk', :priority => 1 })
puts response.success? # => true
puts response.code # => 200
puts response.body # => { 'name' => "-INOQPH-aV_psbk3ZXEX" }
puts response.raw_body # => '{"name":"-INOQPH-aV_psbk3ZXEX"}'
