Pod::Spec.new do |s|
  s.name             = "RxCocoaRuntime"
  s.version          = "6.5.0-xcframework"
  s.summary          = "RxCocoaRuntime"
  s.description      = <<-DESC
  RxCocoaRuntime XCFramework spec
                        DESC
  s.homepage         = "https://github.com/ReactiveX/RxSwift"
  s.license          = "MIT"
  s.author           = { "98prabowo" => "dimasprabowo98@icloud.com" }
  s.source           = { :http => "https://github.com/ReactiveX/RxSwift/releases/download/6.2.0/#{s.name}.xcframework.zip" }

  s.requires_arc          = true

  s.ios.deployment_target = '9.0'

  s.vendored_frameworks = "#{s.name}.xcframework"

  s.dependency 'RxSwift', '~> 6.5'

  s.swift_version = '5.1'
end
