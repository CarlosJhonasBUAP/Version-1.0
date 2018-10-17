# Echo_Server --
#	Open the server listening socket
#	and enter the Tcl event loop
#
# Arguments:
#	port	The server's port number

proc Echo_Server {port} {
    catch set s [socket -server EchoAccept $port]
    vwait forever
}

# Echo_Accept --
#	Accept a connection from a new client.
#	This is called after a new socket connection
#	has been created by Tcl.
#
# Arguments:
#	sock	The new socket connection to the client
#	addr	The client's IP address
#	port	The client's port number
	
proc EchoAccept {sock addr port} {
    global echo

    # Record the client's information

    set status "Accept $sock from $addr port $port"
    .estado insert end $status
    .estado insert end "\n"
    set echo(addr,$sock) [list $addr $port]

    # Ensure that each "puts" by the server
    # results in a network transmission

    fconfigure $sock -buffering line

    # Set up a callback for when the client sends data

    fileevent $sock readable [list Echo $sock]
}

# Echo --
#	This procedure is called when the server
#	can read data from the client
#
# Arguments:
#	sock	The socket connection to the client

proc Echo {sock} {
    global echo

    # Check end of file or abnormal connection drop,
    # then echo data back to the client.
    if {[eof $sock] || [catch {gets $sock line}]} {
	close $sock
	set status "Close $echo(addr,$sock)"
    .estado insert end $status
    .estado insert end "\n"
	unset echo(addr,$sock)
    } else {
    .mensaje_r insert 1.0 $line
    .mensaje_r insert 1.0 "\n"
	puts $sock $line
    }
}

proc finish {} {
    tk_messageBox -message "Desconectar servidor" -title "Finish Server" -icon info
    exit 1
}