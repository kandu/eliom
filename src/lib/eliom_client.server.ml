(* Ocsigen
 * http://www.ocsigen.org
 * Copyright (C) 2010 Vincent Balat
 * Copyright (C) 2011 Jérôme Vouillon, Grégoire Henry, Pierre Chambart
 * Copyright (C) 2012 Benedikt Becker
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, with linking exception;
 * either version 2.1 of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 *)

let is_client_app () = false

let server_function
    ?scope ?options ?charset ?code ?content_type ?headers ?secure_session ?name
    ?csrf_safe ?csrf_scope ?csrf_secure ?max_use ?timeout ?https ?error_handler
    argument_type f =
  Eliom_pervasives.mk_serv_fun
    (Ocaml.register_post_coservice'
       ?scope ?options ?charset ?code ?content_type ?headers ?secure_session
       ?name ?csrf_safe ?csrf_scope ?csrf_secure ?max_use ?timeout ?https
       ?error_handler
       ~post_params:Eliom_parameter.(ocaml "argument" argument_type)
       (fun () argument -> f argument))
    (Eliom_wrap.create_unwrapper
       (Eliom_wrap.id_of_int Eliom_common_base.server_function_unwrap_id_int))
