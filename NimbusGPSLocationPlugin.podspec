Pod::Spec.new do |spec|
  spec.name             = 'NimbusGPSLocationPlugin'
  spec.version          = '0.0.1'
  spec.summary          = 'A Nimbus plugin for GPS Location.'

  spec.description      = <<-DESC
  A plugin for the Nimbus framework to get GPS location coordinates for users.
                       DESC

  spec.homepage         = 'https://github.com/afischsf/nimbus-plugin-gps-location'
  spec.author           = { "Adam Fisch" => "afisch@salesforce.com" }
  spec.license          = 'BSD-3-Clause'
  spec.source           = { :git => 'https://github.com/afischsf/nimbus-plugin-gps-location.git', :branch => 'master' }

  spec.source_files     = 'platforms/ios/Sources/**/*.swift'
  spec.swift_version    = '5.0'

  spec.ios.deployment_target = '11.0'
  spec.dependency 'NimbusBridge'
end
