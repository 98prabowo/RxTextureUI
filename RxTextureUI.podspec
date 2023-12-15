Pod::Spec.new do |spec|
  spec.name         = "RxTextureUI"
  spec.version      = "0.1.5"
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
  
  spec.dependency 'RxCocoaRuntime', '0.0.1'
  spec.dependency 'RxCocoa', '~> 6.5'
  spec.dependency 'RxSwift', '~> 6.5'
  spec.dependency 'TextureSwiftSupport', '~> 3.19'
  spec.xcconfig = { 'ENABLE_BITCODE' => 'NO' }
end
