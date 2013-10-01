module.exports = (grunt) ->

  dev:
    files: [
      expand: true
      dot: true
      cwd: "<%= appConfig.app %>"
      dest: "<%= appConfig.dev %>"
      src: [
        "*.{ico,txt}"
        "**/*.html"
        "components/**/*"
        "images/**/*.{gif,webp}"
        "styles/fonts/*"
      ]
    ]

  # copy fonts to the dist directory
  dist:
    files: [
      expand: true
      dot: true
      cwd: "bower_components/font-awesome"
      dest: "<%= appConfig.dist %>"
      src: [
        "font/**/*"
      ]
    ]
