Pod::Spec.new do |s|
  s.name          = 'RSKImage'
  s.version       = '1.0.0'
  s.summary       = 'The type of object that represents an image.'
  s.description   = <<-DESC
                   The type of object that represents an image. RSKImage provides the initializers to create an image with cgImage (the underlying Quartz image data) and cgPath (the path that consists of straight and curved line segments that represent the shape of the image) that are created from the specified parameters, in particular, from color, linear gradient, size, corner radii.
                   DESC
  s.homepage      = 'https://github.com/rsk-lab/RSKImage'
  s.license       = { :type => 'RPL-1.5 / R.SK Lab Professional', :file => 'COPYRIGHT.md' }
  s.authors       = { 'Ruslan Skorb' => 'ruslan@rsk-lab.com' }
  s.source        = { :git => 'https://github.com/rsk-lab/RSKImage.git', :tag => s.version.to_s }
  s.platform      = :ios, '10.0'
  s.swift_version = '5.3'
  s.source_files  = 'RSKImage/*.{h,swift}'
  s.requires_arc  = true
  s.dependency 'RSKBezierPath', '1.0.0'
end
