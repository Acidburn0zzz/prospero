#!/usr/bin/env bash

# Prospero
#
# You should have received a copy of the license along with this program.
#
# Licensed under
# - GNU Affero General Public License V3
# - CeCILL Affero compliant

echo "Installing Foreman..."
source ~/.rvm/scripts/rvm
cd /srv/prospero
gem install foreman
