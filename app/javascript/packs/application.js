/**
* Prospero
*
* You should have received a copy of the license along with this program.
*
* Licensed under
* - GNU Affero General Public License V3
* - CeCILL Affero compliant
*/

/**
* Application main JavaScript pack.
*
* See https://github.com/rails/webpacker
*/

require("turbolinks").start();
var ReactRailsUJS = require("react_ujs");
var componentRequireContext = require.context("components", false);

ReactRailsUJS.useContext(componentRequireContext);
