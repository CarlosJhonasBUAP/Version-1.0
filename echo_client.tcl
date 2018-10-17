#
# A client of the echo service.
#
proc Echo_Client {host port} {
    if { 1 == [ catch {set s [socket $host $port]}  errormsg ] } {
	    tk_messageBox -message "Error de conexion \n errormsg " -title "Finish service" -icon warning
    } else {
    	
		fconfigure $s -buffering line
    	set ::conectado yes
		.estado insert end "El servidor aceptó la conexion "
    	.estado insert end "\n"
    	return $s
   	}
}

proc finish {} {
    tk_messageBox -message "Desconectar Cliente" -title "Finish service" -icon info
    exit 1
}

# A sample client session looks like this
#   set s [Echo_Client localhost 2540]
#   puts $s "Hello!"
#   gets $s line
