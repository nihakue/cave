module.exports = (grunt) ->

  grunt.registerMultiTask(
    'texturepacker',
    'Pack directories as separate atlases',
    () ->
      dirs = grunt.file.expand(@data.src)
      console.log("Target dir: #{@data.dest}")
      console.log("Source dirs: #{dirs}")

      if not dirs? then grunt.log.writeln('Missing Source'); return false;

      targetDir = @data.dest
      if not targetDir?
        grunt.log.writeln('Missing Destination')
        return false

      if targetDir[targetDir.length - 1] isnt '/'
        targetDir += '/'

      tps = @data.tps ? false

      for dir, n in dirs
        if dir[dir.length - 1] isnt '/'
          dir += '/'

        dirList = dir.split('/')
        fileName = dirList[dirList.length - 2]

        cmd = 'TexturePacker '
        if not tps
          cmd +=
            '--data ' + targetDir + fileName + '.json ' +
            '--format json '+
            '--sheet ' + targetDir + fileName + '.png ' +
            '--trim-sprite-names ' +
            '--disable-rotation ' +
            '--multipack ' +
            '--padding 0 ' +
            dir + '*.png ';
        else
          cmd += dir + ' ' + tps;
      
        grunt.log.writeln("cmd: #{cmd}")

        grunt.config(
          "exec.#{fileName}",
          cmd: cmd,
          stdout: true,
          stderr: true
        )

      grunt.task.run('exec')
  )
