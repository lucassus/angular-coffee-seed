module.exports = (grunt) ->

  # copy resources from the app directory
  dev:
    files: [
      expand: true
      cwd: "<%= appConfig.app %>"
      dest: "<%= appConfig.dev %>"
      src: [
        "*.{ico,txt}"
        "**/*.js"
        "**/*.html"
        "images/**/*.{gif,webp}"
      ]
    ]

  # copy fonts to the dist directory
  dist:
    files: [
      expand: true
      cwd: "<%= appConfig.dev %>/components/font-awesome"
      dest: "<%= appConfig.dist %>"
      src: ["fonts/**/*"]
    ]
