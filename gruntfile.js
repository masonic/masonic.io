/*global module:false*/
module.exports = function (grunt) {
  'use strict';

  require('load-grunt-tasks')(grunt);
  require('time-grunt')(grunt);

  grunt.initConfig({
    conf: {
      in: 'src',
      out: 'dist'
    },
    pkg: grunt.file.readJSON('package.json'),
    clean: ['<%= conf.out %>'],
    connect: {
      server: {
        options: {
          port: 9000,
          base: '<%= conf.out %>',
        }
      }
    },
    copy: {
      main: {
        files: [ {expand: true, cwd: '<%= conf.in %>/', src: ['**'], dest: '<%= conf.out %>/'} ]
      }
    },
    jshint: {
      files: ['gruntfile.js']
    },
    watch: {
      files: ['<%= conf.in %>/**/*'],
      tasks: ['test', 'build'],
      options: {
        livereload: true
      }
    }
  });

  grunt.registerTask('build', ['clean', 'copy']);
  grunt.registerTask('test', ['jshint']);
  grunt.registerTask('serve', ['test', 'build', 'connect', 'watch']);
  grunt.registerTask('default', ['test', 'build']);
};
