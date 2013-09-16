PeakSqlite
==========

给FMDB再加一层，封装Sqlite常用的增删改查，主要针对单表操作。项目中包括一个TODO的简单示例，包括对sqlite的增删改查。 


#Information

Conis

Blog: [http://iove.net](http://iove.net)

E-mail: [conis.yi@gmail.com](conis.yi@gmail.com)

#Usage
自用项目，暂时没有时间写使用说明，请参考代码，代码中有较详细的注释，欢迎Fork或者翻译。

建议结合我的另一个项目[peaksqlite-entity-maker](https://github.com/conis/peaksqlite-entity-maker)使用。

#关于peaksqlite-entity-maker

`peaksqlite-entity-maker`可以根据Sqlite自动生成`PeakSqlite`的实体代码。`peaksqlite-entity-maker`需要安装Node.js环境。
·

1. 安装Node.js和npm
2. 用`npm install -g peaksqlite-entity-maker` 安装，建议全局安全模式
3. 在项目中创建`PeakSqlite.json`的配置文件，请参考PeakSqlite/PeakSqlite.json
4. `cd`到项目文件，运行`peaksqlite`
5. Done!如果没有意外，代码已经被自动生成了

更多请访问项目：[peaksqlite-entity-maker](https://github.com/conis/peaksqlite-entity-maker)

#
LICENSE

MIT

