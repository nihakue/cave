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
      scripts:
        src: [ 'build/**/*.js', '!build/assets/js/application.js', '!build/assets/js/phaser.min.js' ]

    coffee:
      build:
        bare: true
        expand: true
        cwd: 'source'
        src: [ '**/*.coffee' ]
        dest: 'build',
        ext: '.js'

    connect:
      server:
        options:
          base: 'build'
          hostname: '*'
          port: 4000

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
        tasks: [ 'stylesheets' ]
      scripts:
        files: 'source/**/*.coffee'
        tasks: [ 'scripts' ]
      jade:
        files: 'source/**/*.jade'
        tasks: [ 'jade' ]
      copy:
        files: [ 'source/**', '!source/**/*.styl', '!source/**/*.coffee', '!source/**/*.jade' ]
        tasks: [ 'copy' ]

  # Load Tasks
  grunt.loadNpmTasks('grunt-autoprefixer')
  grunt.loadNpmTasks('grunt-contrib-clean')
  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-contrib-connect')
  grunt.loadNpmTasks('grunt-contrib-copy')
  grunt.loadNpmTasks('grunt-contrib-cssmin')
  grunt.loadNpmTasks('grunt-contrib-jade')
  grunt.loadNpmTasks('grunt-contrib-stylus')
  grunt.loadNpmTasks('grunt-contrib-uglify')
  grunt.loadNpmTasks('grunt-contrib-watch')

  # Define Tasks
  grunt.registerTask('stylesheets', ['stylus', 'autoprefixer', 'cssmin', 'clean:stylesheets'])
  grunt.registerTask('scripts', ['coffee', 'uglify', 'clean:scripts'])
  grunt.registerTask('build', ['clean:build', 'copy', 'stylesheets', 'scripts', 'jade'])
  grunt.registerTask('default', ['build', 'connect', 'watch'])
