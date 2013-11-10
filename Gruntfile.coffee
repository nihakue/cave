module.exports = (grunt) ->

  # Config
  grunt.config.init
    pkg: grunt.file.readJSON('package.json')

    autoprefixer:
      build:
        expand: true
        cwd: 'build'
        src: [ '**/*.css' ]
        dest: 'build'

    clean:
      build:
        src: ['build']
      stylesheets:
        src: [ 'build/**/*.css', '!build/assets/css/application.css' ]
      css:
        src: [ 'build/assets/css/application.css' ]
      scripts:
        src: [ 'build/**/*.js', '!build/assets/js/application.js', '!build/assets/js/phaser*' ]
      js:
        src: [ 'build/assets/js/application.js' ]

    coffee:
      build:
        options:
          bare: true
        expand: true
        cwd: 'source'
        src: [ '**/*.coffee' ]
        dest: 'build',
        ext: '.js'

    concat:
      build:
        src: [ 'build/**/*.js' ]
        dest: 'build/assets/js/application.js'

    copy:
      build:
        cwd: 'source'
        src: ['**', '!**/*.styl', '!**/*.coffee', '!**/*.jade']
        dest: 'build'
        expand: true
      phaser:
        cwd: 'node_modules/Phaser/build'
        src: ['*.js']
        dest: 'build/assets/js'
        expand: true

    cssmin:
      build:
        files:
          'build/assets/css/application.css': [ 'build/**/*.css' ]

    express:
      server:
        options:
          port: 8000
          hostname: "*"
          bases: [ 'build' ]
          livereload: true

    jade:
      compile:
        options:
          data: {}
        files: [{
          expand: true
          cwd: 'source'
          src: [ '**/*.jade' ]
          dest: 'build'
          ext: '.html'
        }]

    open:
      build:
        path: 'http://localhost:<%= express.server.options.port%>'

    stylus:
      build:
        options:
          linenos: true
          compress: false
        files: [{
          expand: true
          cwd: 'source'
          src: [ '**/*.styl' ]
          dest: 'build'
          ext: '.css'
        }]

    uglify:
      build:
        options:
          mangle: false
        files:
          'build/assets/js/application.js': [ 'build/**/*.js' ]

    watch:
      stylesheets:
        files: 'source/**/*.styl'
        tasks: [ 'clean:css', 'stylesheets' ]
        options:
          livereload: true
      scripts:
        files: 'source/**/*.coffee'
        tasks: [ 'clean:js', 'scripts' ]
        options:
          livereload: true
      jade:
        files: 'source/**/*.jade'
        tasks: [ 'jade' ]
        options:
          livereload: true
      copy:
        files: [ 'source/**', '!source/**/*.styl', '!source/**/*.coffee', '!source/**/*.jade' ]
        tasks: [ 'copy' ]

  # Load Tasks
  grunt.loadNpmTasks('grunt-autoprefixer')
  grunt.loadNpmTasks('grunt-contrib-clean')
  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-contrib-concat')
  grunt.loadNpmTasks('grunt-contrib-copy')
  grunt.loadNpmTasks('grunt-contrib-cssmin')
  grunt.loadNpmTasks('grunt-contrib-jade')
  grunt.loadNpmTasks('grunt-contrib-stylus')
  grunt.loadNpmTasks('grunt-contrib-uglify')
  grunt.loadNpmTasks('grunt-contrib-watch')
  grunt.loadNpmTasks('grunt-express')
  grunt.loadNpmTasks('grunt-open')

  # Define Tasks
  grunt.registerTask('stylesheets', ['stylus', 'autoprefixer', 'cssmin', 'clean:stylesheets'])
  grunt.registerTask('scripts', ['coffee', 'concat', 'clean:scripts'])
  grunt.registerTask('server', ['express', 'open', 'watch'])
  grunt.registerTask('dev', ['clean:build', 'copy', 'stylesheets', 'scripts', 'jade'])
  grunt.registerTask('build', ['dev', 'uglify'])
  grunt.registerTask('default', ['dev', 'server'])
