module.exports = (grunt) ->
  'use strict'

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
  grunt.loadNpmTasks('grunt-exec')
  grunt.loadNpmTasks('grunt-git')
  grunt.loadTasks('./tasks')

  # Define Tasks
  grunt.registerTask('default', ['build', 'server'])
  grunt.registerTask('build', ['clean:build', 'copy', 'stylesheets', 'scripts', 'jade', 'texturepacker'])
  grunt.registerTask('release', ['build', 'uglify', 'upload'])
  grunt.registerTask('scripts', ['coffee', 'concat', 'clean:scripts'])
  grunt.registerTask('server', ['express', 'open', 'watch'])
  grunt.registerTask('stylesheets', ['stylus', 'autoprefixer', 'cssmin', 'clean:stylesheets'])

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
      all:
        scripts:
          src: [ 'build/assets/js/**/*' ]
        stylesheets:
          src: [ 'build/assets/css/**/*' ]
        atlas:
          src: [ 'build/atlas/*' ]
      build:
        src: ['build/**/*', '!build/.git']
      scripts:
        src: [ 'build/assets/js/**/*', '!build/assets/js/game.*', '!build/assets/js/phaser.*' ]
      stylesheets:
        src: [ 'build/assets/css/**/*', '!build/assets/css/game.css' ]

    coffee:
      build:
        options:
          bare: true
          join: true
          sourceMap: true
        expand: true
        files:
          'build/assets/js/game.js': [ 'source/assets/js/**/*.coffee' ]

    concat:
      build:
        src: [ 'build/**/*.js', '!build/assets/js/phaser.*' ]
        dest: 'build/assets/js/game.js'

    copy:
      build:
        cwd: 'source'
        src: ['**', '!**/*.styl', '!**/*.coffee', '!**/*.jade', '!assets/animations/**', '!**/.git*']
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
          'build/assets/css/game.css': [ 'build/**/*.css' ]

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

    texturepacker:
      build:
        src: 'source/assets/animations/*'
        dest: 'build/assets/atlas'

    uglify:
      build:
        options:
          mangle: false
        files:
          'build/assets/js/game.js': [ 'build/**/*.js' ]

    upload:
      release:
        src: 'build'

    watch:
      stylesheets:
        files: 'source/**/*.styl'
        tasks: [ 'clean:all:stylesheets', 'stylesheets' ]
        options:
          livereload: true
      scripts:
        files: 'source/**/*.coffee'
        tasks: [ 'clean:all:scripts', 'scripts' ]
        options:
          livereload: true
      jade:
        files: 'source/**/*.jade'
        tasks: [ 'jade' ]
        options:
          livereload: true
      atlas:
        files: [ 'source/assets/animations/**/*.png' ]
        tasks: ['clean:all:atlas', 'texturepacker']
        options:
          livereload: true
      copy:
        files: [ 'source/**', '!source/**/*.styl', '!source/**/*.coffee', '!source/**/*.jade', '!source/assets/animations/**/*.png' ]
        tasks: [ 'copy' ]
