# gulp file for compiling less to css
gulp = require 'gulp'
concat = require 'gulp-concat'
less = require 'gulp-less'
gutil = require 'gulp-util'

lessGlob = './adcolony/less/**/*.less'

# Handle errors in standard way
#
# @param [String] label Just a label to know where the error came from
getErrorHandler = (label) ->
  (err) ->
    gutil.log "#{label} error -- #{err.toString()}"
    gutil.log err.stack
    #    exec("osascript -e 'tell app \"Terminal\" to say \"#{label} error, #{err.message}\"'")
    gutil.beep()
    @emit 'end'

gulp.task 'less', ->
  gulp.src('./adcolony/less/adcolony-bootstrap.less')
  .pipe(less())
  .on('error', getErrorHandler('Less'))
  .pipe(concat('adcolony.css'))
  .pipe(gulp.dest('./adcolony/css/'))

gulp.task 'watch', ['less'], ->
  gulp.watch([lessGlob], ['less'])
  .on('change', (e) -> console.log e)

gulp.task 'default', ['watch']