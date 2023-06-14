Pod::Spec.new do |spec|
  spec.name         = "RxTextureUI"
  spec.version      = "0.1.1"
  spec.summary      = "Reactive Extension Library for Texture"

  spec.description  = <<-DESC
  This Library is built to helps make Texture APIs used in iOS easier to use with reactive flow.
  DESC

  spec.homepage     = "https://github.com/98prabowo/RxTextureUI"
  spec.authors      = { "98prabowo" => "dimasprabowo98@icloud.com" }
  spec.source       = { :git => "https://github.com/98prabowo/RxTextureUI.git", :tag => "#{spec.version}" }
  spec.license      = { :type => "MIT", :file => "LICENSE" }
    
  spec.swift_version = '5.7'
  spec.ios.deployment_target = "11.0"

  spec.source_files  = "Sources/RxTextureUI/**/*.swift"

  spec.dependency 'RxCocoaRuntime', '6.5.0-xcframework'
  spec.dependency 'RxCocoa', '~> 6.5'
  spec.dependency 'RxSwift', '~> 6.5'
  spec.dependency 'Texture', '~> 3.1'
  spec.xcconfig = { 'ENABLE_BITCODE' => 'NO' }
end
