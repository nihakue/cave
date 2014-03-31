module.exports = (grunt) ->

  grunt.registerMultiTask(
    'upload',
    'run commit/push on a directory',
    () ->
      dir = @data.src
      comment = @data.comment ? 'Upload'
      remote = @data.remote ? 'origin'
      branch = @data.branch ? 'master'

      cmd_base = "git -C #{dir} "
      cmd_add = cmd_base + 'add -A'
      cmd_commit = cmd_base + "commit -am '#{comment}'"
      cmd_push = cmd_base + "push -f #{remote} #{branch}" 

      cmd = [cmd_add, cmd_commit, cmd_push].join(' && ')

      grunt.log.writeln("cmd: #{cmd}")

      grunt.config(
        "exec.#{dir}",
        cmd: cmd,
        stdout: true,
        stderr: true
      )

      grunt.task.run('exec')

  )