module.exports = ( grunt ) ->
  pkg = grunt.file.readJSON "package.json"
  info =
    name: pkg.name.charAt(0).toUpperCase() + pkg.name.substring(1)
    version: pkg.version
  npmTasks = [
      "grunt-contrib-concat"
      "grunt-contrib-compass"
      "grunt-contrib-coffee"
      "grunt-contrib-uglify"
      "grunt-contrib-copy"
      "grunt-contrib-clean"
    ]

  grunt.initConfig
    repo: info
    pkg: pkg
    meta:
      src: "src"
      style: "<%= meta.src %>/stylesheets"
      script: "<%= meta.src %>/javascripts"
      dest: "dest"
      dest_style: "<%= meta.dest %>/stylesheets"
      dest_script: "<%= meta.dest %>/javascripts"
      dest_image: "<%= meta.dest %>/images"
      tests: "test"
    concat:
      progress:
        src: [
            "<%= meta.script %>/definition.coffee"
            "<%= meta.script %>/progress.coffee"
          ]
        dest: "<%= meta.script %>/vjsProgress.coffee"
    compass:
      compile:
        options:
          sassDir: "<%= meta.style %>"
          cssDir: "<%= meta.dest_style %>"
          javascriptsDir: "<%= meta.dest_script %>"
          imagesDir: "<%= meta.dest_image %>"
      test:
        options:
          sassDir: "<%= meta.style %>"
          cssDir: "<%= meta.tests %>/stylesheets"
          javascriptsDir: "<%= meta.tests %>/javascripts"
          imagesDir: "<%= meta.tests %>/images"
    coffee:
      options:
        bare: false
        separator: "\x20"
      build:
        src: "<%= meta.script %>/vjsProgress.coffee"
        dest: "<%= meta.dest_script %>/progress.js"
    uglify:
      options:
        banner: "/*!\n" +
                " * <%= repo.name %> v<%= repo.version %>\n" +
                " * <%= pkg.homepage %>\n" +
                " *\n" +
                " * Copyright 2014, <%= grunt.template.today('yyyy') %> Ourairyu, http://ourai.ws/\n" +
                " *\n" +
                " * Date: <%= grunt.template.today('yyyy-mm-dd') %>\n" +
                " */\n"
        sourceMap: true
      build:
        src: "<%= meta.dest_script %>/progress.js"
        dest: "<%= meta.dest_script %>/progress.min.js"
    copy:
      test:
        expand: true
        cwd: "<%= meta.dest_script %>"
        src: ["**.js"]
        dest: "<%= meta.tests %>"

  grunt.loadNpmTasks task for task in npmTasks

  grunt.registerTask "default", ["concat", "compass", "coffee", "uglify", "copy"]
