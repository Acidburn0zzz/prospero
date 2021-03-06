/**
* Prospero
*
* You should have received a copy of the license along with this program.
*
* Licensed under
* - GNU Affero General Public License V3
* - CeCILL Affero compliant
*/

/*
* Prospero backend service
*/

import Auth  from './auth';
import Users from './users';

export default {
  auth: () => new Auth(),
  users: (id) => new Users(id)
};
