_ = require 'lodash'
gulp = require 'gulp'
browserify = require 'browserify'
source = require 'vinyl-source-stream'
coffee = require 'gulp-coffee'
gutil = require 'gulp-util'
sass = require 'gulp-sass'
rename = require 'gulp-rename'
del = require 'del'
sh = require 'shelljs'
fs = require 'fs'
util = require 'util'
templateCache = require 'gulp-angular-templatecache'

gulp.task 'default', ['css', 'coffee']

gulp.task 'config', ->
  params = _.pick process.env, 'ROOTURL', 'MAP_KEY', 'LAT', 'LNG', 'SCOPE'
  fs.writeFileSync 'www/js/config.json', util.inspect(params)

gulp.task 'css', ->
  gulp.src './scss/ionic.app.scss'
    .pipe sass()
    .pipe gulp.dest('./www/css/')

gulp.task 'coffee', ['config', 'template'], ->
  browserify(entries: ['./www/js/index.coffee'])
    .transform('coffeeify')
    .transform('debowerify')
    .bundle()
    .pipe(source('index.js'))
    .pipe(gulp.dest('./www/js/'))

gulp.task 'template', ->
  gulp.src 'www/templates/**/*.html'
    .pipe templateCache root: 'templates', standalone: true
    .pipe gulp.dest 'www/js'

gulp.task 'clean', ->
  del [
    'node_modules'
    'www/lib'
  ]

stream = require 'stream'
class Indent extends stream.Writable
  constructor: (opts = {objectMode: true, decodeStrings: false}) ->
    super opts

  _write: (file, encoding, cb) ->
    name = file.history
    sh.exec "sed 's/\t/  /g' < #{name} > /tmp/$$ && mv /tmp/$$ #{name}"
    cb()

gulp.task 'indent', ->
  gulp
    .src ['**/*.coffee', '!node_modules/**', '!www/lib/**']
    .pipe new Indent()
