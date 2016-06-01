#!/bin/bash
#
### Ruby
# Use rbenv to install and manage versions

## rbenv plugins
# ruby-build-github
# https://github.com/parkr/ruby-build-github

[[ -d "$(rbenv root)/plugins/ruby-build-github" ]] || \
git clone git://github.com/parkr/ruby-build-github.git \
"$(rbenv root)/plugins/ruby-build-github"

# ruby-default-gems

[[ -L "$(rbenv root)/default-gems" ]] || \
ln -s "${REMDOT_CONFIG_DIR}/ruby/rbenv/default-gems" \
"$(rbenv root)/default-gems"

## rubies
# keep "*" indicator from fouling up grep
rbenv global system

# Latest github-flavored ruby
RUBY_GITHUB=$(rbenv install -l | grep "github" | tail -1)
if [[ "${RUBY_GITHUB}" != "$(rbenv versions | grep "github" | tail -1)" ]]; then
	RUBY_GITHUB=$(sed -e 's/^[[:space:]]*//' <<<"${RUBY_GITHUB}")
	rbenv install -v "${RUBY_GITHUB}"
fi

# Latest ruby stable
RUBY_STABLE=$(rbenv install -l | grep " \+[0-9]\.[0-9]\+\.[0-9]\+$" | tail -1)
if [[ "${RUBY_STABLE}" != "$(rbenv versions | grep " \+[0-9]\.[0-9]\+\.[0-9]\+$" | tail -1)" ]]
then
	RUBY_STABLE=$(sed -e 's/^[[:space:]]*//' <<<"${RUBY_STABLE}")
	rbenv install -v "${RUBY_STABLE}"
else
	RUBY_STABLE=$(sed -e 's/^[[:space:]]*//' <<<"${RUBY_STABLE}")
fi

rbenv global "${RUBY_STABLE}"
