Pod::Spec.new do |s|
  s.name         = "PeakSqlite"
  s.preferred_dependency = 'FMDB'
  s.version      = "1.0.0"
  s.summary      = "给FMDB再加一层，封装Sqlite常用的增删改查，主要针对单表操作 ."
  s.homepage     = "https://github.com/conis/PeakSqlite"
  s.license      = 'MIT'
  s.author       = { "Conis" => "conis.yi@gmail.com" }
  s.source       = { :git => "https://github.com/conis/PeakSqlite.git", :tag => "v1.0.0"}
  s.platform     = :ios, '4.0'
  s.source_files = '*.{h,m}'
  s.framework  = 'UIKit'
  s.requires_arc = true
end
