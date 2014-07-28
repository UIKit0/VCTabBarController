Pod::Spec.new do |spec|
  spec.name = 'VCTabBarController'
	spec.version = '1.0'
	spec.authors = {'Sam Soffes' => 'sam@soff.es'}
	spec.homepage = 'https://github.com/vc7/VCTabBarController'
	spec.summary = 'A custom tabbar controller'
	spec.source = {:git => 'https://github.com/vc7/VCTabBarController.git', :tag => 'v3.1.0' }
	spec.license = { :type => 'MIT', :file => 'LICENSE' }

	spec.platform = :ios, '7.0'
	spec.requires_arc = true
	spec.source_files = 'VCTabBarController'
end
