Pod::Spec.new do |s|

  s.name         = "JMHoledView"
  s.version      = "0.2.0"
  s.summary      = "UIView subclass designed to be filled with holes"
  s.requires_arc = true

  s.description  = <<-DESC
                   JMHoledView is a UIView subclass. Holes can be configured and a delegate method is triggered on user interaction.
                   DESC

  s.homepage     = "https://github.com/leverdeterre/JMHoledView"
  s.screenshots  = "https://raw.githubusercontent.com/leverdeterre/JMHoledView/master/screenshots/demo1.png"

  s.license      = 'MIT'
  s.author       = { "jerome Morissard" => "morissardj@gmail.com" }
  s.platform     = :ios, '5.0'
  s.source       = { :git => "https://github.com/leverdeterre/JMHoledView.git", :tag => "0.2.0" }
  s.source_files = 'Classes', 'JMHoledView/JMHoledView/*.{h,m}'
  s.public_header_files = 'JMHoledView/JMHoledView/*.h'
end
