# madbomber/homebrew-justprep/main.just

include ~/.justfile

justprep_main     := env_var('HOME') + '/sandbox/git_repos/madbomber/justprep/main'

fn_latest_version := "gh release list --exclude-drafts -L 1 | cut -f1"
fn_last_tag       := "git tag --list --sort v:refname | tail -1"

# temp
temp:
  #!/usr/bin/env bash
  cd {{justprep_main}}
  #
  echo "latest_version .. `{{fn_latest_version}}`"
  echo "last_tag ........ `{{fn_last_tag}}`"


# TODO
@todo:
  echo "[x] get latest version from justprep rep"
  echo "[ ] create a new branch named with the version"
  echo "[ ] download source tarball"
  echo "[x] get sha256 of the tarball using" 
  echo "      a_line = 'shasum -a 256 <tarball_path>'"
  echo "[ ] extract value from a_line.split().first"
  echo "[ ] update formula with new URL and SHA256"
  echo "[ ] git add justprep.rb"
  echo "[ ] git commit -m "publishing <version>"
  echo "[ ] git push"
  echo "[ ] create a new pull request using 'gh pr create' against "main"
  echo "[ ] monitor the pr using 'gh pr checks' "
  echo "[ ] watch the number of pending checks when zero continue"
  echo "[ ] if any check failed, fail the task"
  echo "[ ] when all checks are green, label the pull request as pr-pull"
  echo "[ ] nonitor the checks/status of the pr"
  echo "[ ] when all checks are successfully, expect the pr to auto "close"



# Download assets
@download:
  #!/usr/bin/env bash
  cd {{justprep_main}}
  version=`{{fn_latest_version}}`
  echo "Downloading $version binaries ..."
  gh release download $version -D ~/Downloads
  
  echo "Downloading $version source ..."
  gh release download $version -D ~/Downloads --archive tar.gz


# Calculate_sha256 for latest assets
calc_sha256: download
  #!/usr/bin/env bash
  cd ~/Downloads
  echo "Creating bottle block ..."
  #
  echo "bottle do" > bottle.rb
  for file in justprep-*
  do
  	echo "  $file ..."
  	shasum -a 256 $file >> bottle.rb
  done
  echo "end" >> bottle.rb



