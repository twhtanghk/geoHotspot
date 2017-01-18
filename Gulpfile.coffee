argv = require('yargs').argv
gulp = require 'gulp'
browserify = require 'browserify'
source = require 'vinyl-source-stream'
coffee = require 'gulp-coffee'
gutil = require 'gulp-util'
sass = require 'gulp-sass'
minifyCss = require 'gulp-minify-css'
rename = require 'gulp-rename'
del = require 'del'
sh = require 'shelljs'

gulp.task 'default', ['sass', 'coffee']

gulp.task 'sass', (done) ->
  gulp.src('./scss/ionic.app.scss')
    .pipe(sass())
    .pipe(gulp.dest('./www/css/'))
    .pipe(minifyCss({
      keepSpecialComments: 0
    } ))
    .pipe(rename({ extname: '.min.css' } ))
    .pipe(gulp.dest('./www/css/'))

gulp.task 'coffee', ->
  browserify(entries: ['./www/js/index.coffee'])
    .transform('coffeeify')
    .transform('debowerify')
    .bundle()
    .pipe(source('index.js'))
    .pipe(gulp.dest('./www/js/'))

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
