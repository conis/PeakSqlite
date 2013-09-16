Pod::Spec.new do |s|
  s.name         = "PeakSqlite"
  s.version      = "0.1.1"
  s.summary      = "给FMDB再加一层，封装Sqlite常用的增删改查，主要针对单表操作 ."
  s.homepage     = "https://github.com/conis/PeakSqlite"
  s.license      = 'MIT'
  s.author       = { "Conis" => "conis.yi@gmail.com" }
  s.source       = { :git => "https://github.com/conis/PeakSqlite.git", :branch => "master"}
  s.platform     = :ios, '5.0'
  s.source_files = 'PeakSqlite/PeakSqlite.{h,m}'
  s.dependency  'FMDB'
  s.framework  = 'UIKit'
  s.requires_arc = true
end
