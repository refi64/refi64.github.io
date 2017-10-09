shopt -s extglob


task_default() {
  bask_log_error "No default task."
  false
}


pack() {
  mkdir -p web/dist
  local mode="$1"

  if [ "$mode" == "debug" ]; then
    local vue=vue.js
    local vuematerial=vue-material.debug.js
    local sharejs=share-button.js
    local sharecss=share-button.css
    local whendefined=whendefined.js
  else
    local vue=vue.min.js
    local vuematerial=vue-material.js
    local sharejs=share-button.min.js
    local sharecss=share-button.min.css
    local whendefined=whendefined.min.js
  fi

  cat node_modules/vue/dist/$vue node_modules/vue-material/dist/$vuematerial \
      node_modules/better-share-button/dist/$sharejs \
      node_modules/whendefined/dist/$whendefined web/analytics.js > web/dist/pack.js
  cat node_modules/vue-material/dist/vue-material.css \
      node_modules/better-share-button/dist/$sharecss web/styles.css \
      web/dist/pygments.css > web/dist/pack.css
}


task_pygments() {
  pygmentize -S friendly -f html -a .highlight > web/dist/pygments.css
}


task_pack_debug() {
  bask_depends pygments
  pack debug
}


task_pack_release() {
  bask_depends pygments
  pack release
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
