Pod::Spec.new do |s|

  s.name         = "JMHoledView"
  s.version      = "0.0.1"
  s.summary      = "UIView subclass designed to be filled with holes"
  s.requires_arc = true

  s.description  = <<-DESC
                   JMHoledView is a UIView subclass. Holes can be configured and a delegate method is triggered on user interaction.
                   DESC

  s.homepage     = "https://github.com/leverdeterre/JMHoledView"
  s.screenshots  = "https://github.com/leverdeterre/JMHoledView/screenshots/demo1.png"

  s.license      = 'MIT'
  s.author       = { "jerome Morissard" => "morissardj@gmail.com" }
  s.platform     = :ios, '4.3'
  s.source       = { :git => "https://github.com/leverdeterre/JMHoledView.git", :tag => "0.0.1" }
  s.source_files = 'Classes', 'JMHoledView/JMHoledView/*.{h,m}'
  s.public_header_files = 'JMHoledView/JMHoledView/*.h'
end
