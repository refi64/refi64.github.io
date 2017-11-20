shopt -s extglob


task_default() {
  bask_log_error "No default task."
  false
}


task_pygments() {
  pygmentize -S friendly -f html -a .highlight > web/dist/pygments.css
}


task_pack_debug() {
  bask_depends pygments
  aspen
}


task_pack_release() {
  bask_depends pygments
  aspen -m prod
}


task_build_debug() {
  bask_depends pack_debug
  pub build --mode debug
}


task_build_cleanup() {
  rm -rf build/web/!(*initialize).dart.js \
         build/web/packages \
         build/web/pages/packages \
         build/web/dist/pygments.css \
         build/web/analytics.js \
         build/web/styles.css
}


task_build_release() {
  bask_depends pack_release
  pub build --mode release
}


task_deploy() {
  bask_depends build_cleanup

  [ -d deploy ] || git clone https://github.com/kirbyfan64/kirbyfan64.github.io deploy
  cd deploy

  git pull
  git rm -r * 2>/dev/null ||:
  cp -r ../build/web/* .
  touch .nojekyll

  git add .
  git commit -am "deploy $1 on `date '+%Y-%m-%d-%H:%M:%S-UTC:%z'`"
  git push
}


task_build_deploy() {
  bask_depends build_release
  bask_depends deploy
}
