Pod::Spec.new do |s|

  s.name    = 'DropMenu'
  s.version = '0.0.1'
  s.summary = '下拉选择视图、支持微信、支付宝等样式。自动计算最优显示位置、动画效果。'
  s.homepage  = 'https://github.com/song/DropMenu'
  s.license = 'MIT'
  s.authors = {'songhuangbo' =>  'songhuangbo@163.com'}
  s.platform  = :ios,'8.0'
  s.ios.deployment_target = '8.0'
  s.source  = {:git => 'https://github.com/song/DropMenu',:tag => s.version}
  s.source_files  = 'DropMenu/*.{h,m}', 'DropMenu/*.swift'
  # s.resources     = 'DropMenu/*.{png,xib,nib,bundle}'
  s.requires_arc  = true
  s.swift_version = '5.0'
end
